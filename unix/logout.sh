red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

read username < $DIR/username.txt

if [[ -z "$username" ]] 
then
	echo "Username empty!!";
	exit 1;
fi

response=$(curl -k \
	--data-urlencode "mode=193"\
	--data-urlencode "username=$username" -X POST \
	--url "https://172.16.1.1:8090/logout.xml" 2>/dev/null | \
	sed -n 's:.*<message>\(.*\)</message>.*:\1:p')

responseLength=${#response}
messageLength=$((responseLength-3))

message=$(echo "$response" | cut -c 10-$messageLength)

messageFilter=$(echo $message | grep "success")

if [[ -n "$messageFilter" ]]; then
	echo "${green}$message!!${reset}"
else
	echo "${red}$message not found!!${reset}"
fi

