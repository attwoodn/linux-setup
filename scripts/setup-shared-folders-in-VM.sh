#!/bin/bash

systemctl status rc-local.service

sudo systemctl enable rc-local

sudo touch /etc/systemd/system/rc-local.service

sudo echo "[Unit]
Description=/etc/rc.local Compatibility
ConditionPathExists=/etc/rc.local

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/rc-local.service

sudo touch /etc/rc.local
sudo chmod +x /etc/rc.local

sudo echo "#!/bin/bash
sudo mount -t vboxsf -o uid=1000,gid=1000 git /mnt/git
exit 0" > /etc/rc.local

sudo systemctl start rc-local.service
