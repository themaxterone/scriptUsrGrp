# Script Usr Grp

This is a simple script which find all the users that are register on the system and match them with their **Ids**, **groups**, type of **Bash**, location of **Home** and the **Shell** which he uses.

You can copy the script here down or also can be cloned or downloaded.

Example of result:

```txt
---------------------------------------------------------------------------
| Usr: maxter || Id: 1000 || Home: /home/maxter || Shell: /usr/bin/zsh |
---------------------------------------------------------------------------
                                Grupos:
Grupo: wheel || ID: 998
Grupo: maxter || ID: 1000
Grupo: vboxusers || ID: 108
```


Script:

```bash
#!/bin/bash

cat /etc/passwd > fichusr.tmp
input="fichusr.tmp"

while IFS= read -r line
do
	usrId=$(echo $line | cut -d : -f 3)

		if [[ $usrId -ge 1000 ]] || [[ $usrId -eq 0 ]]
			then
				if [[ $usrId -ne 65534 ]]
					then
						usrName=$(echo $line | cut -d : -f 1)
						usrHome=$(echo $line | cut -d : -f 6)
						usrShell=$(echo $line | cut -d : -f 7)
						
						cat /etc/group | grep $usrName > tmp.tmp
						
						echo "---------------------------------------------------------------------------"
						echo "| Usr: $usrName || Id: $usrId || Home: $usrHome || Shell: $usrShell |"
						echo "---------------------------------------------------------------------------"
						echo "                                Grupos:                                    "
							
							while IFS= read -r line2
								do
									grpName=$(echo $line2 | cut -d : -f 1)
									grpId=$(echo $line2 | cut -d : -f 3)
									
									echo "Grupo: $grpName || ID: $grpId"
							done < tmp.tmp
							
						echo ""
						echo ""
													
				fi
		fi
	
done < "$input"


rm $input
rm tmp.tmp
```
