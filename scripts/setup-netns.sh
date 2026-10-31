#!/bin/bash
# Cree un espace de noms reseau "ue1" pour executer l'UE UERANSIM
# sur la meme VM que le coeur Open5GS (lien veth 10.200.0.1 <-> 10.200.0.2)
if ! ip netns list | grep -q '^ue1'; then
  sudo ip netns add ue1
  sudo ip link add veth-host type veth peer name veth-ue
  sudo ip link set veth-ue netns ue1
  sudo ip addr add 10.200.0.1/24 dev veth-host
  sudo ip link set veth-host up
  sudo ip netns exec ue1 ip addr add 10.200.0.2/24 dev veth-ue
  sudo ip netns exec ue1 ip link set veth-ue up
  sudo ip netns exec ue1 ip link set lo up
fi
