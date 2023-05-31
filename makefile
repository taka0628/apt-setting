# =================
# install
# =================

install:
	sudo apt update
	sudo apt install -y \
	gcc \
	g++ \
	curl \
	wget \
	cloc \
	clang \
	clang-format \
	python3 \
	python3-pip \
	black \
	isort

vscode:
	sudo apt update
	sudo apt install wget gpg
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg
	sudo apt install apt-transport-https
	sudo apt update
	sudo apt install code

dive:
	wget https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb
	sudo apt install ./dive_0.9.2_linux_amd64.deb
	rm dive_0.9.2_linux_amd64.deb

qt5:
	sudo apt install -y qtbase5-dev qttools5-dev-tools qt5-default qtcreator

bash-it:
	cp -rf .bash_it/ ~/
	cd ~/.bash_it && echo "y" | ./install.sh
	sed -i "s/export BASH_IT_THEME='bobby'/export BASH_IT_THEME='easy'/" ~/.bashrc

google-drive:
	sudo add-apt-repository ppa:alessandro-strada/ppa
	sudo apt update
	sudo apt install -y google-drive-ocamlfuse

docker:
ifeq ($(shell docker --version 2>/dev/null),)
	sudo apt update
	sudo apt install -y docker.io
endif
ifneq ($(shell getent group docker| cut -f 4 --delim=":"),$(shell whoami))
	sudo gpasswd -a $(shell whoami) docker
endif
ifeq ($(shell ls -al /var/run/docker.sock 2>/dev/null | cut -d ' ' -f 4 | grep -c 'docker' | wc -l),0)
	sudo chgrp docker /var/run/docker.sock
endif
	sudo systemctl restart docker
	@echo "環境構築を完了するために再起動してください"


# =================
# network setting
# =================
network-change:
ifneq ($(shell find /etc/apt/ -name "sources.list" -type f),)
ifeq ($(shell ls /etc/apt/ | grep -c sources.list.old),0)
	sudo cp /etc/apt/sources.list /etc/apt/sources.list.old
endif
endif
	./net.sh

network-reset:
ifneq ($(shell find /etc/apt/ -name "sources.list.old" -type f),)
	sudo cat /etc/apt/sources.list.old > etc/apt/sources.list
endif

time-fix:
	hwclock: use --verbose, --debug has been deprecated.


swapDelete:
	sudo swapoff /swapfile
	swapon -s
	sudo sed -i "s@/swapfile@# /swapfile@" /etc/fstab
	sudo rm -f /swapfile

test:
	cd ~/.bash_it && pwd
