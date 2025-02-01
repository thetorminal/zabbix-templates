# Zabbix Wordpress updates monitoring
Monitoring of Wordpress updates (Core, Plugins and Themens) with Zabbix.  

## Description
Based on “WP-CLI” (CLI query to check updates): [Github - WP-CLI](https://github.com/wp-cli/wp-cli)  

Shows number of available Wordpress Core, Plugin and Theme updates on host for all available Wordpress-Installations at "/var/www/*".  
LLD (low level discovery) is used to scan for all folders at "/var/www/". A discovery rule is used to scan the folders.  

Example notification:  
![wordpress_zabbix_updates](https://github.com/user-attachments/assets/1fb881ec-1f15-4495-a323-ebabf11f605b)

Tested with:  
* Zabbix Server 7.2.3
* zabbix-agent2 (on Debian 12 server)
* Various Wordpress-Versions

## Getting Started

### Dependencies
* [Github - WP-CLI](https://github.com/wp-cli/wp-cli) installed on the host ([Installation Guide](https://github.com/wp-cli/wp-cli?tab=readme-ov-file#installing))   
* Zabbix-Server with timeouts set up to 15 seconds! (Timeout=15)
* Host with zabbix-agent2 and a Wordpress installation

### Installing

#### On Zabbix frontend server:  
- Download and import the template `wordpress-updates.yaml`  
- Assign the `Template Wordpress Updates` to the Wordpress host(s) you want to monitor  

#### On all hosts you want to monitor:  
Manual:  
* Install and configure package zabbix-agent2 (if not installed):  
     ```sh
     apt-get install zabbix-agent2
     ```
* Install WP-CLI:
     ([Installation Guide from WP_CLI](https://github.com/wp-cli/wp-cli?tab=readme-ov-file#installing)):
     ```sh
     curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
     php wp-cli.phar --info
     chmod +x wp-cli.phar
     sudo mv wp-cli.phar /usr/local/bin/wp
     ```
     Test, if it was successfull:
     ```sh
     wp --info
     ```
* download "wp_discovery.sh" to new directory `/etc/zabbix/scripts/` and change permission:  
     ```sh
     mkdir /etc/zabbix/scripts
     curl -L https://raw.githubusercontent.com/emodii/zabbix-templates/refs/heads/main/Template%20Wordpress%20updates/wp_discovery.sh -o /etc/zabbix/scripts/wp_discovery.sh
     chown zabbix:zabbix /etc/zabbix/scripts/wp_discovery.sh && chmod 0755 /etc/zabbix/scripts/wp_discovery.sh
     ```
* add "wp_updates.conf" to /etc/zabbix/zabbix_agent2.d/:  
     ```sh
     curl -L https://raw.githubusercontent.com/emodii/zabbix-templates/refs/heads/main/Template%20Wordpress%20updates/wp_updates.conf -o /etc/zabbix/zabbix_agent2.d/wp_updates.conf
     ```
* restart zabbix-agent2
     ```sh
     systemctl restart zabbix-agent2
     ```

## Version History
* 0.1
    * Initial Release

## Acknowledgments
* [Github - WP-CLI](https://github.com/wp-cli/wp-cli)
* ChatGPT for helping me to understand the LLD in Zabbix  
