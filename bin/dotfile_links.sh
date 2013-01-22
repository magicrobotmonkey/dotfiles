#!/bin/bash

IGNORE_PATTERN=".git$\|.gitignore\|.gitmodules"

for file in `ls -A ~/dotfiles|grep -v "$IGNORE_PATTERN"`
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
