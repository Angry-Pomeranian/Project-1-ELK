## Networking Fundamentals Homework: Rocking your Network!
✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･*✧Networking Fundamentals Homework: Rocking your Network!✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･*✧
    
Nicole Kemp

FEB 2022

Week 8 Homework Submission File
  
 ✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ:✧･ﾟ*✲ Notes for TAsﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ


ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*


### **Phase 1**: _"I'd like to Teach the World to `Ping`"_

Step 1: Determine the IPs for the Hollywood office. (open excel file, and look at Hollywood office IPs)

Step 2: Run `fping` on the Hollywood office IPs. 

To search as a group run:
`fping -g 15.199.95.91/28 15.199.94.91/28 11.199.158.91/28 167.172.144.11/32 11.199.141 91/28` 
        
Or individually run:

`fping 15.199.95.91/28`

`fping 15.199.94.91/28`

`fping 11.199.158.91/28`

`fping 167.172.144.11/32`

`fping 11.199.141.91/28` 

Step 3: Summery

-List IP status and name:

IP: `167.172.144.11/32` listed as a `Hollywood Application Servers` is alive, the rest are unreachable. 

-List any findings associated to a hacker.List any vulnerabilities discovered:

I cant determined that a hacker reached any of these IP's, because there is no evidence at this stage. `¯\_(ツ)_/¯ `

However, Rockstar did state; 

    "RockStar Corp doesn't want any of their servers, even if they are up, indicating that they are accepting connections." 

The IP `167.172.144.11/32` port is accepting connections, and should to be closed if they don't want any connections.

-Document the OSI layer where the findings were found.

This has to do with IP(S). Which in context, has to do with the mail server destination. This makes the OSI layer 3: Networking.


### **Phase 2**:  _"Some `Syn` for Nothin`"_

Step 1: Start Syn scan by running the command `nmap -sS <ip address>`

I focused on `167.172.144.11` because Ping stated it was an alive ip, so I figured that the port was open.

Step 2: Command

Enter `Sudo nmap -sS 167.172.144.11` into the terminal.

Port 22 is open, and we know port 22 uses TCP and SSH services as it is a network port.
This port is open therefore is vulnerable. 


Step 3: Summery

Port 22 is vulnerable to hacking because a hacker could conduct a system/network scan, locate the port, and then obtain information about the system/network. Allowing ports to remain open exposes programme models and other data. This impacts the confidentiality component of the cybersecurity triad. Additionally, they have the ability to introduce malware or redirect traffic. The ISO layer is, ISO layer 4 transport.


Step 4?: Midigation strategy

The port must be closed  per Rock star's wishes. To close the port access the UFW settings in terminal, `sudio ufw status verbose` then run `sudo ufw deny 22`.

This will deny (close) port 22. Without deleteing it, which would remove the port. (you can do that by running `sudo ufw delete 22` )
### Phase 3: _"I Feel a `DNS` Change Comin' On"_

    
    Please check screen shots ssh and nslookup. I tried adding them to the .md file through vs code but it wouldn't work. :(

Step 1/2:
The first command you need is:
`sudo ssh jimi@167.172.144.11` we do this to ssh into Jimi's session.(enter the password which is his last name)

Then `cd /etc`
and `cat /etc/hosts`

This will cat the host file. Upon inspection we get a lists of address's: `8.8.8.8/53` `151.101.64.69` `151.101.128.69` `151.101.192.69`. Futhermore we also get Rollingstones ip address `98.137.246.8.`  

Step 3?: Summery

The weakness in the network is in the host redirection to the hacker website `98.137.246.8` the Domain says yahoo.com but the address was not given. When referencing the domain name, we see the hacker is redirecting traffic  from the hollywood sit to his site. So anyone trying to access yahoo.com is now compromised. 

Step 4: Mitigation

To mitigate this, you need to close the port. delete user Jimi and remove is web address from the hosts file. have all users change their passwords. Then check that yahoo.com is no longer being redirected. 

This ISO Layer is ISO layer 7 applications.

 ### Phase 4:  _"Sh`ARP` Dressed Man"_

Step 1: Lookup /etc and search for packetcaptureinfo.txt. cat it, and follow the link, and download the packet. (THIS IS UNSECURE AS HELL. GOOGLE DOCS ooof.)

Afterwards filter for `arp` review the addresses. Wireshark says theres two duplicate address for `192.168.47.200` that are being used for two diffrent mac address's. The Sus line is `no.5` Redirecting is the cause. 

Next we need to filter by `HTTP`. After viewing the packets line 16 is very sus. So we're going to look into the messages using the filter `http.request.method == POST`. 

Step 2: The commands

 `ls /etc`

 `cat /etc/packetcaptureinfo.txt`

(inside wireshark)

`arp`

`http`

`http.request.method == POST`

Step: Summery

We know that we have internal external threats and again, close port 22. Internally investigate to find "hacker@rockstarcorp.com". Block the hackers access then fire them, and then require all employees to change their passwords.

The first OSI layers are Layer 2 and Layer 3 (Arp works between those two). The next OSI layer is layer 7, because HTTP works in applications.

_"Its the End of the Assessment as We Know It, and I Feel DEAD."_