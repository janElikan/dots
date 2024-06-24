## Installing on a new host
Boot from a [NixOS live USB](https://nixos.org/download/#nixos-iso) and run:

```shell
git clone https://github.com/janElikan/dots
cd dots
nixos-generate-config --no-filesystems --dir .
lsblk
```

Open `disk.nix` with you favorite editor and change the target disk.
Then change the hostname in `configuration.nix`.
You can also add the `amdgpu` kernel module into `hardware-configuration.nix` now if applicable.

```shell
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disk.nix

sudo mkdir -p /mnt/nix/persist/
sudo cp -r . /mnt/nix/persist/dots
cd /mnt/nix/persist/

sudo mkdir sync
sudo mkdir sync-config

sudo mkdir -p identity/ssh/
cd identity

sudo cp /etc/machine-id .
sudo cp /etc/ssh/ssh_host_* ssh/

sudo nixos-install --flake /mnt/nix/persist/dots#default
reboot
```

