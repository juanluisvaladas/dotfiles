source ~/bash_config/profiles/profile.config

for script in ~/bash_config/profiles/${PROFILE}/*.sh; do
	source ${script}
done


proxy_clean(){
	gsettings set org.gnome.system.proxy mode 'none'
}

proxy_set_3128(){
	gsettings set org.gnome.system.proxy.http host '127.0.0.1'
	gsettings set org.gnome.system.proxy.http port 3128
	gsettings set org.gnome.system.proxy.https host '127.0.0.1'
	gsettings set org.gnome.system.proxy.https port 3128
	gsettings set org.gnome.system.proxy.ftp host '127.0.0.1'
	gsettings set org.gnome.system.proxy.ftp port 3128
	gsettings set org.gnome.system.proxy.socks host '127.0.0.1'
	gsettings set org.gnome.system.proxy.socks port 3128
	gsettings set org.gnome.system.proxy mode 'manual'
}

activate_default() {
	echo 'export PROFILE="default"' > ~/bash_config/profiles/profile.config
	sudo systemctl stop cntlm
	sudo systemctl disable cntlm
	proxy_clean
}
