DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
user=$(id -un)

echo "alias login='$DIR/login.sh'" >> /home/$user/.bashrc
echo "alias logout='$DIR/logout.sh'" >> /home/$user/.bashrc
echo "alias resetlan='$DIR/resetlan.sh'" >> /home/$user/.bashrc

source /home/$user/.bashrc
