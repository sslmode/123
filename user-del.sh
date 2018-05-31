#!/bin/bash

if [[ $USER != 'root' ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

MYIP=$(wget -qO- ipv4.icanhazip.com)

echo "-------- DELETE ACCOUNT ---------"

	echo "          DEVELOPED BY VPN989            "
echo ""

# begin of user-list
echo "-----------------------------------"
echo "USERNAME              EXP DATE     "
echo "-----------------------------------"

while read expired
do
	AKUN="$(echo $expired | cut -d: -f1)"
	ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
	exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
	if [[ $ID -ge 1000 ]]; then
		printf "%-21s %2s\n" "$AKUN" "$exp"
	fi
done < /etc/passwd
echo "-----------------------------------"
echo ""
# end of user-list

read -p "Enter username: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo ""
	read -p "Are you sure You Want to Delete This Account? [$username] [y/n]: " -e -i y REMOVE
	if [[ "$REMOVE" = 'y' ]]; then
		passwd -l $username
		userdel $username
		echo ""
		echo "Account [$username] Succesfull Delete!"
	else
		echo ""
		echo "Delete Account [$username] Cancelled!"
	fi
else
	echo "Username [$username] Not Available!"
	exit 1
fi


