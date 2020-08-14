# Clonezilla

Backup and restore drives with clonezilla

# Background

I run a set of Raspberry PIs and I do daily backups with bacula.
Additionally I do a monthly complete backup of the sd-cards with clonezilla.
I used to do this in a virtual machine, but for convinience I built this docker image.
Now I just have to connect the sd-card reader to my server and backup the images to an nfs share.
Works as well with any other drives ;)

## Usage

### Build container

Either use the provided compose file,
```
git clone https://github.com/theniwo/clonezilla
docker-compose -f clonezilla/docker-compose.yml up -d
```

or build your compose file yourself according to this template:
```
version: '2'

volumes:
  data:
  logs:

services:
  app:
    image: theniwo/clonezilla:latest
    container_name: clonezilla
    hostname: clonezilla
    mem_limit: "2G"
    restart: unless-stopped
    privileged: true
    ports:
      - "2222:22"
    environment:
      - TERM=xterm
    volumes:
      - /dev:/dev
      - <LOCAL FOLDER OR NFS SHARE>:/home/partimag:shared
      - data:/root
      - logs:/var/log
```
otherwise use docker run command

```
docker run -d \
        --name clonezilla \
        --hostname clonezilla \
        --restart unless-stopped \
        --memory 128M \
        --privileged=true \
        -e TERM=xterm \
        -e TZ=Europe/Berlin \
        -v /dev:/dev \
        -v clonezilla_data:/root \
        -v clonezilla_logs:/var/log \
        -v <BACKUPDIR>:/home/partimag:shared \
        theniwo/clonezilla:latest
```

### Start clonezilla

```
docker exec -it clonezilla clonezilla
```
or
```
ssh root@IP -p 2222
```

If you choose _device-image_ select _skip Use existing /home/partimag_ when asked for the  mountpoint.


**NOTES**
<!---
	<pre>
	Scrolltext
	</pre>
-->

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Infobox_info_icon.svg/1200px-Infobox_info_icon.svg.png" alt="drawing" width="20"/>

The latest version will be updated regularly.

**TODO**

  - [X] SSH support
  - [ ] Include fail2ban
  - [ ] Write docker run command
  - [ ] Print logfile to stdout
  - [ ] Make a version for arm architecture

**CONTACT**

[disp@mailbox.org](mailto:disp@mailbox.org)

**LINKS**

[Docker Hub](https://hub.docker.com/repository/docker/theniwo/clonezilla)

[Git Hub](https://github.com/theniwo/clonezilla)
