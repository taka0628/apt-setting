## 理研
```
sudo sed -i "s-$(cat /etc/apt/sources.list | grep -v "#" | cut -d " " -f 2 | grep -v "security" | sed "/^$/d" | sed -n 1p)-http://ftp.riken.go.jp/Linux/ubuntu/-g" /etc/apt/sources.list && sudo apt update
```