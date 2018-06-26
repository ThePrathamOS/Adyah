#!/bin/bash

axel https://sourceforge.net/projects/getprathamos/files/Adyah/1.1/Kernel.7z
FILE="/opt/KernelUpdate/Kernel.7z"
if [ -f "$FILE" ]
then
	md5sum=$(md5sum $FILE | awk '{print $1}')
	if [ "$md5sum" = "241566d43f6f25822a4ef1d6137bebf6" ]; then
		TOTAL="1234"
		if [ "$TOTAL" = "1234" ]; then
			sudo 7z x Kernel.7z -o.
			sudo rm -f Kernel.7z
			cd Kernel
			sudo mkdir -p /opt/drivers
			sudo rm -Rf /opt/drivers/rtl8188eu
			sudo cp -R rtl8188eu /opt/drivers
			sudo chown -R root:root /opt/drivers
			sudo chmod -R 777 /opt/drivers
			sudo cp -R /opt/drivers/rtl8188eu /opt/drivers/rtl8188eutemp
			sudo chmod -R 777 /opt/drivers/rtl8188eutemp
			pushd /opt/drivers/rtl8188eutemp
			make
			sudo make install
			sudo modprobe 8188eu
			popd
			sudo rm -Rf /opt/drivers/rtl8188eutemp
			notify-send -t 5000 "PrathamOS Kernel Update" "\nInstalling Modules & Headers..."
			xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
			mpv /opt/anapmi/modheaders.mp3
			xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
			echo "Installing Modules & Headers..."
			KERNELNAME="4.17.3-041703-generic"
			sudo gdebi -n linux-modules-4.17.3-041703-generic_4.17.3-041703.201806252030_amd64.deb
			sudo gdebi -n linux-headers-4.17.3-041703_4.17.3-041703.201806252030_all.deb
			sudo gdebi -n linux-headers-4.17.3-041703-generic_4.17.3-041703.201806252030_amd64.deb
			sudo gdebi -n linux-image-unsigned-4.17.3-041703-generic_4.17.3-041703.201806252030_amd64.deb
			CurrentUser=$(whoami)
			CurrentKernelFull=$(uname -r)
			CurrentKernel=$(uname -r | sed s.-generic.''.g)	
			echo "#!/bin/bash

notify-send -t 5000 \"PrathamOS Kernel Update\" \"\nRemoving Kernel $CurrentKernelFull...\"
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
mpv /opt/anapmi/oldkernel.mp3
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
sudo cp -R /opt/drivers/rtl8188eu /opt/drivers/rtl8188eutemp
sudo chmod -R 777 /opt/drivers/rtl8188eutemp
pushd /opt/drivers/rtl8188eutemp
make
sudo make install
sudo modprobe 8188eu
popd
sudo rm -Rf /opt/drivers/rtl8188eutemp
echo \"Removing Kernel $CurrentKernelFull...\"
sudo apt-get remove -y linux-headers-$CurrentKernel
sudo apt-get remove -y linux-headers-$CurrentKernelFull
sudo apt-get remove -y linux-image-unsigned-$CurrentKernelFull
sudo apt-get remove -y linux-modules-$CurrentKernelFull
sudo rm -Rf /usr/src/linux-headers-$CurrentKernel
sudo rm -Rf /usr/src/linux-headers-$CurrentKernelFull
sudo rm -Rf /lib/modules/$CurrentKernelFull
notify-send -t 5000 \"PrathamOS Kernel Update\" \"\nConfiguring VMWare Modules...\"
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
mpv /opt/anapmi/vmwaremod.mp3
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
echo \"Configuring VMWare Modules...\"
#sudo vmware-modconfig --console --install-all
sudo vmware-installer -u vmware-workstation --console --required --eulas-agreed
sudo /opt/essentials/VMware-Workstation-Full-14.1.1-7528167.x86_64.bundle --console --required --eulas-agreed
notify-send -t 5000 \"PrathamOS Kernel Update\" \"\nConfiguring VirtualBox Modules...\"
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
mpv /opt/anapmi/vboxmod.mp3
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
echo \"Configuring VirtualBox Modules...\"
sudo dpkg-reconfigure virtualbox-dkms
sudo rm -f /*.old
rm -f /home/$CurrentUser/.config/autostart/KernelPostRestart.desktop
rm -f /opt/KernelPostRestart.sh
rm -Rf /opt/KernelUpdate
sed -i 's/$CurrentKernelFull/$KERNELNAME/g' /opt/essentials/unsyncedupdates.html
notify-send -t 5000 \"PrathamOS Kernel Update\" \"\nUpdating Grub...\"
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
mpv /opt/anapmi/updgrub.mp3
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
echo \"Updating Grub...\"
sudo update-grub
notify-send -t 5000 \"PrathamOS Kernel Update\" \"\nKernel Updated Successfully...\"
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
mpv /opt/anapmi/kerupdsuccess.mp3
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
echo \"Kernel Updated Successfully...\"
rm -f /opt/KERNELUPDATE
exit

" | tee /opt/KernelPostRestart.sh
			sudo chmod 777 /opt/KernelPostRestart.sh
			echo "[Desktop Entry]
Encoding=UTF-8
Version=0.9.4
Type=Application
Name=temp
Comment=
Exec=/opt/KernelPostRestart.sh
OnlyShowIn=XFCE;
StartupNotify=false
Terminal=false
Hidden=false
" | tee /home/$CurrentUser/.config/autostart/KernelPostRestart.desktop
			notify-send -t 5000 "PrathamOS Kernel Update" "\nRestarting The System..."
			xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
			mpv /opt/anapmi/restart2.mp3
			xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
			echo "Restarting The System..."
			sudo update-grub
			xfce4-session-logout -r
		else
			notify-send -t 5000 "PrathamOS Kernel Update" "\nUnable To Connect Repository.\nPlease Try Again Later..."
			xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
			mpv /opt/anapmi/norepo.mp3
			xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
			echo "Unable To Connect Repository.Please Try Again Later."
			rm -Rf /opt/KernelUpdate
			rm -f /opt/KERNELUPDATE
			exit
		fi
	else
		notify-send -t 5000 "PrathamOS Kernel Update" "\nUnable To Connect Repository.\nPlease Try Again Later..."
		xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
		mpv /opt/anapmi/norepo.mp3
		xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
		echo "Unable To Connect Repository.Please Try Again Later."
		rm -Rf /opt/KernelUpdate
		rm -f /opt/KERNELUPDATE
		exit
	fi
else
	notify-send -t 5000 "PrathamOS Kernel Update" "\nUnable To Connect Repository.\nPlease Try Again Later..."
	xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
	mpv /opt/anapmi/norepo.mp3
	xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
	echo "Unable To Connect Repository.Please Try Again Later."
	rm -Rf /opt/KernelUpdate
	rm -f /opt/KERNELUPDATE
	exit
fi
