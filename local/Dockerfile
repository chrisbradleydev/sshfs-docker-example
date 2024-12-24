FROM alpine:3.20
WORKDIR /app

ARG REMOTE_ED25519_PUBLIC_KEY

ENV PS1="\[\033[1;32m\]\[\033[1;36m\][\u@\h] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]"

RUN \
	# make mount directory
	mkdir -p /app/mnt \
	# add aliases
	&& echo 'alias ll="ls -lah"' > /root/.bashrc \
	&& source /root/.bashrc \
	# create config file
	&& echo 'mounts: true' > /app/mnt/config.yaml \
	# allow root
	&& mkdir -p /etc/ssh/sshd_config.d \
	&& echo 'PermitRootLogin yes' > /etc/ssh/sshd_config.d/config \
	# set authorized_keys from remote container
	&& mkdir -p /root/.ssh \
	&& echo ${REMOTE_ED25519_PUBLIC_KEY} > /root/.ssh/authorized_keys \
	# install packages
	&& apk update \
	&& apk add --no-cache \
	bash \
	bind-tools \
	curl \
	git \
	openssh \
	nmap \
	vim \
	# cleanup
	&& rm -rf /var/cache/apk/* \
	# generate keys
	&& ssh-keygen -A

COPY generate_env.sh /app/generate_env

ENTRYPOINT ["/usr/sbin/sshd"]
CMD ["-D"]
