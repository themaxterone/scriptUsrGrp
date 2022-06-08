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
