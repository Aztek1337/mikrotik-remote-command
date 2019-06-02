#!/usr/bin 

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~                                      Mikrotik Update Tool	                                    ~"
echo "~                                       - Version: 1.0 -                                              ~"
echo "~                                    - By aa@aztek.xyz. -					            ~" 
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# Update routers.txt with routers IP address or FQDN
routers=$(<"PATH TO ROUTERS.TXT FILE")

# Enter command that will be run on router
# Any Mikrotik command can be added here by modifying "router_command" value
# Default generic command is currently added
router_command="/user add name=user1 password=12345 group=read"

# Echos command to verify command and routers
echo -e "You will be running Command: '$router_command' \nOn routers:\n$routers  " 
echo

# Asks for username and password
read -p "Please enter your Username: " USER
read -sp "Please enter your Password: " PASS
echo


# Runs $router_command on routers from routers.txt
for router in $routers
do
echo "Updating $router..."

# Connects to router via ssh then runs command and then appends any errors to results.txt
# Default of ssh connection time out is 10 seconds, can be changed by modifying "ConnectTimeout=" value
sshpass -p "$PASS" ssh -o ConnectTimeout=10 $USER"@"$router "$router_command" &>> results.txt
done
      
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo
echo "All Done!" 
echo
