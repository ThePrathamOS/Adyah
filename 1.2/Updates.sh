#!/bin/bash

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

	sudo sed -i '132s~.*~~' /opt/essentials/PrathamOSKernelUpGrade.sh
	sudo sed -i '132s~.*~		if [ "${CURRENT[0]}-${CURRENT[1]}" = "$LATEST" ]; then~' /opt/essentials/PrathamOSKernelUpGrade.sh
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

read -r _CURRENT</etc/apt/ver
if [ "$_CURRENT" = "1.0" ]; then
	axel https://sourceforge.net/projects/getprathamos/files/Adyah/1.2/1.1/UnSynced.7z
else
	axel https://sourceforge.net/projects/getprathamos/files/Adyah/1.2/UnSynced.7z
fi
FILE="/opt/UnSyncedUpdate/UnSynced.7z"

if [ -f "$FILE" ]
then
	md5sum=$(md5sum $FILE | awk '{print $1}')

	if [ "$md5sum" == "4a6c6e7d5c2ec534641611eaf9e8a1b3" ] || [ "$md5sum" == "22801d4bdf31ced6edf13a7c5cb0c05a" ] ; then
		sudo 7z x UnSynced.7z -o.
		sudo rm -f UnSynced.7z
	
		read -r CURRENT</etc/apt/ver

		if [ "$CURRENT" = "1.0" ]; then
			cd UnSynced/updates/1.1	
			sudo chmod 777 Updates.sh
			./Updates.sh
			cd ..
			cd ..
			cd ..
		fi

		if [ ! -d "/opt/nginx" ]; then
			sudo mkdir /opt/nginx
			sudo cp UnSynced/50x.html /opt/nginx
			sudo cp UnSynced/404.html /opt/nginx
			sudo cp UnSynced/index.html /opt/nginx
			sudo cp UnSynced/nginx-logo.png /opt/nginx
			sudo cp UnSynced/poweredby.png /opt/nginx
			sudo rm -Rf /opt/essentials/thebeaconsarelit/fancyindex
			sudo rm -Rf /opt/essentials/thebeaconsarelit/img
			sudo rm -Rf /opt/essentials/thebeaconsarelit/index.html
			sudo cp -R UnSynced/fancyindex /opt/essentials/thebeaconsarelit
			sudo sed -i 's./opt/essentials/thebeaconsarelit./opt/nginx.g' /etc/nginx/conf.d/default.conf
			sudo sed -i 's./opt/essentials/thebeaconsarelit./opt/nginx.g' /etc/nginx/sites-available/default
			sudo rm -f /etc/nginx/sites-available/thebeaconsarelit
			sudo rm -f /etc/nginx/sites-enabled/thebeaconsarelit
			sudo rm -f /opt/essentials/thebeaconsarelit/ExtendTheReach.sh
			sudo cp UnSynced/ExtendTheReach.sh /opt/essentials/thebeaconsarelit
			sudo rm -f /usr/bin/prathamos-share
			sudo ln -s /opt/essentials/thebeaconsarelit/ExtendTheReach.sh /usr/bin/prathamos-share
			sudo sed -i '21i/usr/bin/prathamos-share' /opt/essentials/prathamos
			sudo chmod 777 -R /opt/essentials/thebeaconsarelit
			sudo cp -Rf UnSynced/etr.png /opt/icons/etr.png
			sudo cp -Rf UnSynced/etr.desktop /opt/etr.desktop
			sudo cp -Rf UnSynced/bigdata.png /opt/icons/bigdata.png
			sudo cp -Rf UnSynced/bigdata.png /opt/icons/bitnami.png
			sudo cp -Rf UnSynced/root.png /opt/icons/root.png
			sudo cp -Rf UnSynced/repomaker.desktop /opt/repomaker.desktop
			sudo cp -Rf UnSynced/root.desktop /opt/root.desktop
			sudo rm -f /opt/essentials/RepoMaker.sh
			sudo rm -f /opt/essentials/MySqlDBScripts.7z
			sudo rm -f /usr/bin/bigdata-repomaker
			sudo cp UnSynced/RepoMaker.sh /opt/essentials
			sudo chmod 777 /opt/essentials/RepoMaker.sh
			sudo cp UnSynced/MySqlDBScripts.7z /opt/essentials
			sudo chmod 777 /opt/essentials/MySqlDBScripts.7z
			sudo ln -s /opt/essentials/RepoMaker.sh /usr/bin/bigdata-repomaker
			sudo rm -Rf /opt/essentials/switchenv/wheezy
			sudo rm -Rf /opt/essentials/switchenv/switchenv.sh
			sudo cp -Rf UnSynced/switchenv.sh /opt/essentials/switchenv/switchenv.sh
			sudo chmod 777 /opt/essentials/switchenv/switchenv.sh
			sudo cp -Rf UnSynced/wheezy /opt/essentials/switchenv
			
			pushd /home
			for DIR in * ; do
			    	if [ "$DIR" == "linuxbrew" ] || [ "$DIR" == "linuxbrew" ] ; then
				:
				else
					if [ -d "$DIR/.config" ]; then
						sudo -H -u root bash -c "sed -i 's#<value type=\"string\" value=\"152636952469.desktop\"/>#<value type=\"string\" value=\"152636952469.desktop\"/><value type=\"string\" value=\"etr.desktop\"/>#g' /home/$DIR/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml"
						sudo -H -u root bash -c "cp -Rf /opt/etr.desktop /home/$DIR/.config/xfce4/panel/launcher-26"
						sudo -H -u root bash -c "chown $DIR:$DIR /home/$DIR/.config/xfce4/panel/launcher-26/etr.desktop"
						sudo -H -u root bash -c "chmod 777 /home/$DIR/.config/xfce4/panel/launcher-26/etr.desktop"

						sudo -H -u root bash -c "sed -i 's#<value type=\"string\" value=\"15264805212.desktop\"/>#<value type=\"string\" value=\"repomaker.desktop\"/><value type=\"string\" value=\"15264805212.desktop\"/>#g' /home/$DIR/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml"
						sudo -H -u root bash -c "cp -Rf /opt/repomaker.desktop /home/$DIR/.config/xfce4/panel/launcher-16"
						sudo -H -u root bash -c "chown $DIR:$DIR /home/$DIR/.config/xfce4/panel/launcher-16/repomaker.desktop"
						sudo -H -u root bash -c "chmod 777 /home/$DIR/.config/xfce4/panel/launcher-16/repomaker.desktop"

						sudo -H -u root bash -c "sed -i 's#<value type=\"string\" value=\"152637035778.desktop\"/>#<value type=\"string\" value=\"152637035778.desktop\"/><value type=\"string\" value=\"root.desktop\"/>#g' /home/$DIR/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml"
						sudo -H -u root bash -c "cp -Rf /opt/root.desktop /home/$DIR/.config/xfce4/panel/launcher-10"
						sudo -H -u root bash -c "chown $DIR:$DIR /home/$DIR/.config/xfce4/panel/launcher-10/root.desktop"
						sudo -H -u root bash -c "chmod 777 /home/$DIR/.config/xfce4/panel/launcher-10/root.desktop"
					fi						
				fi
			done
			popd

			sudo cp -Rf /opt/etr.desktop /opt/newuserbase/.config/xfce4/panel/launcher-26
			sudo cp -Rf /opt/repomaker.desktop /opt/newuserbase/.config/xfce4/panel/launcher-16
			sudo cp -Rf /opt/root.desktop /opt/newuserbase/.config/xfce4/panel/launcher-10
			sudo sed -i 's#<value type="string" value="152636952469.desktop"/>#<value type="string" value="152636952469.desktop"/><value type="string" value="etr.desktop"/>#g' /opt/newuserbase/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
			sudo sed -i 's#<value type="string" value="15264805212.desktop"/>#<value type="string" value="repomaker.desktop"/><value type="string" value="15264805212.desktop"/>#g' /opt/newuserbase/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
			sudo sed -i 's#<value type="string" value="152637035778.desktop"/>#<value type="string" value="152637035778.desktop"/><value type="string" value="root.desktop"/>#g' /opt/newuserbase/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
			sudo rm -f /opt/etr.desktop
			sudo rm -f /opt/repomaker.desktop
			sudo rm -f /opt/root.desktop
		fi

		sudo rm -Rf /opt/essentials/calibre
		sudo mkdir -p /opt/essentials/calibre/calibre
		sudo chmod 777 -R /opt/essentials/calibre
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/calibre-3.27.1-x86_64.txz /opt/essentials/calibre/calibre
		pushd /opt/essentials/calibre/calibre
		tar xf calibre-3.27.1-x86_64.txz
		rm -f calibre-3.27.1-x86_64.txz
		popd
		echo '#!/bin/bash

/opt/essentials/calibre/calibre/calibre' | sudo tee /opt/essentials/calibre/calibre.sh
		sudo chmod 777 -R /opt/essentials/calibre
		sed -i '50s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '50s~.*~<tr><td>Calibre</td><td>3.27.1</td><td><a href="https://calibre-ebook.com/download_linux" target=_blank>https://calibre-ebook.com/download_linux</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo rm -f /opt/essentials/appimages/draw.io*
		sudo rm -f /opt/essentials/appimages/gimp-*
		sudo rm -f /opt/essentials/appimages/krita-*
		sudo rm -f /opt/essentials/appimages/opendesktop-app*
		sudo rm -f /opt/essentials/appimages/OpenShot-*

		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/draw.io-x86_64-8.8.0.AppImage /opt/essentials/appimages
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/gimp-git-2.10.3-20180628.glibc2.15-x86_64.AppImage /opt/essentials/appimages
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/krita-4.1.0-x86_64.appimage /opt/essentials/appimages
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/opendesktop-app-3.2.0-2-x86_64.AppImage /opt/essentials/appimages
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/OpenShot-v2.4.2-x86_64.AppImage /opt/essentials/appimages
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/pb-7.6.0-x86_64.AppImage /opt/essentials/appimages

		sudo chmod 777 /opt/essentials/appimages/draw.io-x86_64-8.8.0.AppImage
		sudo chmod 777 /opt/essentials/appimages/gimp-git-2.10.3-20180628.glibc2.15-x86_64.AppImage
		sudo chmod 777 /opt/essentials/appimages/krita-4.1.0-x86_64.appimage
		sudo chmod 777 /opt/essentials/appimages/opendesktop-app-3.2.0-2-x86_64.AppImage
		sudo chmod 777 /opt/essentials/appimages/OpenShot-v2.4.2-x86_64.AppImage
		sudo chmod 777 /opt/essentials/appimages/pb-7.6.0-x86_64.AppImage

		echo '#!/bin/bash
/opt/essentials/appimages/draw.io-x86_64-8.8.0.AppImage' | sudo tee /opt/essentials/appimages/drawio.sh
		echo '#!/bin/bash
/opt/essentials/appimages/gimp-git-2.10.3-20180628.glibc2.15-x86_64.AppImage' | sudo tee /opt/essentials/appimages/gimp.sh
		echo '#!/bin/bash
/opt/essentials/appimages/krita-4.1.0-x86_64.appimage' | sudo tee /opt/essentials/appimages/krita.sh
		echo '#!/bin/bash
/opt/essentials/appimages/opendesktop-app-3.2.0-2-x86_64.AppImage' | sudo tee /opt/essentials/appimages/opendesktop.sh
		echo '#!/bin/bash
/opt/essentials/appimages/OpenShot-v2.4.2-x86_64.AppImage' | sudo tee /opt/essentials/appimages/openshot.sh
		echo '#!/bin/bash
/opt/essentials/appimages/pb-7.6.0-x86_64.AppImage' | sudo tee /opt/essentials/appimages/pb.sh
		
		sudo chmod 777 /opt/essentials/appimages/drawio.sh
		sudo chmod 777 /opt/essentials/appimages/gimp.sh
		sudo chmod 777 /opt/essentials/appimages/krita.sh
		sudo chmod 777 /opt/essentials/appimages/opendesktop.sh
		sudo chmod 777 /opt/essentials/appimages/openshot.sh
		sudo chmod 777 /opt/essentials/appimages/pb.sh

		sed -i '73s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '73s~.*~<tr><td>Draw.io</td><td>8.8.0</td><td><a href="https://github.com/jgraph/drawio-desktop/releases" target=_blank>https://github.com/jgraph/drawio-desktop/releases</a></td></tr>~' /opt/essentials/unsyncedupdates.html
		sed -i '76s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '76s~.*~<tr><td>GIMP</td><td>2.10.3</td><td><a href="https://github.com/aferrero2707/gimp-appimage/releases" target=_blank>https://github.com/aferrero2707/gimp-appimage/releases</a></td></tr>~' /opt/essentials/unsyncedupdates.html
		sed -i '77s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '77s~.*~<tr><td>Krita</td><td>4.1.0</td><td><a href="https://krita.org/en/download/krita-desktop/" target=_blank>https://krita.org/en/download/krita-desktop/</a></td></tr>~' /opt/essentials/unsyncedupdates.html
		sed -i '79s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '79s~.*~<tr><td>OpenDesktop</td><td>3.2.0-2</td><td><a href="https://www.opendesktop.org/p/1175480/" target=_blank>https://www.opendesktop.org/p/1175480/</a></td></tr>~' /opt/essentials/unsyncedupdates.html
		sed -i '80s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '80s~.*~<tr><td>OpenShot</td><td>2.4.2</td><td><a href="https://www.openshot.org/download/" target=_blank>https://www.openshot.org/download/</a></td></tr><tr><td>Pushbullet</td><td>7.6</td><td><a href="https://github.com/sidneys/pb-for-desktop/releases" target=_blank>https://github.com/sidneys/pb-for-desktop/releases</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo cp -Rf UnSynced/pb.png /opt/icons/pb.png
		sudo cp -Rf UnSynced/pb.desktop /opt/pb.desktop
		pushd /home
		for DIR in * ; do
		    	if [ "$DIR" == "linuxbrew" ] || [ "$DIR" == "linuxbrew" ] ; then
			:
			else
				if [ -d "$DIR/.config" ]; then
					sudo -H -u root bash -c "sed -i 's#<value type=\"string\" value=\"152631895014.desktop\"/>#<value type=\"string\" value=\"152631895014.desktop\"/><value type=\"string\" value=\"pb.desktop\"/>#g' /home/$DIR/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml"
					sudo -H -u root bash -c "cp -Rf /opt/pb.desktop /home/$DIR/.config/xfce4/panel/launcher-13"
					sudo -H -u root bash -c "chown $DIR:$DIR /home/$DIR/.config/xfce4/panel/launcher-13/pb.desktop"
					sudo -H -u root bash -c "chmod 777 /home/$DIR/.config/xfce4/panel/launcher-13/pb.desktop"
				fi						
			fi
		done
		popd
		sudo cp -Rf /opt/pb.desktop /opt/newuserbase/.config/xfce4/panel/launcher-13
		sudo sed -i 's#<value type="string" value="152631895014.desktop"/>#<value type="string" value="152631895014.desktop"/><value type="string" value="pb.desktop"/>#g' /opt/newuserbase/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
		sudo rm -f /opt/pb.desktop

		sudo rm -Rf /opt/essentials/filezilla
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/filezilla /opt/essentials/filezilla
		sudo chmod 777 -R /opt/essentials/filezilla
		sed -i '53s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '53s~.*~<tr><td>FileZilla</td><td>3.34.0</td><td><a href="https://filezilla-project.org/download.php?type=client" target=_blank>https://filezilla-project.org/download.php?type=client</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo mkdir -p /opt/essentials/google
		sudo rm -Rf /opt/essentials/google/chrome
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/chrome /opt/essentials/google/chrome
		sudo chmod 777 -R /opt/essentials/google/chrome
		sed -i '57s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '57s~.*~<tr><td>Google Chrome</td><td>67.0.3396.99</td><td><a href="https://www.google.co.in/chrome/" target=_blank>https://www.google.co.in/chrome/</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo mkdir -p /opt/essentials/google
		sudo rm -Rf /opt/essentials/google/music
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/music /opt/essentials/google/music
		sudo chmod 777 -R /opt/essentials/google/music
		sed -i '59s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '59s~.*~<tr><td>Google Play Music</td><td>4.6.0</td><td><a href="https://www.googleplaymusicdesktopplayer.com/" target=_blank>https://www.googleplaymusicdesktopplayer.com/</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo rm -Rf /opt/essentials/opera
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/opera /opt/essentials/opera
		sudo chmod 777 -R /opt/essentials/opera
		sed -i '60s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '60s~.*~<tr><td>Opera</td><td>54.0.2952.51</td><td><a href="https://www.opera.com/download" target=_blank>https://www.opera.com/download</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo rm -Rf /opt/essentials/tor
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/tor /opt/essentials/tor
		sudo chmod 777 -R /opt/essentials/tor
		sed -i '65s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '65s~.*~<tr><td>Tor Browser</td><td>7.5.6</td><td><a href="https://www.torproject.org/download/download-easy.html.en" target=_blank>https://www.torproject.org/download/download-easy.html.en</a></td></tr>~' /opt/essentials/unsyncedupdates.html
		sudo cp -Rf /opt/UnSyncedUpdate/UnSynced/152630875618.desktop /opt/152630875618.desktop
		pushd /home
		for DIR in * ; do
		    	if [ "$DIR" == "linuxbrew" ] || [ "$DIR" == "linuxbrew" ] ; then
			:
			else
				if [ -d "$DIR/.config" ]; then
					sudo -H -u root bash -c "cp -Rf /opt/152630875618.desktop /home/$DIR/.config/xfce4/panel/launcher-11"
					sudo -H -u root bash -c "chown $DIR:$DIR /home/$DIR/.config/xfce4/panel/launcher-11/152630875618.desktop"
					sudo -H -u root bash -c "chmod 777 /home/$DIR/.config/xfce4/panel/launcher-11/152630875618.desktop"
				fi						
			fi
		done
		popd
		sudo cp -Rf /opt/152630875618.desktop /opt/newuserbase/.config/xfce4/panel/launcher-11
		sudo rm -f /opt/152630875618.desktop

		sudo rm -Rf /opt/essentials/viber
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/viber /opt/essentials/viber
		sudo chmod 777 -R /opt/essentials/viber
		sed -i '67s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '67s~.*~<tr><td>Viber</td><td>2017</td><td><a href="https://www.viber.com/download/" target=_blank>https://www.viber.com/download/</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo rm -Rf /opt/essentials/zoom
		sudo mkdir /opt/essentials/zoom
		sudo chmod 777 -R /opt/essentials/zoom
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/zoom_amd64.deb /opt/essentials/zoom
		sudo rm -Rf /opt/essentials/zoom/opt
		sudo rm -Rf /opt/essentials/zoom/usr
		pushd /opt/essentials/zoom
		for i in /opt/essentials/zoom/*deb; do sudo dpkg-deb -x $i . ; done
		popd
		echo '#!/bin/bash
/opt/essentials/zoom/opt/zoom/ZoomLauncher' | sudo tee /opt/essentials/zoom/zoom.sh
		sudo chmod 777 -R /opt/essentials/zoom
		sudo rm -f /opt/essentials/zoom/zoom_amd64.deb
		sed -i '71s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '71s~.*~<tr><td>Zoom</td><td>2.2.128200.0702</td><td><a href="https://zoom.us/download#client_4meeting" target=_blank>https://zoom.us/download#client_4meeting</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo rm -Rf /opt/essentials/telegram
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/telegram /opt/essentials/telegram
		sudo chmod 777 -R /opt/essentials/telegram
		sed -i '64s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '64s~.*~<tr><td>Telegram</td><td>1.3.9</td><td><a href="https://desktop.telegram.org/" target=_blank>https://desktop.telegram.org/</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo gdebi -n /opt/UnSyncedUpdate/UnSynced/updates/timeshift-v18.6.1-amd64.deb
		sudo rm -f /opt/UnSyncedUpdate/UnSynced/updates/timeshift-v18.6.1-amd64.deb
		sed -i '88s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '88s~.*~<tr><td>Timeshift</td><td>18.6.1</td><td><a href="https://github.com/teejee2008/Timeshift/releases" target=_blank>https://github.com/teejee2008/Timeshift/releases</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo rm -Rf /opt/master-pdf-editor-4
		sudo rm -Rf /opt/master-pdf-editor-5
		sudo gdebi -n /opt/UnSyncedUpdate/UnSynced/updates/master-pdf-editor-5.0.32_qt5.amd64.deb
		sudo rm -f /opt/UnSyncedUpdate/UnSynced/updates/master-pdf-editor-5.0.32_qt5.amd64.deb
		sudo ln -s /opt/master-pdf-editor-5 /opt/master-pdf-editor-4
		sudo chmod 777 -R /opt/master-pdf-editor-5
		sudo chmod 777 -R /opt/master-pdf-editor-4
		sudo ln -s /opt/master-pdf-editor-5/masterpdfeditor5 /opt/master-pdf-editor-4/masterpdfeditor4
		sudo ln -s /opt/master-pdf-editor-5/masterpdfeditor5.png /opt/master-pdf-editor-4/masterpdfeditor4.png
		sed -i '55s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '55s~.*~<tr><td>Master Pdf Editor</td><td>5.0.32</td><td><a href="https://code-industry.net/free-pdf-editor/#get" target=_blank>https://code-industry.net/free-pdf-editor/#get</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo rm -Rf /opt/essentials/syncthing
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/syncthing /opt/essentials
		sed -i '63s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '63s~.*~<tr><td>Syncthing</td><td>Core - v0.14.49-rc.3 / GUI - 0.9.4</td><td><a href="https://syncthing.net/" target=_blank>https://syncthing.net/</a></td></tr>~' /opt/essentials/unsyncedupdates.html
		sudo rm -f /usr/bin/syncthing
		sudo ln -s /opt/essentials/syncthing/core/syncthing /usr/bin/syncthing
		sudo chmod 777 -R /opt/essentials/syncthing

		sudo gdebi -n /opt/UnSyncedUpdate/UnSynced/updates/mailspring-1.2.2-amd64.deb
		sudo rm -f /opt/UnSyncedUpdate/UnSynced/updates/mailspring-1.2.2-amd64.deb
		sed -i '63s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '63s~.*~<tr><td>Syncthing</td><td>Core - v0.14.49-rc.3 / GUI - 0.9.4</td><td><a href="https://syncthing.net/" target=_blank>https://syncthing.net/</a></td></tr><tr><td>Mailspring</td><td>1.2.2</td><td><a href="https://getmailspring.com/download" target=_blank>https://getmailspring.com/download</a></td></tr>~' /opt/essentials/unsyncedupdates.html
		sudo cp -Rf /opt/UnSyncedUpdate/UnSynced/ms.desktop /opt/ms.desktop
		pushd /home
		for DIR in * ; do
		    	if [ "$DIR" == "linuxbrew" ] || [ "$DIR" == "linuxbrew" ] ; then
			:
			else
				if [ -d "$DIR/.config" ]; then
					sudo -H -u root bash -c "sed -i 's#<value type=\"string\" value=\"1526406119153.desktop\"/>#<value type=\"string\" value=\"1526406119153.desktop\"/><value type=\"string\" value=\"ms.desktop\"/>#g' /home/$DIR/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml"
					sudo -H -u root bash -c "cp -Rf /opt/ms.desktop /home/$DIR/.config/xfce4/panel/launcher-11"
					sudo -H -u root bash -c "chown $DIR:$DIR /home/$DIR/.config/xfce4/panel/launcher-11/ms.desktop"
					sudo -H -u root bash -c "chmod 777 /home/$DIR/.config/xfce4/panel/launcher-11/ms.desktop"
				fi						
			fi
		done
		popd
		sudo cp -Rf /opt/ms.desktop /opt/newuserbase/.config/xfce4/panel/launcher-11
		sudo sed -i 's#<value type="string" value="1526406119153.desktop"/>#<value type="string" value="1526406119153.desktop"/><value type="string" value="ms.desktop"/>#g' /opt/newuserbase/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
		sudo rm -f /opt/ms.desktop

		sudo rm -Rf /opt/essentials/vr180creator
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/vr180creator /opt/essentials/vr180creator
		sudo chmod 777 -R /opt/essentials/vr180creator
		sed -i '63s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '63s~.*~<tr><td>Syncthing</td><td>Core - v0.14.49-rc.3 / GUI - 0.9.4</td><td><a href="https://syncthing.net/" target=_blank>https://syncthing.net/</a></td></tr><tr><td>Mailspring</td><td>1.2.2</td><td><a href="https://getmailspring.com/download" target=_blank>https://getmailspring.com/download</a></td></tr><tr><td>VR180 Creator</td><td>1.0</td><td><a href="https://vr.google.com/vr180/apps/" target=_blank>https://vr.google.com/vr180/apps/</a></td></tr>~' /opt/essentials/unsyncedupdates.html
		sudo cp -Rf /opt/UnSyncedUpdate/UnSynced/15309683182.desktop /opt/15309683182.desktop
		pushd /home
		for DIR in * ; do
		    	if [ "$DIR" == "linuxbrew" ] || [ "$DIR" == "linuxbrew" ] ; then
			:
			else
				if [ -d "$DIR/.config" ]; then
					sudo -H -u root bash -c "sed -i 's#<value type=\"string\" value=\"152638175885.desktop\"/>#<value type=\"string\" value=\"152638175885.desktop\"/><value type=\"string\" value=\"15309683182.desktop\"/>#g' /home/$DIR/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml"
					sudo -H -u root bash -c "cp -Rf /opt/15309683182.desktop /home/$DIR/.config/xfce4/panel/launcher-27"
					sudo -H -u root bash -c "chown $DIR:$DIR /home/$DIR/.config/xfce4/panel/launcher-27/15309683182.desktop"
					sudo -H -u root bash -c "chmod 777 /home/$DIR/.config/xfce4/panel/launcher-27/15309683182.desktop"
				fi						
			fi
		done
		popd
		sudo cp -Rf /opt/15309683182.desktop /opt/newuserbase/.config/xfce4/panel/launcher-27
		sudo sed -i 's#<value type="string" value="152638175885.desktop"/>#<value type="string" value="152638175885.desktop"/><value type="string" value="15309683182.desktop"/>#g' /opt/newuserbase/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
		sudo rm -f /opt/15309683182.desktop

		sudo rm -Rf /opt/essentials/bitcoin
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/bitcoin /opt/essentials/bitcoin
		sudo chmod 777 -R /opt/essentials/bitcoin
		sed -i '63s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '63s~.*~<tr><td>Syncthing</td><td>Core - v0.14.49-rc.3 / GUI - 0.9.4</td><td><a href="https://syncthing.net/" target=_blank>https://syncthing.net/</a></td></tr><tr><td>Mailspring</td><td>1.2.2</td><td><a href="https://getmailspring.com/download" target=_blank>https://getmailspring.com/download</a></td></tr><tr><td>VR180 Creator</td><td>1.0</td><td><a href="https://vr.google.com/vr180/apps/" target=_blank>https://vr.google.com/vr180/apps/</a></td></tr><tr><td>BitPay / Copay Wallet</td><td>4.4</td><td><a href="https://github.com/bitpay/copay/releases" target=_blank>https://github.com/bitpay/copay/releases</a></td></tr>~' /opt/essentials/unsyncedupdates.html
		sudo cp -Rf /opt/UnSyncedUpdate/UnSynced/15309701483.desktop /opt/15309701483.desktop
		sudo cp -Rf /opt/UnSyncedUpdate/UnSynced/15309702124.desktop /opt/15309702124.desktop
		pushd /home
		for DIR in * ; do
		    	if [ "$DIR" == "linuxbrew" ] || [ "$DIR" == "linuxbrew" ] ; then
			:
			else
				if [ -d "$DIR/.config" ]; then
					sudo -H -u root bash -c "sed -i 's#<value type=\"string\" value=\"1526404164151.desktop\"/>#<value type=\"string\" value=\"1526404164151.desktop\"/><value type=\"string\" value=\"15309701483.desktop\"/><value type=\"string\" value=\"15309702124.desktop\"/>#g' /home/$DIR/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml"
					sudo -H -u root bash -c "cp -Rf /opt/15309701483.desktop /home/$DIR/.config/xfce4/panel/launcher-36"
					sudo -H -u root bash -c "chown $DIR:$DIR /home/$DIR/.config/xfce4/panel/launcher-36/15309701483.desktop"
					sudo -H -u root bash -c "chmod 777 /home/$DIR/.config/xfce4/panel/launcher-36/15309701483.desktop"
					sudo -H -u root bash -c "cp -Rf /opt/15309702124.desktop /home/$DIR/.config/xfce4/panel/launcher-36"
					sudo -H -u root bash -c "chown $DIR:$DIR /home/$DIR/.config/xfce4/panel/launcher-36/15309702124.desktop"
					sudo -H -u root bash -c "chmod 777 /home/$DIR/.config/xfce4/panel/launcher-36/15309702124.desktop"
				fi						
			fi
		done
		popd
		sudo cp -Rf /opt/15309701483.desktop /opt/newuserbase/.config/xfce4/panel/launcher-36
		sudo cp -Rf /opt/15309702124.desktop /opt/newuserbase/.config/xfce4/panel/launcher-36
		sudo sed -i 's#<value type="string" value="1526404164151.desktop"/>#<value type="string" value="1526404164151.desktop"/><value type="string" value="15309701483.desktop"/><value type="string" value="15309702124.desktop"/>#g' /opt/newuserbase/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
		sudo rm -f /opt/15309701483.desktop
		sudo rm -f /opt/15309702124.desktop
		
		sudo rm -f /opt/essentials/VMware-Workstation-Full-14.1.1-7528167.x86_64.bundle
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/VMware-Workstation-Full-14.1.1-7528167.x86_64.bundle /opt/essentials/VMware-Workstation-Full-14.1.1-7528167.x86_64.bundle
		sudo vmware-installer -u vmware-workstation --console --required --eulas-agreed
		sudo /opt/essentials/VMware-Workstation-Full-14.1.1-7528167.x86_64.bundle --console --required --eulas-agreed
		sed -i '89s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '89s~.*~<tr><td>VMware</td><td>14.1.2-8497320.x86_64</td><td><a href="https://www.vmware.com/in/products/workstation-pro.html" target=_blank>https://www.vmware.com/in/products/workstation-pro.html</a></td></tr> ~' /opt/essentials/unsyncedupdates.html

		sudo rm -Rf /opt/essentials/freefilesync
		sudo mv /opt/UnSyncedUpdate/UnSynced/updates/freefilesync /opt/essentials
		sudo chmod 777 -R /opt/essentials/freefilesync
		sed -i '56s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '56s~.*~<tr><td>FreeFileSync</td><td>10.2</td><td><a href="https://freefilesync.org/download.php" target=_blank>https://freefilesync.org/download.php</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sed -i '31s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '31s~.*~<tr><td>.Net Core</td><td>2.1.301</td><td><a href="https://www.microsoft.com/net/download/linux" target=_blank>https://www.microsoft.com/net/download/linux</a></td></tr>~' /opt/essentials/unsyncedupdates.html
		sed -i '44s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '44s~.*~<tr><td>VS Code</td><td>1.25.0</td><td><a href="https://code.visualstudio.com/Download" target=_blank>https://code.visualstudio.com/Download</a></td></tr>~' /opt/essentials/unsyncedupdates.html
		sed -i '36s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '37s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '35s~.*~~' /opt/essentials/unsyncedupdates.html
		sed -i '36s~.*~<tr><td>JavaScript & Web Dev</td><td>4.8.0</td><td><a href="https://www.eclipse.org/downloads/eclipse-packages/" target=_blank>https://www.eclipse.org/downloads/eclipse-packages/</a></td></tr>~' /opt/essentials/unsyncedupdates.html
		sed -i '37s~.*~<tr><td>PHP IDE</td><td>4.8.0</td><td><a href="https://www.eclipse.org/downloads/eclipse-packages/" target=_blank>https://www.eclipse.org/downloads/eclipse-packages/</a></td></tr>~' /opt/essentials/unsyncedupdates.html
		sed -i '35s~.*~<tr><td>Eclipse</td><td>4.8.0</td><td><a href="https://www.eclipse.org/downloads/eclipse-packages/" target=_blank>https://www.eclipse.org/downloads/eclipse-packages/</a></td></tr><tr><td>IntelliJ IDEA</td><td>2018.1.5</td><td><a href="https://www.jetbrains.com/idea/download/#section=linux" target=_blank>https://www.jetbrains.com/idea/download/#section=linux</a></td></tr>~' /opt/essentials/unsyncedupdates.html

		sudo cp -Rf UnSynced/idea.png /opt/icons/idea.png
		sudo cp -Rf /opt/UnSyncedUpdate/UnSynced/15309867035.desktop /opt/15309867035.desktop
		pushd /home
		for DIR in * ; do
		    	if [ "$DIR" == "linuxbrew" ] || [ "$DIR" == "linuxbrew" ] ; then
			:
			else
				if [ -d "$DIR/.config" ]; then
					sudo -H -u root bash -c "sed -i 's#<value type=\"string\" value=\"15264759458.desktop\"/>#<value type=\"string\" value=\"15264759458.desktop\"/><value type=\"string\" value=\"15309867035.desktop\"/>#g' /home/$DIR/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml"
					sudo -H -u root bash -c "cp -Rf /opt/15309867035.desktop /home/$DIR/.config/xfce4/panel/launcher-22"
					sudo -H -u root bash -c "chown $DIR:$DIR /home/$DIR/.config/xfce4/panel/launcher-22/15309867035.desktop"
					sudo -H -u root bash -c "chmod 777 /home/$DIR/.config/xfce4/panel/launcher-22/15309867035.desktop"
				fi						
			fi
		done
		popd
		sudo cp -Rf /opt/15309867035.desktop /opt/newuserbase/.config/xfce4/panel/launcher-22
		sudo sed -i 's#<value type="string" value="15264759458.desktop"/>#<value type="string" value="15264759458.desktop"/><value type="string" value="15309867035.desktop"/>#g' /opt/newuserbase/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
		sudo rm -f /opt/15309867035.desktop

		if [ -d "/opt/dev" ]; then
			axel https://sourceforge.net/projects/getprathamos/files/Adyah/1.2/DEVUpdates.sh
			sudo chmod 777 DEVUpdates.sh
			./DEVUpdates.sh
		fi

		sudo rm -Rf /opt/UnSyncedUpdate
		sudo rm -f /opt/POSUPDATE
		sudo -H -u root bash -c 'echo "1.2" | tee /etc/apt/ver'

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
