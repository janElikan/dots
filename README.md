## Installing on a new host
Boot from a [NixOS live USB](https://nixos.org/download/#nixos-iso) and run:

```shell
git clone https://github.com/janElikan/dots
cd dots

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disk.nix
nixos-generate-config --no-filesystems --root /mnt
sudo mkdir -p /mnt/etc/nixos
sudo cp ./* /mnt/etc/nixos/
sudo nixos-install
reboot
```

though I haven't tested that yet. I will on 2024-06-24.
