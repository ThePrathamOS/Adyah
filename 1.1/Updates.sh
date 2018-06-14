#!/bin/bash

#executeorder66 bug
#mimetypes
#libreoffice
#draw.io
#zoom
#masterpdf
#calibre
#freefilesync
#syncthing
#prathamos-install
#updateconda
#prathamos-get
#oracle & open java 10

sed -i '74s~.*~~' /opt/essentials/PrathamOSUpGradeFull.sh
sed -i '74s~.*~sudo service network-manager restart \&\& sleep 30~' /opt/essentials/PrathamOSUpGradeFull.sh

cd /opt/UnSyncedUpdate

axel https://sourceforge.net/projects/getprathamos/files/Adyah/PackInstaller.sh
FILE2="/opt/UnSyncedUpdate/PackInstaller.sh"

if [ -f "$FILE2" ]
then
	sudo rm -Rf /opt/prathamos-install
	sudo mkdir /opt/prathamos-install
	sudo cp /opt/UnSyncedUpdate/PackInstaller.sh /opt/prathamos-install
	sudo rm -f /usr/bin/prathamos-install
	sudo ln -s /opt/prathamos-install/PackInstaller.sh /usr/bin/prathamos-install
	sudo chown -R root:root /opt/prathamos-install 
	sudo chmod 777 -R /opt/prathamos-install
	echo "#!/bin/bash

sudo -H -u root bash -c 'source /opt/anaconda3/bin/activate root && conda update --all -y && conda clean --all -y'" | sudo tee /opt/essentials/RefreshAnaconda.sh
	sudo ln -s /opt/essentials/RefreshAnaconda.sh /usr/bin/updateconda
	sudo chmod 777 /opt/essentials/RefreshAnaconda.sh
	echo "#!/bin/bash

sudo rm -f GetPOS.sh
axel https://sourceforge.net/projects/getprathamos/files/Adyah/GetPOS.sh
if [ -f \"GetPOS.sh\" ]
then
	sudo chmod 777 GetPOS.sh
	./GetPOS.sh
	sudo rm -f GetPOS.sh
	exit
else
	exit
fi
" | sudo tee /opt/essentials/GetPrathamOS.sh
	sudo ln -s /opt/essentials/GetPrathamOS.sh /usr/bin/prathamos-get
	sudo chmod 777 /opt/essentials/GetPrathamOS.sh
else
	notify-send -t 5000 "PrathamOS UnSynced Update" "\nUnable To Connect Repository.\nPlease Try Again Later..."
	xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
	mpv /opt/anapmi/norepo.mp3
	xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
	echo "Unable To Connect Repository.Please Try Again Later."
	sudo rm -Rf /opt/UnSyncedUpdate
	sudo rm -f /opt/POSUPDATE
	exit
fi

axel https://sourceforge.net/projects/getprathamos/files/Adyah/1.1/UnSynced.7z
FILE="/opt/UnSyncedUpdate/UnSynced.7z"

if [ -f "$FILE" ]
then
	md5sum=$(md5sum $FILE | awk '{print $1}')

	if [ "$md5sum" = "44e44ea306cb379d3718ecfd815a7a43" ]; then
		sudo 7z x UnSynced.7z -o.
		sudo rm -f UnSynced.7z	
		
		sudo rm -Rf /opt/essentials/appimages/temp
		sudo rm -Rf /opt/essentials/libreoffice/temp
		
		cd /opt/essentials/appimages
		sudo mkdir temp
		cd temp
		sudo mv /opt/UnSyncedUpdate/UnSynced/draw.io-x86_64-8.6.5.AppImage .
		cd ~

		cd /opt/essentials/libreoffice
		sudo mkdir temp
		cd temp
		sudo mv /opt/UnSyncedUpdate/UnSynced/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage .
		cd ~

		cd /opt/UnSyncedUpdate

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

		sudo rm -Rf /opt/essentials/freefilesync
		sudo mv UnSynced/freefilesync /opt/essentials
		sudo chmod 777 -R /opt/essentials/freefilesync
		sed -i '56s~.*~<tr><td>FreeFileSync</td><td>10.1</td><td><a href='https://freefilesync.org/download.php' target=_blank>https://freefilesync.org/download.php</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo rm -Rf /opt/essentials/syncthing
		sudo mv UnSynced/syncthing /opt/essentials
		sed -i '63s~.*~<tr><td>Syncthing</td><td>Core - v0.14.49-rc.1 / GUI - 0.9.4</td><td><a href='https://syncthing.net/' target=_blank>https://syncthing.net/</a></td></tr>~' /opt/essentials/unsyncedupdates.html
		sudo rm -f /usr/bin/syncthing
		sudo ln -s /opt/essentials/syncthing/core/syncthing /usr/bin/syncthing
		sudo chmod 777 -R /opt/essentials/syncthing

		sudo rm -Rf /opt/master-pdf-editor-4
		sudo rm -Rf /opt/master-pdf-editor-5
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

		TOTAL="12"
		if [ "$TOTAL" = "12" ]; then
			sudo rm -f /opt/essentials/appimages/draw.io*
			sudo mv /opt/essentials/appimages/temp/draw.io-x86_64-8.6.5.AppImage /opt/essentials/appimages
			sudo rm -rf /opt/essentials/appimages/temp
			sudo sed -i '4 s/^/#/' /opt/essentials/appimages/drawio.sh
			sudo chmod 777 /opt/essentials/appimages/draw.io-x86_64-8.6.5.AppImage
			sudo echo -e "/opt/essentials/appimages/draw.io-x86_64-8.6.5.AppImage" >> /opt/essentials/appimages/drawio.sh
			sed -i '73s~.*~<tr><td>Draw.io</td><td>8.6.5</td><td><a href="https://github.com/jgraph/drawio-desktop/releases" target=_blank>https://github.com/jgraph/drawio-desktop/releases</a></td></tr>~' /opt/essentials/unsyncedupdates.html

			sudo rm -f /opt/essentials/libreoffice/LibreOffice*
			sudo mv /opt/essentials/libreoffice/temp/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage /opt/essentials/libreoffice
			sudo rm -rf /opt/essentials/libreoffice/temp
			sudo chmod 777 /opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage
			sudo sed -i '4 s/^/#/' /opt/essentials/libreoffice/base.sh
			sudo sed -i '4 s/^/#/' /opt/essentials/libreoffice/calc.sh
			sudo sed -i '4 s/^/#/' /opt/essentials/libreoffice/draw.sh
			sudo sed -i '4 s/^/#/' /opt/essentials/libreoffice/impress.sh
			sudo sed -i '4 s/^/#/' /opt/essentials/libreoffice/math.sh
			sudo sed -i '4 s/^/#/' /opt/essentials/libreoffice/normal.sh
			sudo sed -i '4 s/^/#/' /opt/essentials/libreoffice/writer.sh
			sudo echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage --base" >> /opt/essentials/libreoffice/base.sh
			sudo echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage --calc" >> /opt/essentials/libreoffice/calc.sh
			sudo echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage --draw" >> /opt/essentials/libreoffice/draw.sh
			sudo echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage --impress" >> /opt/essentials/libreoffice/impress.sh
			sudo echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage --math" >> /opt/essentials/libreoffice/math.sh
			sudo echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage" >> /opt/essentials/libreoffice/normal.sh
			sudo echo -e "/opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage --writer" >> /opt/essentials/libreoffice/writer.sh
			sed -i '83s~.*~<tr><td>LibreOffice</td><td>6.2.0.0.alpha0</td><td><a href="https://libreoffice.soluzioniopen.com/" target=_blank>https://libreoffice.soluzioniopen.com/</a></td></tr>~' /opt/essentials/unsyncedupdates.html
			sudo rm -f /usr/bin/office
			sudo ln -s /opt/essentials/libreoffice/LibreOfficeDev-6.2.0.0.alpha0_2018-06-01-x86_64.AppImage /usr/bin/office
			sudo sed -i '24i/usr/bin/office' /opt/essentials/prathamos
			sudo sed -i '18i/usr/bin/prathamos-install' /opt/essentials/prathamos
			sudo sed -i '117i/usr/bin/updateconda' /opt/essentials/prathamos
			sudo sed -i '18i/usr/bin/prathamos-get' /opt/essentials/prathamos
			sudo sed -i '112i/usr/bin/setupopenjdk10' /opt/essentials/prathamos
			sudo sed -i '114i/usr/bin/setuporaclejdk10' /opt/essentials/prathamos
			
			CURUSER=$(whoami)
			UUID=$(uuidgen) && A=${UUID:0:6}
			UUID=$(uuidgen) && B=${UUID:0:6}
			UUID=$(uuidgen) && C=${UUID:0:6}
			UUID=$(uuidgen) && D=${UUID:0:6}
			UUID=$(uuidgen) && E=${UUID:0:6}
			UUID=$(uuidgen) && F=${UUID:0:6}
			rm -f /home/$CURUSER/.local/share/applications/*Office*
			rm -f /home/$CURUSER/.local/share/applications/*office*
			echo "[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
NoDisplay=true
Exec=office %f
Name=userapp-Libre-Office-"$A".desktop
Comment=Custom definition for office" | tee /home/$CURUSER/.local/share/applications/userapp-Libre-Office-"$A".desktop
			echo "[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
NoDisplay=true
Exec=office %f
Name=userapp-Libre-Office-"$B".desktop
Comment=Custom definition for office" | tee /home/$CURUSER/.local/share/applications/userapp-Libre-Office-"$B".desktop
			echo "[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
NoDisplay=true
Exec=office %f
Name=userapp-Libre-Office-"$C".desktop
Comment=Custom definition for office" | tee /home/$CURUSER/.local/share/applications/userapp-Libre-Office-"$C".desktop
			echo "[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
NoDisplay=true
Exec=office %f
Name=userapp-Libre-Office-"$D".desktop
Comment=Custom definition for office" | tee /home/$CURUSER/.local/share/applications/userapp-Libre-Office-"$D".desktop
			echo "[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
NoDisplay=true
Exec=office %f
Name=userapp-office-"$E".desktop
Comment=Custom definition for office" | tee /home/$CURUSER/.local/share/applications/userapp-office-"$E".desktop
			echo "[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
NoDisplay=true
Exec=office %f
Name=userapp-office-"$F".desktop
Comment=Custom definition for office" | tee /home/$CURUSER/.local/share/applications/userapp-office-"$F".desktop
			chmod 644 -R /home/$CURUSER/.local/share/applications/userapp-Libre-Office-"$A".desktop
			chmod 644 -R /home/$CURUSER/.local/share/applications/userapp-Libre-Office-"$B".desktop
			chmod 644 -R /home/$CURUSER/.local/share/applications/userapp-Libre-Office-"$C".desktop
			chmod 644 -R /home/$CURUSER/.local/share/applications/userapp-Libre-Office-"$D".desktop
			chmod 644 -R /home/$CURUSER/.local/share/applications/userapp-office-"$E".desktop
			chmod 644 -R /home/$CURUSER/.local/share/applications/userapp-office-"$F".desktop
			rm -f /home/$CURUSER/.config/mimeapps.list
			MIMEFILE="/opt/newuserbase/mimebase"
			if [ -f "$MIMEFILE" ]
			then
				cp /opt/newuserbase/mimebase /home/$CURUSER/.config/mimeapps.list
			else
				cp /opt/newuserbase/.config/mimeapps.list /home/$CURUSER/.config/mimeapps.list
				sudo cp /opt/newuserbase/.config/mimeapps.list /opt/newuserbase/mimebase
			fi
			chmod 644 /home/$CURUSER/.config/mimeapps.list
			sed -i '6s~.*~~' /home/$CURUSER/.config/mimeapps.list
			sed -i '10s~.*~~' /home/$CURUSER/.config/mimeapps.list
			sed -i '11s~.*~~' /home/$CURUSER/.config/mimeapps.list
			sed -i '12s~.*~~' /home/$CURUSER/.config/mimeapps.list
			sed -i '13s~.*~~' /home/$CURUSER/.config/mimeapps.list
			sed -i '20s~.*~~' /home/$CURUSER/.config/mimeapps.list
			sed -i '21s~.*~~' /home/$CURUSER/.config/mimeapps.list
			sed -i '22s~.*~~' /home/$CURUSER/.config/mimeapps.list
			sed -i '23s~.*~~' /home/$CURUSER/.config/mimeapps.list
			sed -i "s/FoxitReader/Acrobat/g" /home/$CURUSER/.config/mimeapps.list
			echo -e "image/jpg=ristretto.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "image/jpeg=ristretto.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "image/gif=ristretto.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "application/vnd.oasis.opendocument.graphics=userapp-Libre-Office-$A.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "application/vnd.oasis.opendocument.presentation=userapp-Libre-Office-$B.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "application/vnd.oasis.opendocument.spreadsheet=userapp-Libre-Office-$C.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "application/vnd.oasis.opendocument.text=userapp-Libre-Office-$D.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "application/vnd.oasis.opendocument.database=userapp-office-$E.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "application/vnd.oasis.opendocument.formula=userapp-office-$F.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "video/3gpp=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "video/x-msvideo=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "video/x-flv=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "video/mp4=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "video/x-matroska=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "video/quicktime=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "video/mpeg=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "video/mp2t=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "video/webm=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "video/x-ms-wmv=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "audio/aac=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "audio/x-aiff=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "audio/AMR=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "audio/flac=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "audio/mpeg=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "audio/x-vorbis+ogg=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "audio/x-wav=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "audio/x-ms-wma=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "application/x-riff=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "audio/mp4=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "audio/mp2=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "audio/x-flac+ogg=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "video/ogg=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "application/zip=org.gnome.FileRoller.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "application/x-compressed-tar=org.gnome.FileRoller.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "application/x-tar=org.gnome.FileRoller.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "application/x-xz-compressed-tar=org.gnome.FileRoller.desktop" >> /home/$CURUSER/.config/mimeapps.list
			echo -e "application/vnd.adobe.flash.movie=vlc.desktop" >> /home/$CURUSER/.config/mimeapps.list

			sudo rm -f /opt/newuserbase/.local/share/applications/*Office*	
			sudo rm -f /opt/newuserbase/.local/share/applications/*office*	
			sudo cp /home/$CURUSER/.local/share/applications/userapp-Libre-Office-"$A".desktop /opt/newuserbase/.local/share/applications
			sudo cp /home/$CURUSER/.local/share/applications/userapp-Libre-Office-"$B".desktop /opt/newuserbase/.local/share/applications
			sudo cp /home/$CURUSER/.local/share/applications/userapp-Libre-Office-"$C".desktop /opt/newuserbase/.local/share/applications
			sudo cp /home/$CURUSER/.local/share/applications/userapp-Libre-Office-"$D".desktop /opt/newuserbase/.local/share/applications
			sudo cp /home/$CURUSER/.local/share/applications/userapp-office-"$E".desktop /opt/newuserbase/.local/share/applications
			sudo cp /home/$CURUSER/.local/share/applications/userapp-office-"$F".desktop /opt/newuserbase/.local/share/applications
			sudo rm -f /opt/newuserbase/.config/mimeapps.list		
			sudo cp /home/$CURUSER/.config/mimeapps.list /opt/newuserbase/.config/mimeapps.list
			sudo chmod 777 -R /opt/newuserbase

			sudo chmod 777 -R /opt/essentials/libreoffice
			sudo chmod 777 -R /opt/essentials/appimages

			sed -i '26s~.*~<tr><td>Anaconda</td><td>3-5.2.0-Linux-x86_64</td><td><a href="https://www.anaconda.com/download/#linux" target=_blank>https://www.anaconda.com/download/#linux</a></td></tr>~' /opt/essentials/unsyncedupdates.html
			sed -i '38s~.*~<tr><td>PyCharm</td><td>2018.1.4</td><td><a href="https://www.jetbrains.com/pycharm/download/#section=linux" target=_blank>https://www.jetbrains.com/pycharm/download/#section=linux</a></td></tr>~' /opt/essentials/unsyncedupdates.html
			sed -i '31s~.*~<tr><td>.Net Core</td><td>2.1.300</td><td><a href="https://www.microsoft.com/net/download/linux" target=_blank>https://www.microsoft.com/net/download/linux</a></td></tr>~' /opt/essentials/unsyncedupdates.html
			sed -i '39s~.*~<tr><td>RStudio</td><td>1.1.453</td><td><a href='https://www.rstudio.com/products/rstudio/download/#download' target=_blank>https://www.rstudio.com/products/rstudio/download/#download</a></td></tr>~' /opt/essentials/unsyncedupdates.html
			sed -i '28s~.*~~' /opt/essentials/unsyncedupdates.html
			sed -i '28s~.*~<tr><td>OpenJDK</td><td>10.0.1</td><td><a href="http://jdk.java.net/10/" target=_blank>http://jdk.java.net/10/</a></td></tr><tr><td>Oracle Java</td><td>8u172 / 10.0.1</td><td><a href="http://www.oracle.com/technetwork/java/javase/downloads/index.html" target=_blank>http://www.oracle.com/technetwork/java/javase/downloads/index.html</a></td></tr>~' /opt/essentials/unsyncedupdates.html

			sudo rm -f /opt/java/setupopenjdk.sh
			sudo rm -f /opt/java/setupopenjdk10.sh
			sudo rm -f /opt/java/setuporaclejdk.sh
			sudo rm -f /opt/java/setuporaclejdk10.sh
			sudo rm -f /usr/bin/setupopenjdk
			sudo rm -f /usr/bin/setupopenjdk10
			sudo rm -f /usr/bin/setuporaclejdk
			sudo rm -f /usr/bin/setuporaclejdk10
			sudo cp /opt/UnSyncedUpdate/UnSynced/setupopenjdk.sh /opt/java/setupopenjdk.sh
			sudo cp /opt/UnSyncedUpdate/UnSynced/setupopenjdk10.sh /opt/java/setupopenjdk10.sh
			sudo cp /opt/UnSyncedUpdate/UnSynced/setuporaclejdk.sh /opt/java/setuporaclejdk.sh
			sudo cp /opt/UnSyncedUpdate/UnSynced/setuporaclejdk10.sh /opt/java/setuporaclejdk10.sh
			sudo chmod 777 /opt/java/setupopenjdk.sh
			sudo chmod 777 /opt/java/setupopenjdk10.sh
			sudo chmod 777 /opt/java/setuporaclejdk.sh
			sudo chmod 777 /opt/java/setuporaclejdk10.sh
			sudo ln -s /opt/java/setupopenjdk.sh /usr/bin/setupopenjdk
			sudo ln -s /opt/java/setupopenjdk10.sh /usr/bin/setupopenjdk10
			sudo ln -s /opt/java/setuporaclejdk.sh /usr/bin/setuporaclejdk
			sudo ln -s /opt/java/setuporaclejdk10.sh /usr/bin/setuporaclejdk10

			sudo rm -Rf /opt/UnSyncedUpdate
			sudo rm -f /opt/POSUPDATE
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
			sudo rm -Rf /opt/UnSyncedUpdate
			sudo rm -f /opt/POSUPDATE
			exit
		fi	
	else
		notify-send -t 5000 "PrathamOS UnSynced Update" "\nUnable To Connect Repository.\nPlease Try Again Later..."
		xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
		mpv /opt/anapmi/norepo.mp3
		xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
		echo "Unable To Connect Repository.Please Try Again Later."
		sudo rm -Rf /opt/UnSyncedUpdate
		sudo rm -f /opt/POSUPDATE
		exit
	fi
else
	notify-send -t 5000 "PrathamOS UnSynced Update" "\nUnable To Connect Repository.\nPlease Try Again Later..."
	xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /opt/anapmi/AI.png	
	mpv /opt/anapmi/norepo.mp3
	xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set /usr/share/backgrounds/xfce/PrathamOS.png
	echo "Unable To Connect Repository.Please Try Again Later."
	sudo rm -Rf /opt/UnSyncedUpdate
	sudo rm -f /opt/POSUPDATE
	exit
fi

