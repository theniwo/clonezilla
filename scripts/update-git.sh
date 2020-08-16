#!/usr/bin/env bash

PARAMETER="$1"

SOURCE="${BASH_SOURCE[0]}"
  while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

source $DIR/env

cd $DIR/..

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

if [[ $PARAMETER == "--force" ]] || [[ $PARAMETER == "-f" ]]; then
  echo "Forcing Commit"
  date +%Y%m%d%H%M%S > $DIR/../CHANGEFILE
fi
main
