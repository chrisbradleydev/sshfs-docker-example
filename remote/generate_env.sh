#!/bin/sh

public_key=$(cat /root/.ssh/id_ed25519.pub)
private_key=$(cat /root/.ssh/id_ed25519 | sed ':a;N;$!ba;s/\n/\\n/g')

cat <<EOF
REMOTE_ED25519_PUBLIC_KEY="${public_key}"
REMOTE_ED25519_PRIVATE_KEY="${private_key}"
EOF
