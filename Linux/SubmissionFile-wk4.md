 ✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:* Linux Systems Administration✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ

 Nicole Kemp
 10TH OF JAN 2022
 Week 4 Homework Submission File

 Notes for TA:

    Hello Martin and welcome to my hw assignment. I finished this on the 10th, but had some problems adding a screen-shot to the .md file. I also  used a chmod calulater to find the numercal permissions for Chmod. 

#(ﾉ0ヮ0)ﾉ*✲ﾟ✧･ﾟStep 1: Ensure/Double Check Permissions on Sensitive Files ✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･: *✧･ﾟ:*✧･ﾟﾟ

1. Permissions on `/etc/shadow` should allow only `root` read and write access.

    - Command to inspect permissions:

Answer: `ls -l/etc/shadow`

 - Command to set permissions (if needed):

Answer:  `sudo chmod 600 /etc/shadow`

2. Permissions on `/etc/gshadow` should allow only `root` read and write access.
    - Command to inspect permissions:

Answer: `ls -l /etcgshadow`
- Command to set permissions (if needed):
 
 Answer: `sudo chmod 600/etc/group`

3. Permissions on `/etc/group` should allow `root` read and write access, and allow everyone else read access only.

    - Command to inspect permissions:

Answer: `ls -l /etc/group`

- Command to set permissions (if needed):

Answer: `sudo chmod 644 /etc/group`

4. Permissions on `/etc/passwd` should allow `root` read and write access, and allow everyone else read access only.

    - Command to inspect permissions:
Answer: `ls -l /etc/passwd`
    - Command to set permissions (if needed):
Answer: `sudo chmod 644 /etc/passwd`

Summary: If you need to chanage permissions do `sudo chmod <x> /etc/passwd` or `sudo chmod <x> /etc/shadow/passwd`
#( x is stand in for the numerical number that respresents each groups permissions.)


##(ﾉ0ヮ0)ﾉ*✲ﾟ✧･ﾟ✧･ﾟ*✧･ﾟ:*✧･ﾟ:Step 2: Create User Accounts✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ:*✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ

1. Add user accounts for `sam`, `joe`, `amy`, `sara`, and `admin`.

    - Command to add each user account (include all five users):
Answer: `sudo adduser` is the command to add user accounts. 

Detailed Answer:

            `sudo adduser sam`
            `sudo adduser joe`
            `sudo adduser amy`
            `sudo adduser sara`
            `sudo adduser admin`  

2. Ensure that only the `admin` has general sudo access.

    - Command to add `admin` to the `sudo` group:
Answer: The -aG option tells the system to append the user to the specified group.
Detailed Answer: sudo user mod -aG sudo admin


###(ﾉ0ヮ0)ﾉ*✲ﾟ✧･ﾟStep 3: Create User Group and Collaborative Folder✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ


notes: the wording for thease questions started to confuse me, so ive added an explaination of what thease commands do.

1. Add an `engineers` group to the system.

    - Command to add group:
Answer:  `groupadd engineers`
This creates a group called engineers to the system. 

2. Add users `sam`, `joe`, `amy`, and `sara` to the managed group.

    - Command to add users to `engineers` group (include all four users):

Answer: `sudo usermod -aG groupname username` is the command i used. The -aG option tells the system to append the user to the specified group.(I'ved also seen -a -G used)
Detailed answer: 
               sudo usermod -a -G engineers sam
               sudo usermod -a -G engineers joe
               sudo usermod -a -G engineers amy
               sudo usermod -a -G engineers sara

3. Create a shared folder for this group at `/home/engineers`.

    - Command to create the shared folder:
Answer: sudo mkdir -p /home/engineers

4. Change ownership on the new engineers' shared folder to the `engineers` group.

    - Command to change ownership of engineer's shared folder to engineer group:
Answer: sudo chgrp -R engineers /home/engineers


####(ﾉ0ヮ0)ﾉ*✲ﾟ✧･ﾟ Step 4: Lynis Auditing✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ

1. Command to install Lynis:

Answer: `sudo apt-get install -y lynis`

2. Command to see documentation and instructions:

Answer: `apt show lynis`

3. Command to run an audit:

Answer: `sudo lynis audit system`

4. Provide a report from the Lynis output on what can be done to harden the system.

- Screenshot of report output:

Answer:
Please check inside google drive folder.

#####(ﾉ0ヮ0)ﾉ*✲ﾟ✧･ﾟ Bonus:
1. Command to install chkrootkit:

Answer: `sudo apt-get install -y chkrootkit`

2. Command to see documentation and instructions:

Answer: `apt show chkrootkit`

3. Command to run expert mode:

Answer: `./chkrootkit -x | more`
(im unsure if i need the space before more)

4. Provide a report from the chrootkit output on what can be done to harden the system.
    - Screenshot of end of sample output:

Answer: Please check inside google drive folder.



  Have a great weekend!
