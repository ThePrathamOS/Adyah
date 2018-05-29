#!/bin/bash

function Chunk1(){
	wget https://sourceforge.net/projects/getprathamos/files/Adyah/1.1/Kernelaa
	FILE="Kernelaa"
	FILESUCCESS="NO"
	if [ -f "$FILE" ]
	then
		FILESUCCESS="YES"
	else
		wget https://github.com/ThePrathamOS/Adyah/blob/master/1.1/Kernelaa
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
		wget https://github.com/ThePrathamOS/Adyah/blob/master/1.1/Kernelab
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
		wget https://github.com/ThePrathamOS/Adyah/blob/master/1.1/Kernelac
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
		wget https://github.com/ThePrathamOS/Adyah/blob/master/1.1/Kernelad
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
	sudo gdebi -n linux-modules-4.16.12-041612-generic_4.16.12-041612.201805251538_amd64.deb
	sudo gdebi -n linux-headers-4.16.12-041612_4.16.12-041612.201805251538_all.deb
	sudo gdebi -n linux-headers-4.16.12-041612-generic_4.16.12-041612.201805251538_amd64.deb
	sudo gdebi -n linux-image-unsigned-4.16.12-041612-generic_4.16.12-041612.201805251538_amd64.deb
	CurrentUser=$(whoami)
	CurrentKernelFull=$(uname -r)
	CurrentKernel=$(uname -r | sed s.-generic.''.g)	
echo "#!/bin/bash

notify-send -t 5000 \"PrathamOS Kernel Sync\" \"\nRemoving Kernel $CurrentKernelFull...\"
sudo apt-get remove -y linux-headers-$CurrentKernel
sudo apt-get remove -y linux-headers-$CurrentKernelFull
sudo apt-get remove -y linux-image-unsigned-$CurrentKernelFull
sudo apt-get remove -y linux-modules-$CurrentKernelFull
sudo rm -Rf /usr/src/linux-headers-$CurrentKernel
sudo rm -Rf /usr/src/linux-headers-$CurrentKernelFull
sudo rm -Rf /lib/modules/$CurrentKernelFull
notify-send -t 5000 \"PrathamOS Kernel Sync\" \"\nInstalling VMWare Modules...\"
sudo vmware-modconfig --console --install-all
notify-send -t 5000 \"PrathamOS Kernel Sync\" \"\nInstalling VirtualBox Modules...\"
sudo dpkg-reconfigure virtualbox-dkms
rm -f /home/$CurrentUser/.config/autostart/KernelPostRestart.desktop
rm -f /opt/KernelPostRestart.sh
notify-send -t 5000 \"PrathamOS Kernel Sync\" \"\nUpdating Grub...\"
sudo update-grub

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
	sudo update-grub
	xfce4-session-logout -r
else
	echo "Unable To Connect Repository.Please Try Again Later."
	exit
fi
