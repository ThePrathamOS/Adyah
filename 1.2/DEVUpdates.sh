#!/bin/bash

if [ -d "/opt/dev" ]; then
	sudo mkdir -p /opt/UnSyncedUpdate
	cd /opt/UnSyncedUpdate

	axel https://sourceforge.net/projects/getprathamos/files/Adyah/1.2/DEV.7z
	FILE="/opt/UnSyncedUpdate/DEV.7z"

	if [ -f "$FILE" ]
	then
		md5sum=$(md5sum $FILE | awk '{print $1}')
		if [ "$md5sum" = "82f5e4e42a4d31c0548dde4987804da9" ]; then
			sudo 7z x DEV.7z -o.
			sudo rm -f DEV.7z

			sudo rm -Rf /opt/dev/IntelliJIDEA
			sudo rm -Rf /opt/dev/Java
			sudo rm -Rf /opt/dev/PHP
			sudo rm -Rf /opt/dev/VSCode
			sudo rm -Rf /opt/dev/WebDev

			sudo mv /opt/UnSyncedUpdate/DEV/IntelliJIDEA /opt/dev/IntelliJIDEA
			sudo mv /opt/UnSyncedUpdate/DEV/Java /opt/dev/Java
			sudo mv /opt/UnSyncedUpdate/DEV/PHP /opt/dev/PHP
			sudo mv /opt/UnSyncedUpdate/DEV/VSCode /opt/dev/VSCode
			sudo mv /opt/UnSyncedUpdate/DEV/WebDev /opt/dev/WebDev

			sudo chown root:root -R /opt/dev 
			sudo chmod 777 -R /opt/dev

			pushd /home
			for DIR in * ; do
			    	if [ "$DIR" == "linuxbrew" ] || [ "$DIR" == "linuxbrew" ] ; then
				:
				else
					sudo -H -u root bash -c "rm -Rf /home/$DIR/.IdeaIC2018.1"
					sudo -H -u root bash -c "cp -Rf /opt/UnSyncedUpdate/DEV/.IdeaIC2018.1 /home/$DIR/"
					sudo -H -u root bash -c "chown -R $DIR:$DIR /home/$DIR/.IdeaIC2018.1"
					sudo -H -u root bash -c "chmod 777 -R /home/$DIR/.IdeaIC2018.1"	
					sudo -H -u root bash -c "sed -i 's#qwer#$DIR#g' /home/$DIR/.IdeaIC2018.1/config/options/path.macros.xml"					
				fi
			done
			popd

			sudo rm -Rf /opt/newuserbase/.IdeaIC2018.1
			sudo cp -Rf /opt/UnSyncedUpdate/DEV/.IdeaIC2018.1 /opt/newuserbase/.IdeaIC2018.1
			sudo sed -i 's#qwer#primaryuser#g' /opt/newuserbase/.IdeaIC2018.1/config/options/path.macros.xml
		fi
	fi

	sudo rm -Rf /opt/UnSyncedUpdate
fi

