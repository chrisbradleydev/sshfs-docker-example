# sshfs-docker-example

## Introduction

This project demonstrates mounting a local filesystem to a remote file system using [SSHFS](https://github.com/libfuse/sshfs).

## Prerequisites

- [Docker Compose](https://docs.docker.com/compose/)
- [Make](https://www.gnu.org/software/make/)

## Development

Clone the repository.

```sh
git clone https://github.com/chrisbradleydev/sshfs-docker-example.git
```

Initialize Docker containers with Make.

```sh
cd sshfs-docker-example
make
```

Shell into the `remote` container with Make.

```sh
make remote-connect
```

Start SSHFS in the `remote` container.

```sh
/usr/bin/sshfs -o idmap=user,uid=0,gid=0 -o allow_other root@local:/app/mnt /app/mnt
```

Use the `mount` command in the `remote` container to observe the mounted directory.

```sh
mount
```

Use the `fusermount` command in the `remote` container to unmount the directory.

```sh
fusermount -u /app/mnt
```
