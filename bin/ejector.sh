#!/bin/bash

echo "ejector starting..."
echo $(date)
osascript /Users/barnesk/Code/vinbarnes/dotfiles/bin/ejector.scpt
echo $?
echo "ejector finished."
