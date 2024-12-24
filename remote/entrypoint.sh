#!/bin/sh

uid=0
gid=0
user=root
host=local
remDir=/app/mnt
mntDir=/app/mnt

# /usr/bin/sshfs -o idmap=user,uid=0,gid=0 -o allow_other root@local:/app/mnt /app/mnt
/usr/bin/sshfs \
	-o idmap=user,uid=${uid},gid=${gid} \
	-o allow_other \
	${user}@${host}:${remDir} \
	${mntDir}
