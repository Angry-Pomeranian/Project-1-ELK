## Unit 11 Submission File: Network Security Homework 

Nicole Kemp

03 March 2022

Week 8 Homework Submission File

### Part 1: Review Questions 

#### Security Control Types

The concept of defense in depth can be broken down into three different security control types. Identify the security control type of each set  of defense tactics.

1. Walls, bollards, fences, guard dogs, cameras, and lighting are what type of security control?

    Answer: Physical

2. Security awareness programs, BYOD policies, and ethical hiring practices are what type of security control?

    Answer: Administrative

3. Encryption, biometric fingerprint readers, firewalls, endpoint security, and intrusion detection systems are what type of security control?

    Answer: Technical

#### Intrusion Detection and Attack indicators

1. What's the difference between an IDS and an IPS?

    Answer: The main distinction is that an IDS is a monitoring system, whereas an IPS is a control system. IDS does not alter network packets, whereas IPS prevents packet delivery based on the contents of the packet, much like a firewall prevents traffic based on IP address.

2. What's the difference between an Indicator of Attack and an Indicator of Compromise?

   Answer: Indicators of attack are similar to IOCs, but instead of concentrating on forensic analysis of an already compromised system, indicators of attack are engaged with identifying attacker activity while an attack is in progress.

#### The Cyber Kill Chain

Name each of the seven stages for the Cyber Kill chain and provide a brief example of each.

Stage 1: Recon 😎 - Obtaining knowledge on a person in advance of an attack.


Stage 2: Weaponization⚔️ - Injecting malicious software or putting a back door onto the target's machine.


Stage 3: Distribution🚚 - The malicious payload is distributed by the attacker via email or instant message.


Stage 4: Exploitation🚨 - Gaining access to and compromising the user's machine


Stage 5: Installation⚠️ - Additional hazardous malware, such as granting root access to your own user, is installed.


Stage 6🛅: C2 - Control channel for another computer.


Step  7: Exfiltration 🏃‍♀️- Performing the final task on the user's system.


#### Snort Rule Analysis

Use the Snort rule to answer the following questions:

Snort Rule #1:

```bash
alert tcp $EXTERNAL_NET any -> $HOME_NET 5800:5820 (msg:"ET SCAN Potential VNC Scan 5800-5820"; flags:S,12; threshold: type both, track by_src, count 5, seconds 60; reference:url,doc.emergingthreats.net/2002910; classtype:attempted-recon; sid:2002910; rev:5; metadata:created_at 2010_07_30, updated_at 2010_07_30;)
```

1. Break down the Sort Rule header and explain what is happening.

   Answer: Alerts user of ANY inbound TCP traffic from ports 5800:5820.`alert tcp $EXTERNAL_NET any -> $HOME_NET 5800:5820 `

2. What stage of the Cyber Kill Chain does this alert violate?

   Answer: Recon.

3. What kind of attack is indicated?

   Answer: Potential VNC scan attack. This attack is the equivalent of screen sharing without the victim knowing.

Snort Rule #2

```bash
alert tcp $EXTERNAL_NET $HTTP_PORTS -> $HOME_NET any (msg:"ET POLICY PE EXE or DLL Windows file download HTTP"; flow:established,to_client; flowbits:isnotset,ET.http.binary; flowbits:isnotset,ET.INFO.WindowsUpdate; file_data; content:"MZ"; within:2; byte_jump:4,58,relative,little; content:"PE|00 00|"; distance:-64; within:4; flowbits:set,ET.http.binary; metadata: former_category POLICY; reference:url,doc.emergingthreats.net/bin/view/Main/2018959; classtype:policy-violation; sid:2018959; rev:4; metadata:created_at 2014_08_19, updated_at 2017_02_01;)
```

1. Break down the Sort Rule header and explain what is happening.

   Answer:  Alerts for inbound TCP traffic on port 80, HTTP.`alert tcp $EXTERNAL_NET $HTTP_PORTS -> $HOME_NET any` This means that the remote host,has attempted to deliver a malicious playload to any port on the local machine via HTTP ports.

2. What layer of the Defense in Depth model does this alert violate?

   Answer: Distribution

3. What kind of attack is indicated?

   Answer: Policy PE EXE or DLL file download. `"ET POLICY PE EXE or DLL Windows file download HTTP`

Snort Rule #3

- Your turn! Write a Snort rule that alerts when traffic is detected inbound on port 4444 to the local network on any port. Be sure to include the `msg` in the Rule Option.

    Answer:

Command breakdown:

alert: The action that Snort will take when triggered.

tcp: Applies the rule to all TCP packets.

any: Applies the rule to packets coming from any source IP address.

4444: Applies the rule to packets from port 4444. (if its put at the end it applies to the destion port 4444)

EXTERNAL_NET = Anything except HOME_NET

->: indicates the direction of traffic.

any: Applies the rule to traffic to any destination port.
    
    Example 1:
     `alert tcp $EXTERNAL_NET 4444 -> $HOME_NET any (msg: "ET Possible Trojan or CrackDown)`

    Alternativly you can try example 2:

    `alert tcp $EXTERNAL_NET any -> $HOME_NET 4444 (msg:"gg no re")`

### Part 2: "Drop Zone" Lab




Before getting started, you should verify that you do not have any instances of `ufw` running. This will avoid conflicts with your `firewalld` service. This also ensures that `firewalld` will be your default firewall.

- Run the command that removes any running instance of `ufw`.

    $ `sudo ufw disable
    sudo ufw reset`
    
    Or if you wanna kill less kittens run: 

    $`sudo ufw disable && sudo killall ufw ; sudo systemctl disable ufw`
     (I also included the `killall` command which as it sounds, kills all process's running)
    
First I disabled the ufw, this turns it off. Then i reset it, which removes any conflicts and restores the defult firewall settings.

#### Enable and start `firewalld`

By default, these service should be running. If not, then run the following commands:

- Run the commands that enable and start `firewalld` upon boots and reboots.

    ```bash
    $ <sudo systemctl enable firewalld.service> This command enables the firewalld.service
    $ <sudo /etc/init.d/firewalld start> This command start's the firewalld.service.
    ```

  Note: This will ensure that `firewalld` remains active after each reboot.

#### Confirm that the service is running.

- Run the command that checks whether or not the `firewalld` service is up and running.

    ```bash
    $ <systemctl status firewalld.service>
    ```


#### List all firewall rules currently configured.



- Run the command that lists all currently configured firewall rules:

    ```bash
    $ <sudo firewall-cmd --list-all>
    ```

- Take note of what Zones and settings are configured. You many need to remove unneeded services and settings.

#### List all supported service types that can be enabled.

- Run the command that lists all currently supported services to see if the service you need is available

    ```bash
    $ <sudo firewall-cmd --list-all>
    ```

- We can see that the `Home` and `Drop` Zones are created by default.


#### Zone Views

- Run the command that lists all currently configured zones.

    ```bash
    $ <sudo firewall-cmd --get-zones>
    ```

- We can see that the `Public` and `Drop` Zones are created by default. Therefore, we will need to create Zones for `Web`, `Sales`, and `Mail`.

#### Create Zones for `Web`, `Sales` and `Mail`.

- Run the commands that creates Web, Sales and Mail zones.

    ```bash
    $ <sudo firewall-cmd --permanent --new-zone=web>
    $ <sudo firewall-cmd --permanent --new-zone=sales>
    $ <sudo firewall-cmd --permanent --new-zone=mail>

    ```

#### Set the zones to their designated interfaces:

- Run the commands that sets your `eth` interfaces to your zones.

    ```bash
    $ <sudo firewall-cmd --zone=public --change-interface=eth0>
    $ <sudo firewall-cmd --zone=web --change-interface=eth0>
    $ <sudo firewall-cmd --zone=sales --change-interface=eth0>
    $ <sudo firewall-cmd --zone=mail --change-interface=eth0>
    ```

#### Add services to the active zones:

- Run the commands that add services to the **public** zone, the **web** zone, the **sales** zone, and the **mail** zone.

- Public:

    ```bash
    $ <sudo firewall-cmd --zone=public --add-service=http>
    $ <sudo firewall-cmd --zone=public --add-service=https>
    $ <sudo firewall-cmd --zone=public --add-service=pop3>
    $ <sudo firewall-cmd --zone=public --add-service=smtp>
    ```

- Web:

    ```bash
    $ <sudo firewall-cmd --zone=web --add-service=http>
    ```

- Sales

    ```bash
    $ <sudo firewall-cmd --zone=sales --add-service=https>
    ```

- Mail

    ```bash
    $ <sudo firewall-cmd --zone=mail --add-service=smtp>
    $ <sudo firewall-cmd --zone=mail --add-service=pop3>
    ```

- What is the status of `http`, `https`, `smtp` and `pop3`?

Answer: First I ran `sudo firewall-cmd --get-services` which listed all of the active services running. (Ive screenshotted and highlighted where they are listed.)

#### Add your adversaries to the Drop Zone.

- Run the command that will add all current and any future blacklisted IPs to the Drop Zone.

     ```bash
    $ <sudo firewall-cmd --zone=drop --add-source=10.208.56.23>
    $ <sudo firewall-cmd --zone=drop --add-source=135.95.103.76>
    $ <sudo firewall-cmd --zone=drop --add-source=76.34.169.118>
    ```

#### Make rules permanent then reload them:

It's good practice to ensure that your `firewalld` installation remains nailed up and retains its services across reboots. This ensure that the network remains secured after unplanned outages such as power failures.

- Run the command that reloads the `firewalld` configurations and writes it to memory

    ```bash
    $ <sudo firewall-cmd --reload>
    $ <sudo firewall-cmd --runtime-to-permanent && sudo firewall-cmd --reload>
    ```

#### View active Zones

Now, we'll want to provide truncated listings of all currently **active** zones. This a good time to verify your zone settings.

- Run the command that displays all zone services.

    ```bash
    $ <sudo firewall-cmd --get-active-zones>
    ```


#### Block an IP address

- Use a rich-rule that blocks the IP address `138.138.0.3`.

    ```bash
    $ <sudo firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source
address='138.138.0.3' reject">
    ```

#### Block Ping/ICMP Requests

Harden your network against `ping` scans by blocking `icmp ehco` replies.

- Run the command that blocks `pings` and `icmp` requests in your `public` zone.

    ```bash
    $ <sudo firewall-cmd --zone=public --add-icmp-block=echo-reply>
    ```

#### Rule Check

Now that you've set up your brand new `firewalld` installation, it's time to verify that all of the settings have taken effect.

- Run the command that lists all  of the rule settings. Do one command at a time for each zone.

    ```bash
    $ <sudo firewall-cmd --zone=public --list-all>
    $ <sudo firewall-cmd --zone=web --list-all>
    $ <sudo firewall-cmd --zone=sales --list-all>
    $ <sudo firewall-cmd --zone=mail --list-all>
    $ <sudo firewall-cmd --zone=drop --list-all>
    ```

- Are all of our rules in place? If not, then go back and make the necessary modifications before checking again.


Congratulations! You have successfully configured and deployed a fully comprehensive `firewalld` installation.

---

### Part 3: IDS, IPS, DiD and Firewalls

Now, we will work on another lab. Before you start, complete the following review questions.

#### IDS vs. IPS Systems

1. Name and define two ways an IDS connects to a network.

   Answer 1: Network-based detection system (NIDS) => analyses network traffic for anomalous patterns and behaviours.

   Answer 2: HIDS:: Host-based intrusion detection system => checks a system for harmful activities.

2. Describe how an IPS connects to a network.

   Answer: An intrusion prevention system (IPS) is typically positioned directly behind the firewall and analyses traffic for suspicious behaviour.

3. What type of IDS compares patterns of traffic to predefined signatures and is unable to detect Zero-Day attacks?

   Answer: A stateless intrusion detection system (IDS) is incapable of detecting zero-day attacks since it analyses traffic from a set of predetermined hot and cold lists and lacks the intrinsic functionality to filter anything outside of those domains.

4. Which type of IDS is beneficial for detecting all suspicious traffic that deviates from the well-known baseline and is excellent at detecting when an attacker probes or sweeps a network?

   Answer: A statistical intrusion detection system is effective for detecting novel exploits. While they are often more bloated than their stateless counterparts, they provide a more sophisticated set of capabilities for studying system traffic.

#### Defense in Depth

1. For each of the following scenarios, provide the layer of Defense in Depth that applies:

    1.  A criminal hacker tailgates an employee through an exterior door into a secured facility, explaining that they forgot their badge at home.

        Answer: Administrative Policy

    2. A zero-day goes undetected by antivirus software.

        Answer: Technical Software

    3. A criminal successfully gains access to HR’s database.

        Answer: Technical Network

    4. A criminal hacker exploits a vulnerability within an operating system.

        Answer: Technical Software

    5. A hacktivist organization successfully performs a DDoS attack, taking down a government website.

        Answer:  Technical Network

    6. Data is classified at the wrong classification level.

        Answer: Administrative Procedures

    7. A state sponsored hacker group successfully firewalked an organization to produce a list of active services on an email server.

        Answer: Administrative Network

2. Name one method of protecting data-at-rest from being readable on hard drive.

    Answer: Drive encryption

3. Name one method to protect data-in-transit.

    Answer: Data Encryption

4. What technology could provide law enforcement with the ability to track and recover a stolen laptop.

   Answer: Route tracing

5. How could you prevent an attacker from booting a stolen laptop using an external hard drive?

    Answer: Strong Passwords, Disk Encryption, locking external hardrive ports, no automatic download.


#### Firewall Architectures and Methodologies

1. Which type of firewall verifies the three-way TCP handshake? TCP handshake checks are designed to ensure that session packets are from legitimate sources.

  Answer: Stateless Network firewall

2. Which type of firewall considers the connection as a whole? Meaning, instead of looking at only individual packets, these firewalls look at whole streams of packets at one time.

  Answer: Stateful firewall

3. Which type of firewall intercepts all traffic prior to being forwarded to its final destination. In a sense, these firewalls act on behalf of the recipient by ensuring the traffic is safe prior to forwarding it?

  Answer: Proxy Firewall


4. Which type of firewall examines data within a packet as it progresses through a network interface by examining source and destination IP address, port number, and packet type- all without opening the packet to inspect its contents?

  Answer: Packet-filtering firewall


5. Which type of firewall filters based solely on source and destination MAC address?

  Answer: Data link firewall



### Bonus Lab: "Green Eggs & SPAM"
In this activity, you will target spam, uncover its whereabouts, and attempt to discover the intent of the attacker.
 
- You will assume the role of a Jr. Security administrator working for the Department of Technology for the State of California.
 
- As a junior administrator, your primary role is to perform the initial triage of alert data: the initial investigation and analysis followed by an escalation of high priority alerts to senior incident handlers for further review.
 
- You will work as part of a Computer and Incident Response Team (CIRT), responsible for compiling **Threat Intelligence** as part of your incident report.

#### Threat Intelligence Card

**Note**: Log into the Security Onion VM and use the following **Indicator of Attack** to complete this portion of the homework. 

Locate the following Indicator of Attack in Sguil based off of the following:

- **Source IP/Port**: `188.124.9.56:80`
- **Destination Address/Port**: `192.168.3.35:1035`
- **Event Message**: `ET TROJAN JS/Nemucod.M.gen downloading EXE payload`

Answer the following:

Alert profile:

Source IP: 188.124.9.56

Destination IP: 192.168.3.35

Source port: 80

Destination port:1035

Infection type (ROJAN JS/Nemucod): Trojan JS

1. What was the indicator of an attack?
   - Hint: What do the details of the reveal? 

    Answer: 
    
     Red Alert on analyst console "DLL Windows file download HTTP" with server response, "ET TROJAN JS/Nemucod.M.gen downloading EXE payload" for downloading TROJAN.



2. What was the adversarial motivation (purpose of attack)?

    Answer: 

To gain access to the systems processes and make the user/machine vulnerable. This is a Pishing attack, so the more damage and access they can
do undetected the better.

3. Describe observations and indicators that may be related to the perpetrators of the intrusion. Categorize your insights according to the appropriate stage of the cyber kill chain, as structured in the following table.

| TTP | Example | Findings |
| --- | --- | --- | 
| **Reconnaissance** |  How did they attacker locate the victim? | target at Italian users, via emails, to upload the malware.
| **Weaponization** |  What was it that was downloaded?| a Trojan Downloader called Fareit or Pony Downloader, which in turn downloads another set of executable files containing the Gozi infostealer.
| **Delivery** |    How was it downloaded?|  	Trojan viruses are often spread via malicious email attachments that come in the format of a .zip or .exe file. However, they can also be distributed via p2p networks and other unsecured locations
| **Exploitation** |  What does the exploit do?|Retrieves a Trojan Downloader which downloads another set of executable files containing infostealer. Which in turns can be used to copy can transfer whatever data they want. While being executed as a background process that the host machine is unaware of.
| **Installation** | How is the exploit installed?|When the user opens the zip file and double clicks the JavaScript, the default file type associations in Windows will cause Internet Explorer to open and execute the JavaScript
| **Command & Control (C2)** | How does the attacker gain control of the remote machine?|Through the installed application, by then linking the two machines. Host -> attacker.
| **Actions on Objectives** | What does the software that the attacker sent do to complete it's tasks?|Allows the attacker to infiltrate the machine without notifying the target that their compromised. They then can go after others in the organization. and do more harm.


    Answer: 


4. What are your recommended mitigation strategies?


    Answer: 

    - You should delete the malware by using automatical software only. Do not try to eliminate the parasite manually as this is a very complex process for such threat.


    - Implement administrative security controls (Security Awareness Program) regarding malicous emails.

    - The deployment of Data Loss Prevention software DLP on host workstations.

    - Retrain or fire employee that opened pishing email.






5. List your third-party references.

    Answer: 

https://truica-victor.com/snort-rules-basic-understanding/

https://www.certego.net/en/news/italian-spam-campaigns-using-js-nemucod-downloader/

https://resources.infosecinstitute.com/topic/threat-hunting-malware-angler-ek-analysis-security-onion-goofus-gallant/

https://www.2-spyware.com/remove-js-nemucod.html


I have also have an in depth analysis on how i found everything, and further insights.
Its the .txt file `Txt file I used for findings for bonus.txt`
