#!/bin/bash
#Date of last revision: 11/9/2023
ARG1=$1
ARG2=$2
ARG3=$3

status=0 
#0 = File/Directory doesn't exist
#1 = File Exists   
#2 = Directory exists  
#3 = Destination already exists (overwrite protection)
#4 = Destination already exists (overwrite protection)

#Functions:
function exists(){
	if [ -f $ARG2 ]; then
		echo "File Exists"
		status=1 #File exists  
	elif [ -d $ARG2 ]; then
		echo "Directory Exists"
		status=2 #Directory exists  
	else
		echo "ERROR: FILE/DIRECTORY DOES NOT EXIST!"
		status=0 #File/Directory doesn't exist
	fi	
}
function overwriteProtect(){
	if [ -f $ARG3 ]; then
		status=3 #Destination file already exists (overwrite protection)
	elif [ -d $ARG3 ]; then
		status=4 #Destination directory already exists (overwrite protection)
	fi
}
function copyItem(){
	if [ "$status" -eq 1 ]; then
		cp $ARG2 $ARG3
		echo "Copied file!"
		echo
		echo "UNIX command ran: cp $ARG2 $ARG3"
	elif [ "$status" -eq 2 ]; then
		cp -r $ARG2 $ARG3
		echo "Copied the directory"
		echo
		echo "UNIX command ran: cp -r $ARG2 $ARG3"
	elif [ "$status" -eq 3 ]; then
		echo "Destination already exists, breaking to avoid data loss..."
	elif [ "$status" -eq 4 ]; then
		echo "Destination already exists, breaking to avoid data loss..."
	else
		echo "COULD NOT COPY! FILE/DIRECTORY DOESN'T EXIST"
	fi
}
function rename(){
	if [ "$status" -eq 1 ]; then
		mv $ARG2 $ARG3
		echo "Renamed the file!"
		echo
		echo "UNIX command ran: mv $ARG2 $ARG3"
	elif [ "$status" -eq 2 ]; then
		mv  $ARG2 $ARG3
		echo "Renamed the directory!"
		echo
		echo "UNIX command ran: mv $ARG2 $ARG3"
	elif [ "$status" -eq 3 ]; then
		echo "Destination already exists, breaking to avoid data loss..."
	elif [ "$status" -eq 4 ]; then
		echo "Destination already exists, breaking to avoid data loss..."
	else
		echo "COULD NOT RENAME! FILE/DIRECTORY DOESN'T EXIST"
	fi
}
function moveItem(){
	if [ "$status" -eq 1 ]; then
		mv $ARG2 $ARG3
		echo "Moved the file!"
		echo
		echo "UNIX command ran: mv $ARG2 $ARG3"
	elif [ "$status" -eq 2 ]; then
		mv $ARG2 $ARG3
		echo "Moved the directory!"
		echo
		echo "UNIX command ran: mv $ARG2 $ARG3"
	elif [ "$status" -eq 3 ]; then
		echo "Destination already exists, breaking to avoid data loss..."
	elif [ "$status" -eq 4 ]; then
		echo "Destination already exists, breaking to avoid data loss..."
	else
		echo "COULD NOT MOVE! FILE/DIRECTORY DOESN'T EXIST"
	fi
}
function deleteItem(){
	if [ "$status" -eq 1 ]; then
		rm -f $ARG2
		echo "Deleted the file!"
		echo
		echo "UNIX command ran: rm -f $ARG2 $ARG3"
	elif [ "$status" -eq 2 ]; then
		rm -rf $ARG2
		echo "Deleted the directory!"
		echo
		echo "UNIX command ran: rm -rf $ARG2 $ARG3"
	else
		echo "COULD NOT DELETE! FILE/DIRECTORY DOESN'T EXIST"
	fi
}

case $ARG1 in
	"type")
		cat $ARG2
		echo
		echo "UNIX command ran: cat $ARG2"
		;;
	"copy")
		exists
		overwriteProtect
		copyItem
		;;
	"copy!")
		exists
		copyItem
		;;
	"ren")
		exists
		overwriteProtect
		rename
		;;
	"ren!")
		exists
		rename
		;;
	"move")
		exists
		overwriteProtect
		moveItem
		;;
	"move!")
		exists
		moveItem
		;;
	"del")
		exists
		deleteItem
		;;
	"help")
		echo "THESE ARE THE AVAILABLE COMMANDS:"
		echo "type <ARG1> - Outputs contents of file - Takes file name as only argument"
		echo "copy <ARG1> <ARG2> - Copy a file - Takes filename first and copy location second"
		echo "ren <ARG1> <ARG2> - Renames a file - Takes curent name first and new name second"
		echo "move <ARG1> <ARG2> - moves a file - Takes current location first and new location second"
		echo "copy! <ARG1> <ARG2> - Copy a file without regard for overwrites - Takes filename first and copy location second"
		echo "ren! <ARG1> <ARG2> - Renames a file without regard for overwrites- Takes curent name first and new name second"
		echo "move! <ARG1> <ARG2> - moves a file without regard for overwrites- Takes current location first and new location second"
		echo "del <ARG1> - deletes a file - Takes the filename/location as only argument"
		echo "help - outputs help menu - No arguments"
		;;
	*)
		echo "INVALID INPUT SILLY!"
		echo "THESE ARE THE AVAILABLE COMMANDS:"
		echo "type <ARG1> - Outputs contents of file - Takes file name as only argument"
		echo "copy <ARG1> <ARG2> - Copy a file - Takes filename first and copy location second"
		echo "ren <ARG1> <ARG2> - Renames a file - Takes curent name first and new name second"
		echo "move <ARG1> <ARG2> - moves a file - Takes current location first and new location second"
		echo "copy! <ARG1> <ARG2> - Copy a file without regard for overwrites - Takes filename first and copy location second"
		echo "ren! <ARG1> <ARG2> - Renames a file without regard for overwrites- Takes curent name first and new name second"
		echo "move! <ARG1> <ARG2> - moves a file without regard for overwrites- Takes current location first and new location second"
		echo "del <ARG1> - deletes a file - Takes the filename/location as only argument"
		echo "help - outputs help menu - No arguments"
		;;
esac
exit 0


