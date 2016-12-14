add_route(){
    echo "Prompt which external port will be mapped to an internal one"
    read external_port
    echo "Prompt the corresponding internal port"
    read internal_port
    if [ "$external_port" -ge 0 -a "$external_port" -le "65535" -a "$internal_port" -ge "0" -a "$internal_port" -le "65535" ]; then
	iptables -t nat -A PREROUTING -i eth0 -p tcp --dport $external_port -j REDIRECT --to-port $internal_port
	echo "Port prerouting enabled: $external_port ---> $internal_port"
    else
	echo "Invalid internal/external ports. Port number must be between 0 and 65535"
    fi
}

remove_route(){
	echo "Prompt which preroute you want to delete"
	echo "(Use list command to get all preroute number)"
	read -p "Preroute num: " preroute_index
	if [ "$preroute_index" -ge "0" -a "$preroute_index" -le "65535" ]; then
	    iptables -t nat -D PREROUTING $preroute_index
	elif [ "$" -eq "0" ]; then
	    echo "Returning to main menu"
	else
	    echo "Wrong port number."
	fi
}

list_routes(){
	iptables -t nat -L PREROUTING --line-numbers
}


echo " ----- PREROUTE EDITOR ----- "
while true; do
    echo ""
    echo "[0] -> Add preroute"
    echo "[1] -> Remove preroute"
    echo "[2] -> List all existing preroutes"
    echo "[3] -> Exit"
    read cmd
    case $cmd in
        [0]* ) add_route ;;
        [1]* ) remove_route ;;
	[2]* ) list_routes ;;
	[3]* ) exit ;;
        * ) echo "Command not found." ;;
    esac
done
