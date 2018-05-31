#!/bin/bash

#anaconda
#.net
#rstudio
#pycharm
#libreoffice
#tally
#marg
#draw.io
#zoom
#masterpdf
#calibre

cd /opt/essentials/appimages
mkdir temp
cd temp
wget https://github.com/jgraph/drawio-desktop/releases/download/v8.6.5/draw.io-x86_64-8.6.5.AppImage
cd ~

cd /opt/essentials/libreoffice
mkdir temp
cd temp
wget https://libreoffice.soluzioniopen.com/daily/LibreOfficeDev-6.2.0.0.alpha0_2018-05-24-x86_64.AppImage
cd ~

cd /opt/UnSyncedUpdate
touch FILES
FILE="/opt/essentials/appimages/temp/draw.io-x86_64-8.6.5.AppImage"
if [ -f "$FILE" ]
then
	echo -n "1" >> FILES
else
	rm -rf /opt/essentials/appimages/temp
fi
FILE="/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-05-24-x86_64.AppImage"
if [ -f "$FILE" ]
then
	echo -n "2" >> FILES
else
	rm -rf /opt/essentials/libreoffice/temp
fi

read -r TOTAL</opt/UnSyncedUpdate/FILES
rm -f FILES
if [ "$TOTAL" = "12" ]; then
	rm -f /opt/essentials/appimages/draw.io*
	mv /opt/essentials/appimages/temp/draw.io-x86_64-8.6.5.AppImage /opt/essentials/appimages
	rm -rf /opt/essentials/appimages/temp
	sed -i '4 s/^/#/' /opt/essentials/appimages/drawio.sh
	sudo chmod 777 /opt/essentials/appimages/draw.io-x86_64-8.6.5.AppImage
	echo -e "/opt/essentials/appimages/draw.io-x86_64-8.6.5.AppImage" >> /opt/essentials/appimages/drawio.sh
	sed -i '73s~.*~<tr><td>Draw.io</td><td>8.6.5</td><td><a href="https://github.com/jgraph/drawio-desktop/releases" target=_blank>https://github.com/jgraph/drawio-desktop/releases</a></td></tr>~' /opt/unsyncedupdates.html

	rm -f /opt/essentials/libreoffice/LibreOffice*
	mv /opt/essentials/libreoffice/temp/LibreOfficeDev-6.2.0.0.alpha0_2018-05-24-x86_64.AppImage /opt/essentials/libreoffice
	rm -rf /opt/essentials/libreoffice/temp
	sudo chmod 777 /opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-05-24-x86_64.AppImage
	sed -i '4 s/^/#/' /opt/essentials/libreoffice/base.sh
	sed -i '4 s/^/#/' /opt/essentials/libreoffice/calc.sh
	sed -i '4 s/^/#/' /opt/essentials/libreoffice/draw.sh
	sed -i '4 s/^/#/' /opt/essentials/libreoffice/impress.sh
	sed -i '4 s/^/#/' /opt/essentials/libreoffice/math.sh
	sed -i '4 s/^/#/' /opt/essentials/libreoffice/normal.sh
	sed -i '4 s/^/#/' /opt/essentials/libreoffice/writer.sh
	echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-05-24-x86_64.AppImage --base" >> /opt/essentials/libreoffice/base.sh
	echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-05-24-x86_64.AppImage --calc" >> /opt/essentials/libreoffice/calc.sh
	echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-05-24-x86_64.AppImage --draw" >> /opt/essentials/libreoffice/draw.sh
	echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-05-24-x86_64.AppImage --impress" >> /opt/essentials/libreoffice/impress.sh
	echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-05-24-x86_64.AppImage --math" >> /opt/essentials/libreoffice/math.sh
	echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-05-24-x86_64.AppImage" >> /opt/essentials/libreoffice/normal.sh
	echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-05-24-x86_64.AppImage --writer" >> /opt/essentials/libreoffice/writer.sh
	sed -i '83s~.*~<tr><td>LibreOffice</td><td>6.2.0.0.alpha0</td><td><a href="https://libreoffice.soluzioniopen.com/" target=_blank>https://libreoffice.soluzioniopen.com/</a></td></tr>~' /opt/unsyncedupdates.html

	rm -Rf /opt/UnSyncedUpdate
	rm -f /opt/POSUPDATE
	echo "1.1" | tee /etc/apt/ver

	notify-send -t 5000 "PrathamOS UnSynced Update" "\nUnSynced Software Updated Successfully..."
	xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
	mpv /opt/anapmi/unsyupdsuc.mp3
	xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
	echo "UnSynced Software Updated Successfully..."

	firefox /opt/essentials/unsyncedupdates.html
else
	notify-send -t 5000 "PrathamOS UnSynced Update" "\nUnable To Connect Repository.\nPlease Try Again Later..."
	xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
	mpv /opt/anapmi/norepo.mp3
	xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
	echo "Unable To Connect Repository.Please Try Again Later."
	rm -Rf /opt/KernelUpdate
	rm -f /opt/KERNELUPDATE
	exit
fi
