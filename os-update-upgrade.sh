#!/bin/bash
# Above we defined the bash interpreter

# Defining brand variable
brand="OS Updates"

# Bash implementation of the pause command from bat scripts in Windows
function pause(){
 read -s -n 1 -p "Press any key to continue . . ."
 echo ""
}

# Check that the script is running as root. If not, then prompt for the sudo
# password and re-execute this part script with sudo priviliges.
if [ "$(id -nu)" != "root" ]; then
    sudo -k
    pass=$(whiptail --backtitle "$brand Installer" --title "Authentication required" --passwordbox "Installing $brand requires administrative privilege. Please authenticate to begin the installation.\n\n[sudo] Password for user $USER:" 12 50 3>&2 2>&1 1>&3-)
    if [ ! -z "$pass" ]; then
    # In case the password is not empty or null it will execute this branch
    # If it is wrong it will try to execute, but will fail
    echo "Synchroning package repositories:"
    echo $pass | sudo -S pacman -Syy
    echo "Updating packages"
    echo $pass | sudo -S pacman -Suu
    echo -e "OS Update....\e[1;32m[SUCCESS]\e[1;0m\n"
    else
        # In case root authentification fails
        echo -e "\e[1;31mNeed root permissions to run\e[1;0m"
        echo "No commands execuded"
        echo "Nothing changed"
        echo -e "OS Update....\e[1;31m[FAILED]\e[1;0m\n"
    fi
fi

# Quit message
echo -e "Script created by \e[1;32mBeanGreen247\e[1;0m \e[1;31mhttps://github.com/BeanGreen247 \e[1;0m\n"
pause