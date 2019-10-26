read username < username.txt
read password < password.txt

if [[ -z "$username" ]] 
then
	echo "Username empty!!";
	exit 1;
fi

curl -k \
	--data-urlencode "mode=193"\
	--data-urlencode "username=$username" -X POST \
	--url "https://172.16.1.1:8090/logout.xml" 2>/dev/null
