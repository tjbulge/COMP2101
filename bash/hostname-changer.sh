#!/bin/bash
#
# This script is for the bash lab on variables, dynamic data, and user input
# Download the script, do the tasks described in the comments
# Test your script, run it on the production server, screenshot that
# Send your script to your github repo, and submit the URL with screenshot on Blackboard

#storing cant change message in variable for using multiple times easily
cantchange="Cannot change hostname. Current hostname is the same as new hostname"

# Get the current hostname using the hostname command and save it in a variable
currenthostname=$(hostname)

# Tell the user what the current hostname is in a human friendly way
echo "Your current hostname is", $currenthostname

# Ask for the user's student number using the read command
read -p "Please enter your student number: " studentnum

# Use that to save the desired hostname of pcNNNNNNNNNN in a variable, where NNNNNNNNN is the student number entered by the user
newhostname="pc$studentnum"

#adding new line for readability
echo ""

# If that hostname is not already in the /etc/hosts file, change the old hostname in that file to the new name using sed or something similar and
#     tell the user you did that
#e.g. sed -i "s/$oldname/$newname/" /etc/hosts
if [[ "$currenthostname" = "$newhostname" ]]; 
  then
    echo $cantchange

  else
    echo "Changing hostname in /etc/hosts file"

    sudo sed -i "s/$currenthostname/$newhostname/" /etc/hosts && 
      echo "Hostname in /etc/hosts file  successfully changed to $newhostname"
fi

#adding empty line for readablilty
echo ""

# If that hostname is not the current hostname, change it using the hostnamectl command and
#     tell the user you changed the current hostname and they should reboot to make sure the new name takes full effect
#e.g. hostnamectl set-hostname $newname
currenthostname=$(hostname)

if [[ "$currenthostname" = "$newhostname" ]]; 
  then
    echo $cantchange

  else
    echo "Changing hostname in /etc/hostname file"
    hostnamectl set-hostname $newhostname &&
      echo "Hostname in /etc/hostname file changed to $newhostname. You should reboot to make sure the new hostname takes effect"
fi


