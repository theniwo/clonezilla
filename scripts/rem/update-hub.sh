#!/usr/bin/env bash
FRIENDLYNAME=Clonezilla
CONTAINERNAME=clonezilla
DOCKERREPO=theniwo
DOCKERIMAGE=clonezilla
DOCKERTAG=latest
cd /root/Settings/Linux/scripts/docker/$CONTAINERNAME

	echo "Committing to docker hub"
	docker commit $(docker inspect --format='{{.ID}}' $CONTAINERNAME) $DOCKERREPO/$DOCKERIMAGE:$DOCKERTAG && docker push $DOCKERREPO/$DOCKERIMAGE:$DOCKERTAG
	if [ $? -eq 0 ] ; then
		echo "$FRIENDLYNAME has commited and automatically pushed to docker hub"
		logger -i -t $CONTAINERNAME "$FRIENDLYNAME has commited and automatically pushed to docker hub"
	else
		echo "$FRIENDLYNAME has failed to commit and automatically push to docker hub"
		logger -i -t $CONTAINERNAME "$FRIENDLYNAME has failed to commit and automatically push to docker hub"
	fi
	#echo "Committing to docker hub"
	#docker commit $(docker inspect --format='{{.ID}}' ) theniwo/gobuntu:latest && docker push theniwo/gobuntu:latest
	#if [ $? -eq 0 ] ; then
		#echo "Gobuntu has commited and automatically pushed to docker hub"
		#logger -i -t gobuntu "Gobuntu has commited and automatically pushed to docker hub"
	#else
		#echo "Gobuntu has failed to commit and automatically push to docker hub"
		#logger -i -t gobuntu "Gobuntu has failed to commit and automatically push to docker hub"
	#fi
#
