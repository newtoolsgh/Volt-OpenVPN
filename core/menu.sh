#!/bin/bash

# add a new user
function add_user() {
    read -p "👤 Enter the username for the new user: " username
    sudo useradd $username
    sudo passwd $username
    sudo chown $username /etc/openvpn/client-configs/files/
    echo "✅ User $username has been added."
}

# remove a user
function remove_user() {
    read -p "❌ Enter the username to remove: " username
    sudo userdel -r $username
    sudo rm -rf /etc/openvpn/client-configs/files/$username.ovpn
    echo "✅ User $username has been removed."
}

# list all users
function list_users() {
    echo -e "👥 List of users:"
    cat /etc/openvpn/client-configs/files/*.ovpn | grep -o 'CN=[^/]*' | cut -d '=' -f 2 | sort | uniq
}

# Main script
echo -e "\033[1;36m"    # Color cyan
cat << "EOF"
 __      __   _ _      ______      _______  _   _ 
 \ \    / /  | | |    / __ \ \    / /  __ \| \ | |
  \ \  / /__ | | |_  | |  | \ \  / /| |__) |  \| |
   \ \/ / _ \| | __| | |  | |\ \/ / |  ___/| . ` |
    \  / (_) | | |_  | |__| | \  /  | |    | |\  |
     \/ \___/|_|\__|  \____(_) \/   |_|    |_| \_|
                                                  
      Volt OpenVPN by @voltssh 〄 
EOF
echo -e "\033[0m"       # Reset color
echo " ✒ 1〉 Add User 🧑"
echo " ✒︎ 2〉 Remove User ❌"
echo " ✒︎ 3〉 List Users 👥"
echo " ✒︎ 0〉 Quit 🚪"
echo " "

read -p " 🔢 Enter your choice: " choice

case $choice in
    1)
        add_user
        ;;
    2)
        remove_user
        ;;
    3)
        list_users
        ;;
    0)
        echo " 👋 Exiting."
        exit 0
        ;;
    *)
        echo " ❌ Invalid choice. Exiting."
        exit 1
        ;;
esac
