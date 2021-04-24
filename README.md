## FreePBX tftp server

This is an advanced tftp server that automatically generates config files for sip phones.

## How it works

FreePBX server syncs with Active Directory(AD). Binding users to phones is carried out through the fax field in the user properties from AD. The tftp server receives a request for a file of the form `SEP<MAC>.cfg.xml`, makes a request to the freepbx database, generates a config and sends it to the phone.

## Requirements:

* [go >= 1.16](https://golang.org)
* [FreePBX >= 15](https://www.freepbx.org)

## Flags:

```bash
Usage of ./freebpx-tftp-server:
  -freepbx-conf string
    	Set path to freepbx db connection config file (default "/etc/freepbx.conf")
  -sep-template-file string
    	Set path to sep template file (default "./sep-cisco.cnf.xml.tpl")
  -workdir string
    	Set working directory (default "/tftpboot")
```
