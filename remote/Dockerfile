FROM alpine:3.20
WORKDIR /app

ARG KNOWN_HOSTS

ENV PS1="\[\033[1;32m\]\[\033[1;36m\][\u@\h] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]"

RUN \
	# make mount directory
	mkdir -p /app/mnt \
	# add aliases
	&& echo 'alias ll="ls -lah"' > /root/.bashrc \
	&& source /root/.bashrc \
	# disable strict host checking
	&& mkdir -p /root/.ssh \
	&& echo -e 'Host *\n\tStrictHostKeyChecking no' > /root/.ssh/config \
	# install packages
	&& apk update \
	&& apk add --no-cache \
	bash \
	bind-tools \
	curl \
	fuse \
	fuse-dev \
	git \
	nmap \
	sshfs \
	vim \
	# cleanup
	&& rm -rf /var/cache/apk/* \
	# generate ed25519 key
	&& ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519 -N ""

COPY generate_env.sh /app/generate_env
COPY entrypoint.sh /app/entrypoint

ENTRYPOINT ["/app/entrypoint"]
