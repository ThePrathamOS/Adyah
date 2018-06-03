#!/bin/bash

#executeorder66 bug
#libreoffice
#draw.io
#zoom
#masterpdf
#calibre

sed -i '74s~.*~~' /opt/essentials/PrathamOSUpGradeFull.sh
sed -i '74s~.*~sudo service network-manager restart \&\& sleep 30~' /opt/essentials/PrathamOSUpGradeFull.sh

cd /opt/UnSyncedUpdate
axel -n 10 https://sourceforge.net/projects/getprathamos/files/Adyah/1.1/UnSynced.7z

FILE="/opt/UnSyncedUpdate/UnSynced.7z"

if [ -f "$FILE" ]
then
	md5sum=$(md5sum $FILE | awk '{print $1}')

	if [ "$md5sum" = "fdcfa79462d7739782c1d8072e502d3e" ]; then
		sudo 7z x UnSynced.7z -o.
		sudo rm -f UnSynced.7z	

		cd /opt/essentials/appimages
		mkdir temp
		cd temp
		mv /opt/UnSyncedUpdate/UnSynced/draw.io-x86_64-8.6.5.AppImage .
		cd ~

		cd /opt/essentials/libreoffice
		mkdir temp
		cd temp
		mv /opt/UnSyncedUpdate/UnSynced/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage .
		cd ~

		cd /opt/UnSyncedUpdate
		touch FILES

		sudo rm -Rf /opt/essentials/calibre
		sudo mkdir -p /opt/essentials/calibre/calibre
		sudo chmod 777 -R /opt/essentials/calibre
		sudo mv UnSynced/calibre-3.25.0-x86_64.txz /opt/essentials/calibre/calibre
		pushd /opt/essentials/calibre/calibre
		tar xf calibre-3.25.0-x86_64.txz
		rm -f calibre-3.25.0-x86_64.txz
		popd
		echo '#!/bin/bash

/opt/essentials/calibre/calibre/calibre' | sudo tee /opt/essentials/calibre/calibre.sh
		sudo chmod 777 -R /opt/essentials/calibre
		sed -i '50s~.*~<tr><td>Calibre</td><td>3.25</td><td><a href="https://calibre-ebook.com/download_linux" target=_blank>https://calibre-ebook.com/download_linux</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo gdebi -n UnSynced/master-pdf-editor-5.0.15_qt5.amd64.deb
		sudo ln -s /opt/master-pdf-editor-5 /opt/master-pdf-editor-4
		sudo chmod 777 -R /opt/master-pdf-editor-5
		sudo chmod 777 -R /opt/master-pdf-editor-4
		sudo ln -s /opt/master-pdf-editor-5/masterpdfeditor5 /opt/master-pdf-editor-4/masterpdfeditor4
		sudo ln -s /opt/master-pdf-editor-5/masterpdfeditor5.png /opt/master-pdf-editor-4/masterpdfeditor4.png
		sed -i '55s~.*~<tr><td>Master Pdf Editor</td><td>5.0.15</td><td><a href="https://code-industry.net/free-pdf-editor/#get" target=_blank>https://code-industry.net/free-pdf-editor/#get</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo rm -Rf /opt/essentials/zoom
		sudo mkdir /opt/essentials/zoom
		sudo chmod 777 -R /opt/essentials/zoom
		sudo mv UnSynced/zoom_amd64.deb /opt/essentials/zoom
		sudo rm -Rf /opt/essentials/zoom/opt
		sudo rm -Rf /opt/essentials/zoom/usr
		pushd /opt/essentials/zoom
		for i in /opt/essentials/zoom/*deb; do sudo dpkg-deb -x $i . ; done
		popd
		echo '#!/bin/bash

/opt/essentials/zoom/opt/zoom/ZoomLauncher' | sudo tee /opt/essentials/zoom/zoom.sh
		sudo chmod 777 -R /opt/essentials/zoom
		sudo rm -f /opt/essentials/zoom/zoom_amd64.deb
		sed -i '71s~.*~<tr><td>Zoom</td><td>2.1.103753.0521</td><td><a href="https://zoom.us/download#client_4meeting" target=_blank>https://zoom.us/download#client_4meeting</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		FILE="/opt/essentials/appimages/temp/draw.io-x86_64-8.6.5.AppImage"
		if [ -f "$FILE" ]
		then
			echo -n "1" >> FILES
		else
			rm -rf /opt/essentials/appimages/temp
		fi
		
		FILE="/opt/essentials/libreoffice/temp/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage"
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
			sed -i '73s~.*~<tr><td>Draw.io</td><td>8.6.5</td><td><a href="https://github.com/jgraph/drawio-desktop/releases" target=_blank>https://github.com/jgraph/drawio-desktop/releases</a></td></tr>~' /opt/essentials/unsyncedupdates.html

			rm -f /opt/essentials/libreoffice/LibreOffice*
			mv /opt/essentials/libreoffice/temp/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage /opt/essentials/libreoffice
			rm -rf /opt/essentials/libreoffice/temp
			sudo chmod 777 /opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage
			sed -i '4 s/^/#/' /opt/essentials/libreoffice/base.sh
			sed -i '4 s/^/#/' /opt/essentials/libreoffice/calc.sh
			sed -i '4 s/^/#/' /opt/essentials/libreoffice/draw.sh
			sed -i '4 s/^/#/' /opt/essentials/libreoffice/impress.sh
			sed -i '4 s/^/#/' /opt/essentials/libreoffice/math.sh
			sed -i '4 s/^/#/' /opt/essentials/libreoffice/normal.sh
			sed -i '4 s/^/#/' /opt/essentials/libreoffice/writer.sh
			echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage --base" >> /opt/essentials/libreoffice/base.sh
			echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage --calc" >> /opt/essentials/libreoffice/calc.sh
			echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage --draw" >> /opt/essentials/libreoffice/draw.sh
			echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage --impress" >> /opt/essentials/libreoffice/impress.sh
			echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage --math" >> /opt/essentials/libreoffice/math.sh
			echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage" >> /opt/essentials/libreoffice/normal.sh
			echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage --writer" >> /opt/essentials/libreoffice/writer.sh
			sed -i '83s~.*~<tr><td>LibreOffice</td><td>6.2.0.0.alpha0</td><td><a href="https://libreoffice.soluzioniopen.com/" target=_blank>https://libreoffice.soluzioniopen.com/</a></td></tr>~' /opt/essentials/unsyncedupdates.html

			rm -Rf /opt/UnSyncedUpdate
			rm -f /opt/POSUPDATE
			sudo -H -u root bash -c 'echo "1.1" | tee /etc/apt/ver'

			sudo kill $(ps -ef | grep bash | grep Notification | awk '{print $2}')
			sudo kill $(ps -ef | grep yad | grep notification | awk '{print $2}')

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
			rm -Rf /opt/UnSyncedUpdate
			rm -f /opt/POSUPDATE
			exit
		fi	
	else
		notify-send -t 5000 "PrathamOS UnSynced Update" "\nUnable To Connect Repository.\nPlease Try Again Later..."
		xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
		mpv /opt/anapmi/norepo.mp3
		xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
		echo "Unable To Connect Repository.Please Try Again Later."
		rm -Rf /opt/UnSyncedUpdate
		rm -f /opt/POSUPDATE
		exit
	fi
else
	notify-send -t 5000 "PrathamOS UnSynced Update" "\nUnable To Connect Repository.\nPlease Try Again Later..."
	xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
	mpv /opt/anapmi/norepo.mp3
	xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
	echo "Unable To Connect Repository.Please Try Again Later."
	rm -Rf /opt/UnSyncedUpdate
	rm -f /opt/POSUPDATE
	exit
fi
