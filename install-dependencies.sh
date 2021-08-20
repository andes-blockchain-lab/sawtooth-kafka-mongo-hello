#!/bin/bash -x


#Script based on:
# https://medium.com/@eSizeDave/https-medium-com-esizedave-how-to-install-hyperledger-fabric-1-2-on-ubuntu-16-04-lts-ecdfa4dcec72
# https://hyperledger-fabric.readthedocs.io/en/latest/prereqs.html

if [[ "$EUID" -ne 0 ]]; then
	echo "Must run with sudo"
	exit
fi

main(){

	if [[ $1 = "--version" ]]; then
		show_versions
		exit 0
	fi

	apt-get update

	sudo apt-get install libtool pkg-config build-essential autoconf automake dkms -y

	install_docker
	install_docker_compose
	#install_go
	install_node
	#apt-get install python build-essential -y
	#install_fabric_samples
	echo "Restart"
}

usage () {
	echo "$PROGNAME: usage: $PROGNAME [--version]"
	return
}



install_docker(){
	# Docker
	# https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce

	apt-get install \
	    apt-transport-https \
	    ca-certificates \
	    curl \
	    gnupg-agent \
	    software-properties-common -y

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

	apt-key fingerprint 0EBFCD88

	add-apt-repository \
	   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	   $(lsb_release -cs) \
	   stable"


	apt-get update

	apt-get install docker-ce docker-ce-cli containerd.io -y

	# https://docs.docker.com/install/linux/linux-postinstall/
	groupadd docker
	usermod -aG docker $SUDO_USER

	# newgrp docker
	sudo -u $SUDO_USER docker run hello-world

	docker --version
}

install_docker_compose(){

	# https://docs.docker.com/compose/install/

	curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

	chmod +x /usr/local/bin/docker-compose

	# https://docs.docker.com/compose/completion/
	curl -L https://raw.githubusercontent.com/docker/compose/1.25.3/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

	docker-compose --version
}

install_go(){

	# https://golang.org/doc/install

	sudo -u $SUDO_USER curl https://dl.google.com/go/go1.13.7.linux-amd64.tar.gz -o go.tar.gz

	sudo -u $SUDO_USER sha256sum go.tar.gz
	sudo -u $SUDO_USER tar -xvf go.tar.gz
	mv go /usr/local
	rm ./go.tar.gz

	sudo -u $SUDO_USER tee -a ~/.profile <<- '_EOF_'

	# GO Configuration
	export GOPATH=$HOME/go
	export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

	_EOF_

	export GOPATH=$HOME/go
	export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

	go version
}

install_node(){
	# https://github.com/nvm-sh/nvm

	sudo -u $SUDO_USER sh -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash'

	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

	nvm install 10
	nvm use node 10

	node --version
}

install_fabric_samples(){
	# https://hyperledger-fabric.readthedocs.io/en/release-1.4/install.html
	curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.0.0 1.4.4 0.4.18
	mkidr -p /usr/local/hyperledger
	mv ./fabric-samples /usr/local/hyperledger/

	sudo -u $SUDO_USER tee -a ~/.profile <<- '_EOF_'

	# Fabric bins
	export PATH=/usr/local/hyperledger/bin:$PATH

	_EOF_

	export PATH=/usr/local/hyperledger/bin:$PATH
}

show_versions(){
	echo "-----------------------------"
	docker --version
	docker-compose --version
	go version
	node --version
	python --version
	peer version
	orderer version
	fabric-ca-server version
}

main "$@"
