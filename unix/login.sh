red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
BOLD='\033[1m'
CYAN='\033[01;36m'

SERVERIP=172.16.1.1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

read username < $DIR/username.txt
read password < $DIR/password.txt

password="$(cat $DIR/password.txt | base64 -d)"

if [[ -z "$username" || -z "$password" ]] 
then
	echo -e "${red}${BOLD}Username or Password empty!!${reset}";
	exit 1;
fi

ping -c 1 -w 2 $SERVERIP > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo -e "${red}${BOLD}Error, connecting to server $SERVERIP!!${reset}"
	exit 1
fi

response=$(curl -k \
	--data-urlencode "mode=191"\
	--data-urlencode "username=$username"\
	--data-urlencode "password=$password" -X POST \
	--url "https://172.16.1.1:8090/login.xml" 2>/dev/null | \
	sed -n 's:.*<message>\(.*\)</message>.*:\1:p')

responseLength=${#response}
messageLength=$((responseLength-3))

message=$(echo "$response" | cut -c 10-$messageLength)

messageFilter=$(echo $message | grep "success")

if [[ -n "$messageFilter" ]]; then
	echo -e "${CYAN}${BOLD}$message!!${reset}"
else
	echo -e "${red}${BOLD}$message!!${reset}"
fi
