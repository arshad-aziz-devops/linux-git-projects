#!/bin/bash

#CPU usage
filename=rc.log
time_stmp=$(date +%m-%d-%y-%H:%M)

top -b -n1 | grep "Cpu(s)" | awk -F ',' '{print $4}' | awk '{ print "Cpu load is: " 100 - $1}' >> $filename.$time_stmp

$Memory

free -h | grep "Mem" | awk '{print "Free memory space:" $2}' >> $filename.$time_stmp

#Disk Space

df -h / | tail -1| awk '{print "Available Space: " $3}' >> $filename.$time_stmp
#All services running 
systemctl list-units --type=service --state=running >> $filename.$time_stmp

#Push logs to GitHub

git add rc.log*
git commit -m "Pushing logs to Github repo"

git remote add origin git@github.com:arshad-aziz-devops/linux-git-projects.git
git push origin main
