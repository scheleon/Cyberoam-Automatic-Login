red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

read username < $DIR/username.txt
read password < $DIR/password.txt

password="$(cat $DIR/password.txt | base64 -d)"

if [[ -z "$username" || -z "$password" ]] 
then
	echo "Username or Password empty!!";
	exit 1;
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
	echo "${green}$message!!${reset}"
else
	echo "${red}$message!!${reset}"
fi
