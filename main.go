package main

import (
	"bytes"
	"database/sql"
	"flag"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"path"
	"regexp"
	"strings"
	"text/template"

	_ "github.com/go-sql-driver/mysql"
	"github.com/pin/tftp"
)

var (
	workdir, sepTeplateFilePath, freepbxConf string
	sepTeplateFile                           []byte
	db                                       *sql.DB
)

//PhoneSetting struct
type PhoneSetting struct {
	DisplayName, PhonePassword string
	PhoneNumber                int
}

func getDBConnectionParams() (string, error) {
	var con string
	rex := regexp.MustCompile(`\["(.*)"\] = "(.*)";`)
	buf := new(bytes.Buffer)

	file, err := os.Open(freepbxConf)
	if err != nil {
		return con, err
	}
	defer file.Close()

	buf.ReadFrom(file)

	data := rex.FindAllStringSubmatch(buf.String(), -1)

	res := make(map[string]string)
	for _, kv := range data {
		k := kv[1]
		v := kv[2]
		res[k] = v
	}

	con = fmt.Sprintf("%s:%s@tcp(%s)/%s", res["AMPDBUSER"], res["AMPDBPASS"], res["AMPDBHOST"], res["AMPDBNAME"])

	return con, nil
}

//Getting phone setting from freepbx database
func getPhoneSetting(filename string) (*PhoneSetting, error) {
	var ps PhoneSetting

	filename = strings.TrimSuffix(filename, ".cnf.xml")
	query := `
	  SELECT userman_users.displayname, sip.data, userman_users.default_extension
      FROM userman_users
      LEFT JOIN sip
      ON userman_users.default_extension=sip.id AND sip.keyword='secret'
      WHERE userman_users.fax=?
      ORDER BY userman_users.default_extension
	  LIMIT 1
	  `

	err := db.QueryRow(query, filename).Scan(&ps.DisplayName, &ps.PhonePassword, &ps.PhoneNumber)

	if err != nil {
		return &ps, err
	}

	return &ps, nil
}

//Send file to client
func sendFile(file *bytes.Buffer, rf io.ReaderFrom) error {
	n, err := rf.ReadFrom(file)

	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		return err
	}
	fmt.Printf("%d bytes sent\n", n)
	return nil
}

//Reading file in tftp dir. If file not found, returning empty file
func readFile(filename string, rf io.ReaderFrom) error {
	var err error

	buf := new(bytes.Buffer)

	file, err := os.Open(path.Join(workdir, filename))
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
	} else {
		buf.ReadFrom(file)
	}
	defer file.Close()

	err = sendFile(buf, rf)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		return err
	}

	return nil
}

//Generating phone settings file use go-template
func genFile(filename string, rf io.ReaderFrom) error {
	var (
		tpl bytes.Buffer
		err error
	)

	p, err := getPhoneSetting(filename)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		return err
	}

	t := template.Must(template.New("sepTeplateFile").Parse(string(sepTeplateFile)))

	err = t.Execute(&tpl, p)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		return err
	}

	err = sendFile(&tpl, rf)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		return err
	}

	return nil
}

//Processing file request from a tftp client
func readHandler(filename string, rf io.ReaderFrom) error {
	raddr := rf.(tftp.OutgoingTransfer).RemoteAddr()
	laddr := rf.(tftp.RequestPacketInfo).LocalIP()
	fmt.Println("RRQ from:", raddr.String(), "To:", laddr.String(), "File:", filename)

	sepFile, err := path.Match("SEP*.cnf.xml", filename)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		return err
	}

	if sepFile {
		genFile(filename, rf)
	} else {
		readFile(filename, rf)
	}

	return nil
}

//Declaring cli flags
func init() {
	flag.StringVar(&workdir, "workdir", "/tftpboot", "Set working directory")
	flag.StringVar(&sepTeplateFilePath, "sep-template-file", "./sep-cisco.cnf.xml.tpl", "Set path to sep template file")
	flag.StringVar(&freepbxConf, "freepbx-conf", "/etc/freepbx.conf", "Set path to freepbx db connection config file")
}

func main() {
	var err error

	flag.Parse()

	sepTeplateFile, err = ioutil.ReadFile(sepTeplateFilePath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}

	//Getting params for db connection
	dbConnParams, err := getDBConnectionParams()
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}

	//Connicting to db
	db, err = sql.Open("mysql", dbConnParams)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error on initializing database connection: %s\n", err)
		os.Exit(1)
	}

	//Checking db connection
	err = db.Ping()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error on database connection: %s\n", err)
		os.Exit(1)
	}

	db.SetMaxIdleConns(10)

	fmt.Println("Starting freepbx tftp server")

	s := tftp.NewServer(readHandler, nil)
	err = s.ListenAndServe(":69")
	if err != nil {
		fmt.Fprintf(os.Stderr, "server: %v\n", err)
		os.Exit(1)
	}
}
