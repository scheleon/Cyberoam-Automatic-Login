red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
user=$(id -un)

findSource=$(cat /home/$user/.bashrc | grep $DIR/sourceFile)

if [[ -z "$findSource" ]]; then
	echo "$DIR/sourceFile" >> /home/$user/.bashrc
	chmod +x $DIR/sourceFile
	if [[ ! $? -eq '0' ]]; then
		echo "${red}Permission Denied${reset}"
		exit
	fi
fi

echo "alias login='$DIR/login.sh'" > $DIR/sourceFile
echo "alias logout='$DIR/logout.sh'" >> $DIR/sourceFile
echo "alias resetlan='$DIR/resetlan.sh'" >> $DIR/sourceFile

source /home/$user/.bashrc

read -p "Username : " username
read -sp "Password : " password

echo $username > $DIR/username.txt
echo $(echo $password | base64) > $DIR/password.txt

if [[ $? -eq '0' ]]; then
	printf "\n${green}Setup complete!!${reset}\n"
else
	printf "\n${red}Error, try again${reset}\n"
fi