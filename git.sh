#!/usr/bin/env bash

# Step 1: Update the OS and Install Xcode Tools
echo "-----------------------------------------------------------------"
echo "Starting Git config. Here is what's currently in git global:"
echo "-----------------------------------------------------------------"
echo 
    echo "user.name: $(git config --global user.name)" 
    echo "user.email: $(git config --global user.email)" 

read -p "Want to set username and email? (Y/N): " confirm && if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    read -r -p "Enter user.name: " fullname
    read -p "Enter user.email: " email
    git config --global user.name $fullname
    git config --global user.email $email
    echo "-----------------------------------------------------------------"
    echo "Global git config updated. Here is what's currently in git global:"
    echo "-----------------------------------------------------------------"
    echo 
    git config --global user.name
    git config --global user.email
  else
    echo "Ok rude, bye" && exit 1
  fi