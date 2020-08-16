#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
  while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

source $DIR/env
cd $DIR/..


	echo "Committing to docker hub"
	docker commit $(docker inspect --format='{{.ID}}' $CONTAINERNAME) $DOCKERREPO/$DOCKERIMAGE:$DOCKERTAG && docker push $DOCKERREPO/$DOCKERIMAGE:$DOCKERTAG
	if [ $? -eq 0 ] ; then
		echo "$FRIENDLYNAME has commited and automatically pushed to docker hub"
		logger -i -t $CONTAINERNAME "$FRIENDLYNAME has commited and automatically pushed to docker hub"
	else
		echo "$FRIENDLYNAME has failed to commit and automatically push to docker hub"
		logger -i -t $CONTAINERNAME "$FRIENDLYNAME has failed to commit and automatically push to docker hub"
	fi
