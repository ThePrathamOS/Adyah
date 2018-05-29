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
	#gdebi -n linux-modules-4.16.12-041612-generic_4.16.12-041612.201805251538_amd64.deb
	#gdebi -n linux-headers-4.16.12-041612_4.16.12-041612.201805251538_all.deb
	#gdebi -n linux-headers-4.16.12-041612-generic_4.16.12-041612.201805251538_amd64.deb
	#gdebi -n linux-image-unsigned-4.16.12-041612-generic_4.16.12-041612.201805251538_amd64.deb
else
	echo "Unable To Connect Repository.Please Try Again Later."
	exit
fi
