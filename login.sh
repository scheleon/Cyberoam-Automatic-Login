read username < username.txt
read password < password.txt

if [[ -z "$username" || -z "$password" ]] 
then
	echo "Username or Password empty!!";
	exit 1;
fi

curl -k \
	--data-urlencode "mode=191"\
	--data-urlencode "username=$username"\
	--data-urlencode "password=$password" -X POST \
	--url "https://172.16.1.1:8090/login.xml" 2>/dev/null
