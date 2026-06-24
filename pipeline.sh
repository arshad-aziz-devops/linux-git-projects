#!/bin/bash

APP_REPO="git@github.com:arshad-aziz-devops/linux-git-projects.git"
APP_DIR="myapp"
STG_DIR="stagging"
LOG="deploy.log"

> "$LOG" #empty the log file

echo "Cloing Repo"
if [ -d "$APP_DIR" ];then
	cd "$APP_DIR" && git pull origin main >> "../$LOG" 2>&1 && cd ..
else
	git clone "$APP_REPO" "$APP_DIR" >> $LOG 2>&1
fi

echo "Building"
cp -r "$APP_DIR" "build_tmp"
rm -rf "build_tmp"/.git
echo "Done"

echo "Deploy"
if [ -d "$STG_DIR" ];then
	cp -r "$STG_DIR" backup_$(date +%y%m%d_%H%M%S)
fi
rm -rf "$STG_DIR"
mv build_tmp "$STG_DIR"
echo "Done"

