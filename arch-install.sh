step1(){
	read -p "Hostname : " hostname
	read -p "Username : " username
	read -p "Passwd : " passwd
	#Configure mirrorlist
	echo 'Configure mirrorlist ...'
    mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
	echo 'Server = http://archlinux.cs.nctu.edu.tw/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
	#Install ArchLInux
	echo 'Install ArchLinux ...'
    pacstrap /mnt base base-devel
	#chroot
	arch-chroot /mnt
	echo 'Configure pacman ...'
    sed -i '/^#\[multilib\]$/{N;s/#//g;P;D;}' /etc/pacman.conf
    echo 'Configure yaourt ...'
    # yaourt 套件源
    echo '[archlinuxfr]' >> /etc/pacman.conf
    echo 'SigLevel = Never' >> /etc/pacman.conf
    echo 'Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf
	echo 'Install packages ...'
	pacman -S sudo grub os-prober efibootmgr vim net-tools wireless_tools dhclient wpa_supplicant\
	echo 'Change system limit ...'
    echo '*               -       nofile          10000' >> /etc/security/limits.conf

    echo 'Configure sudo ...'
    sed -i 's/^# \(%wheel ALL=(ALL) ALL\)$/\1/' /etc/sudoers

    echo 'Configure network ...'
    echo '$hostname' > /etc/hostname
    echo '127.0.0.1  $hostname.localdomain  $hostname' >> /etc/hosts
    systemctl enable NetworkManager	
    echo 'nameserver 1.1.1.1' > /etc/resolv.conf #cloudfare dns
    echo 'nameserver 1.0.0.1' >> /etc/resolv.conf
    echo 'Configure time ...'
    # 時區
    ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime
    # 網路時間同步
    systemctl enable ntpd.service

	echo 'Configure Locale ...'
    mv /etc/locale.gen /etc/locale.gen.bak
    echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
    echo 'zh_TW.UTF-8 UTF-8' >> /etc/locale.gen
    echo 'ja_JP.UTF-8 UTF-8' >> /etc/locale.gen
    locale-gen
    echo "LANG=zh_TW.UTF-8" > /etc/locale.conf

    echo 'Configure IME ...'
    echo 'LANG=zh_TW.UTF-8' >> /etc/skel/.xprofile
    echo 'export GTK_IM_MODULE=fcitx' >> /etc/skel/.xprofile
    echo 'export QT_IM_MODULE=fcitx' >> /etc/skel/.xprofile
    echo 'export XMODIFIERS=@im=fcitx' >> /etc/skel/.xprofile

    echo 'Configure graphical UI...'
    systemctl enable sddm.service

    echo 'Creating boot image ...'
    mkinitcpio -p linux

    echo 'Create user account'
    useradd -m $username
    echo "$username:$password" |chpasswd
    usermod $username -G wheel

    echo 'Configure Grub:'
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
    grub-mkconfig -o /boot/grub/grub.cfg
	exit
    echo 'System installed. Please reboot.'
	exit

}

