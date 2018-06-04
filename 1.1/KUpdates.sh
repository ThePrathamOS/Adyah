#!/bin/bash

function Chunk1(){
	wget https://sourceforge.net/projects/getprathamos/files/Adyah/1.1/Kernelaa
	FILE="Kernelaa"
	FILESUCCESS="NO"
	if [ -f "$FILE" ]
	then
		FILESUCCESS="YES"
	else
		wget https://github.com/ThePrathamOS/Adyah/raw/master/1.1/Kernelaa
		if [ -f "$FILE" ]
		then
			FILESUCCESS="YES"
		fi
		if [ "$FILESUCCESS" == "NO" ] || [ "$FILESUCCESS" == "NO" ] ; then
			echo "Unable To Connect Repository.Please Try Again Later."
			exit
		fi
	fi		
}
function Chunk2(){
	wget https://sourceforge.net/projects/getprathamos/files/Adyah/1.1/Kernelab
	FILE="Kernelab"
	FILESUCCESS="NO"
	if [ -f "$FILE" ]
	then
		FILESUCCESS="YES"
	else
		wget https://github.com/ThePrathamOS/Adyah/raw/master/1.1/Kernelab
		if [ -f "$FILE" ]
		then
			FILESUCCESS="YES"
		fi
		if [ "$FILESUCCESS" == "NO" ] || [ "$FILESUCCESS" == "NO" ] ; then
			echo "Unable To Connect Repository.Please Try Again Later."
			exit
		fi
	fi		
}
function Chunk3(){
	wget https://sourceforge.net/projects/getprathamos/files/Adyah/1.1/Kernelac
	FILE="Kernelac"
	FILESUCCESS="NO"
	if [ -f "$FILE" ]
	then
		FILESUCCESS="YES"
	else
		wget https://github.com/ThePrathamOS/Adyah/raw/master/1.1/Kernelac
		if [ -f "$FILE" ]
		then
			FILESUCCESS="YES"
		fi
		if [ "$FILESUCCESS" == "NO" ] || [ "$FILESUCCESS" == "NO" ] ; then
			echo "Unable To Connect Repository.Please Try Again Later."
			exit
		fi
	fi		
}
function Chunk4(){
	wget https://sourceforge.net/projects/getprathamos/files/Adyah/1.1/Kernelad
	FILE="Kernelad"
	FILESUCCESS="NO"
	if [ -f "$FILE" ]
	then
		FILESUCCESS="YES"
	else
		wget https://github.com/ThePrathamOS/Adyah/raw/master/1.1/Kernelad
		if [ -f "$FILE" ]
		then
			FILESUCCESS="YES"
		fi
		if [ "$FILESUCCESS" == "NO" ] || [ "$FILESUCCESS" == "NO" ] ; then
			echo "Unable To Connect Repository.Please Try Again Later."
			exit
		fi
	fi		
}

export -f Chunk1 && export -f Chunk2 && export -f Chunk3 && export -f Chunk4
parallel -j 4 ::: Chunk1 Chunk2 Chunk3 Chunk4
touch FILES
FILE="Kernelaa"
if [ -f "$FILE" ]
then
	echo -n "1" >> FILES
fi
FILE="Kernelaa"
if [ -f "$FILE" ]
then
	echo -n "2" >> FILES
fi
FILE="Kernelaa"
if [ -f "$FILE" ]
then
	echo -n "3" >> FILES
fi
FILE="Kernelaa"
if [ -f "$FILE" ]
then
	echo -n "4" >> FILES
fi
read -r TOTAL</opt/KernelUpdate/FILES
rm -f FILES
if [ "$TOTAL" = "1234" ]; then
	cat Kernel* > Kernel.tar.xz
	tar xf Kernel.tar.xz
	cd Kernel
	ls -l
	notify-send -t 5000 "PrathamOS Kernel Update" "\nInstalling Modules & Headers..."
	xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
	mpv /opt/anapmi/modheaders.mp3
	xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
	echo "Installing Modules & Headers..."
	sudo gdebi -n linux-modules-4.17.0-041700-generic_4.17.0-041700.201806032231_amd64.deb
	sudo gdebi -n linux-headers-4.17.0-041700_4.17.0-041700.201806032231_all.deb
	sudo gdebi -n linux-headers-4.17.0-041700-generic_4.17.0-041700.201806032231_amd64.deb
	sudo gdebi -n linux-image-unsigned-4.17.0-041700-generic_4.17.0-041700.201806032231_amd64.deb

	CurrentUser=$(whoami)
	CurrentKernelFull=$(uname -r)
	CurrentKernel=$(uname -r | sed s.-generic.''.g)	
echo "#!/bin/bash

notify-send -t 5000 \"PrathamOS Kernel Update\" \"\nRemoving Kernel $CurrentKernelFull...\"
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
mpv /opt/anapmi/oldkernel.mp3
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
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
rm -f /home/$CurrentUser/.config/autostart/KernelPostRestart.desktop
rm -f /opt/KernelPostRestart.sh
rm -Rf /opt/KernelUpdate
sed -i 's/$CurrentKernelFull/4.17.0-041700-generic/g' /opt/essentials/unsyncedupdates.html
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
