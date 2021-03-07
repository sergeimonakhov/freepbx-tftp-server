<?xml version="1.0" encoding="UTF-8"?>
<device>
   <devicePool>
      <dateTimeSetting>
         <dateTemplate>D.M.Y</dateTemplate>
         <timeZone>E. Europe Standard/Daylight Time</timeZone>
         <ntps>
            <ntp>
               <name>time.windows.com</name>
               <ntpMode>Unicast</ntpMode>
            </ntp>
         </ntps>
      </dateTimeSetting>
      <callManagerGroup>
         <members>
            <member priority="0">
               <callManager>
                  <ports>
                     <ethernetPhonePort>2000</ethernetPhonePort>
                  </ports>
                  <processNodeName>10.0.201.254</processNodeName>
               </callManager>
            </member>
         </members>
      </callManagerGroup>
   </devicePool>
   <commonProfile>
      <callLogBlfEnabled>3</callLogBlfEnabled>
   </commonProfile>
   <loadInformation>SIP6945.9-4-1-3</loadInformation>
   <userLocale>
      <name>Russian_Russia</name>
      <uid />
      <langCode>ru_RU</langCode>
      <version />
      <winCharSet>utf-8</winCharSet>
   </userLocale>
   <networkLocale>United_States</networkLocale>
   <networkLocaleInfo>
      <name>Russian_Russia</name>
   </networkLocaleInfo>
   <idleTimeout>0</idleTimeout>
   <authenticationURL />
   <directoryURL />
   <idleURL />
   <informationURL />
   <messagesURL />
   <proxyServerURL />
   <servicesURL />
   <capfAuthMode>0</capfAuthMode>
   <capfList>
      <capf>
         <phonePort>5060</phonePort>
         <processNodeName />
      </capf>
   </capfList>
   <deviceSecurityMode>1</deviceSecurityMode>
   <sipProfile>
      <sipCallFeatures>
         <cnfJoinEnabled>true</cnfJoinEnabled>
         <callForwardURI>x--serviceuri-cfwdall</callForwardURI>
         <callPickupURI>x-cisco-serviceuri-pickup</callPickupURI>
         <callPickupListURI>x-cisco-serviceuri-opickup</callPickupListURI>
         <callPickupGroupURI>x-cisco-serviceuri-gpickup</callPickupGroupURI>
         <meetMeServiceURI>x-cisco-serviceuri-meetme</meetMeServiceURI>
         <abbreviatedDialURI>x-cisco-serviceuri-abbrdial</abbreviatedDialURI>
         <rfc2543Hold>true</rfc2543Hold>
         <callHoldRingback>2</callHoldRingback>
         <localCfwdEnable>true</localCfwdEnable>
         <semiAttendedTransfer>true</semiAttendedTransfer>
         <anonymousCallBlock>2</anonymousCallBlock>
         <callerIdBlocking>0</callerIdBlocking>
         <dndControl>0</dndControl>
         <remoteCcEnable>true</remoteCcEnable>
      </sipCallFeatures>
      <sipStack>
         <sipInviteRetx>6</sipInviteRetx>
         <sipRetx>10</sipRetx>
         <timerInviteExpires>180</timerInviteExpires>
         <timerRegisterExpires>120</timerRegisterExpires>
         <timerRegisterDelta>5</timerRegisterDelta>
         <timerKeepAliveExpires>120</timerKeepAliveExpires>
         <timerSubscribeExpires>120</timerSubscribeExpires>
         <timerSubscribeDelta>5</timerSubscribeDelta>
         <timerT1>500</timerT1>
         <timerT2>4000</timerT2>
         <maxRedirects>70</maxRedirects>
         <remotePartyID>false</remotePartyID>
         <userInfo>None</userInfo>
      </sipStack>
      <autoAnswerTimer>1</autoAnswerTimer>
      <autoAnswerAltBehavior>false</autoAnswerAltBehavior>
      <autoAnswerOverride>true</autoAnswerOverride>
      <transferOnhookEnabled>true</transferOnhookEnabled>
      <enableVad>false</enableVad>
      <preferredCodec>g729</preferredCodec>
      <dtmfAvtPayload>101</dtmfAvtPayload>
      <dtmfDbLevel>3</dtmfDbLevel>
      <dtmfOutofBand>avt</dtmfOutofBand>
      <alwaysUsePrimeLine>false</alwaysUsePrimeLine>
      <alwaysUsePrimeLineVoiceMail>false</alwaysUsePrimeLineVoiceMail>
      <kpml>3</kpml>
      <stutterMsgWaiting>1</stutterMsgWaiting>
      <callStats>false</callStats>
      <silentPeriodBetweenCallWaitingBursts>10</silentPeriodBetweenCallWaitingBursts>
      <disableLocalSpeedDialConfig>false</disableLocalSpeedDialConfig>
      <startMediaPort>16384</startMediaPort>
      <stopMediaPort>16399</stopMediaPort>
      <voipControlPort>5069</voipControlPort>
      <dscpForAudio>184</dscpForAudio>
      <ringSettingBusyStationPolicy>0</ringSettingBusyStationPolicy>
      <dialTemplate>dialplan.xml</dialTemplate>
      <phoneLabel>Office</phoneLabel>
      <sipLines>
         <line button="1">
            <featureID>9</featureID>
            <featureLabel>CIT Networks</featureLabel>
            <name>{{.PhoneNumber}}</name>
            <displayName>{{.DisplayName}}</displayName>
            <contact>{{.PhoneNumber}}</contact>
            <proxy>10.0.201.254</proxy>
            <port>5060</port>
            <autoAnswer>
               <autoAnswerEnabled>2</autoAnswerEnabled>
            </autoAnswer>
            <callWaiting>3</callWaiting>
            <authName>{{.PhoneNumber}}</authName>
            <authPassword>{{.PhonePassword}}</authPassword>
            <sharedLine>false</sharedLine>
            <messageWaitingLampPolicy>1</messageWaitingLampPolicy>
            <messagesNumber>120</messagesNumber>
            <ringSettingIdle>4</ringSettingIdle>
            <ringSettingActive>5</ringSettingActive>
            <forwardCallInfoDisplay>
               <callerName>true</callerName>
               <callerNumber>false</callerNumber>
               <redirectedNumber>false</redirectedNumber>
               <dialedNumber>true</dialedNumber>
            </forwardCallInfoDisplay>
         </line>
      </sipLines>
   </sipProfile>
<directoryURL>http://192.168.0.54/directory.xml</directoryURL>
</device>