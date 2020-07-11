#!/usr/bin/env bash

FRIENDLYNAME=Clonezilla
CONTAINERNAME=clonezilla
DOCKERREPO=theniwo
DOCKERIMAGE=clonezilla
DOCKERTAG=latest

cd /root/Settings/Linux/scripts/docker/$CONTAINERNAME
function main(){
	logger -i -t $CONTAINERNAME "Adding files"
	git add .
	  if [ $? -eq 0 ] ; then
	    logger -i -t $CONTAINERNAME "Adding files successful"
	  else
	    logger -i -t $CONTAINERNAME "Adding files unsuccessful"
	  fi


	logger -i -t $CONTAINERNAME "Committing to git"
	git commit --all -m "Auto commit"
	  if [ $? -eq 0 ] ; then
	    logger -i -t $CONTAINERNAME "Committing to git successful"
	  else
	    logger -i -t $CONTAINERNAME "Committing to git failed"
	  fi

	logger -i -t $CONTAINERNAME "Pushing to git"
	git push origin master
	  if [ $? -eq 0 ] ; then
	    logger -i -t $CONTAINERNAME "Pushing to git successful"
	  else
	    logger -i -t $CONTAINERNAME "Pushing to git unsuccessful"
	  fi
}
main
