#!/usr/bin/env bash

printf "label: gpt\n,550M,U\n,,L\n" | sfdisk "/dev/$1"

mkfs.fat -F 32 "/dev/$1"1

mkfs.btrfs "/dev/$1"2
mkdir -p /mnt
mount "/dev/$1"2 /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
umount /mnt

mount -o compress=zstd,subvol=root "/dev/$1"2 /mnt
mkdir /mnt/{home,nix}
mount -o compress=zstd,subvol=home "/dev/$1"2 /mnt/home
mount -o compress=zstd,noatime,subvol=nix "/dev/$1"2 /mnt/nix

mkdir /mnt/boot
mount /dev/"$1"1 /mnt/boot
cd /mnt

nixos-install --flake "github:bromine1/nixos-config#""$2" --extra-experimental-features nix-command --extra-experimental-features flakes --impure
