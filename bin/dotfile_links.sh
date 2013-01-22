#!/bin/bash

IGNORE_PATTERN=".git*"

for file in `ls --ignore=$IGNORE_PATTERN -A ~/dotfiles`
do 
	if [ ! -L ~/$file -a -e ~/$file ]
	then
		echo "backed up ~/$file"
		mv ~/$file ~/$file.bak
	fi

	if [ ! -e ~/$file ]
	then
		ln -s -t ~/ ~/dotfiles/$file
	fi

	
done
