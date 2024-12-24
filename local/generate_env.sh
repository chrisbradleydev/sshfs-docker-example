#!/bin/sh

pubkey1=$(cat /etc/ssh/ssh_host_ed25519_key.pub | awk '{print $1, $2}')
pubkey2=$(cat /etc/ssh/ssh_host_rsa_key.pub | awk '{print $1, $2}')
pubkey3=$(cat /etc/ssh/ssh_host_ecdsa_key.pub | awk '{print $1, $2}')

echo "KNOWN_HOSTS=\"local ${pubkey1}\nlocal ${pubkey2}\nlocal ${pubkey3}\""
