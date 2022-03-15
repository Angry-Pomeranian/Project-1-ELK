## Automated ELK Stack Deployment

Nicole kemp
The files in this repository were used to configure the network depicted below.

![TODO: THIS IS MY DIAGRAM](Images/diagram_filename.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the _yml_ and _config file_ may be used to install only certain pieces of it, such as Filebeat.

  - _Playbook(see ansible folder): Ansible/ELK.yml https://github.com/Angry-Pomeranian/GitHub-Fundamentals-and-Project/blob/1a71a2a303bf413d10c05cf600ff3992397c80cd/Ansible/ELK.yml_

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the Dmn Vulnerable Web Application.

Load balancing ensures that the application will be highly versatile, in addition to restricting high traffic to the network.
- _TODO: What aspect of security do load balancers protect? What is the advantage of a jump box?_
- ANSWER: 

      Load balancers are advantageous when a D-DoS attack occurs, or when there is a high volume of traffic that another server can compensate or alleviate. By integrating an ELK server, users may simply monitor vulnerable virtual machines (VMs) for changes to their data system logs.
Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the _data_ system _logs_.
- _TODO: What does Filebeat watch for?_
- _TODO: What does Metricbeat record?_

- ANSWER: 

      Filebeat monitors and observes the log files or locations specified by the user, gathers log events, and indexes them to Elasticsearch or Logstash. Metricbeat Retrieve metrics from your systems and services. It is a lightweight approach to provide system and service information. From CPU to RAM, Redis to NGINX, and so forth.

Integrating an ELK server allows users to easily monitor the vulnerable 
The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump-Box-Provisioner | Gateway  |13.77.45.61 | Linux            |
|   ^      |          |(private ip)--->10.0.0.6
| Web-1     |   DVWA   |  10.0.0.7  | Linux            |
| Web-2     |   DVWA   |  10.0.0.8  | Linux            |
| Web-3    |   DVWA   |  10.0.0.4  | Linux            |
| Elk-VM   |  server  | 10.1.0.4   | Linux (kibana)
### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the _ELK Server machine, (Elk-vm)_ can accept connections from the Internet. Access to this machine is _only_ allowed from the following IP addresses:
-  Add whitelisted IP addresses:{20.70.50.25} Machines within the network can only be accessed by _Jump-Box-Provisioner_.
- My local host machine is allowed to acess _Jump-Box-Provisioner_ {123.3.80.103}
-_Jump-Box-Provisioner_ has access to my _Elk-VM_. 

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
|Jump-Box-Provisioner | Yes              | 10.0.0.1 10.0.0.2    |
|   Elk-VM |          Yes        |      10.1.0.4                |
|    Web-1      |          No        |       52.189.221.82               |
|    Web-2      |         No         |  52.189.221.82
|    Web-3      |         No|  10.0.0.4|

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...


    - The benefit of using Ansible to automate configuration is that it boosts efficiency while configuring several computers.

- _TODO: What is the main advantage of automating configuration with Ansible?_
- ANSWER:

       There are no security codes required. You can simply specify all essential tasks in a playbook and ansible will take care of the rest.
      
The playbook implements the following tasks:
- _TODO: In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
- Install Docker.io
-Install Docker module
- Increase Virtual Memory
- Download and launch elk container
- Enable elk ports
- Download and launches the sebp/elk container over ports `5601`, `9200`, and `5044`.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

(docker ps output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:

     `10.0.0.6`, `10.0.0.7`, `10.0.0.8`

We have installed the following Beats on these machines:
- _TODO: Specify which Beats you successfully installed_

       Metricbeat & Filebeat

These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._

      Filebeat gathers log events and indexes them using Elasticsearch or Logstash. Metricbeat monitors the operating system and system services for system metrics. Using the Playbook

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the my-playbook.yml file to playbook.
- Update the _my-playbook.yml file to include host: webservers.
- the playbook and navigate to curl localhost/setup.php to check that the installation worked as expected..

_TODO: Answer the following questions to fill in the blanks:_

Which file is the playbook?

Where do you copy it?: 

      /etc/ansible folder 

Which file do you update to make Ansible run the playbook on a specific machine?:

       Update the [ansible-config]. 

How do I specify which machine to install the ELK server on versus which to install Filebeat on?: 

      update the hostname in the hosts file and then update the [ansible-config] file and then save.

_Which URL do you navigate to check that the ELK server is running?: 

      http://20.70.50.25:5601


_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
