## Edit 0
I'm writing this as I'm installing the system. This file contains the installation log and explainers of decisions made.

The first thing I did on it was `nix-shell -p zellij` so I can copy the entire shell history (hopefully).

First, I'm gonna be using disko with a tmpfs root. This is the main reason I'm installing this system in the first place (I'm already running nixos on the host, but its partitions were set up manually).

I'm adding `disk.nix` here, it's a modified version of [the tmpfs example](https://github.com/nix-community/disko/blob/master/example/tmpfs.nix). I'm choosing the non-hybrid version since both the VM and my host system are using UEFI.

## Edit 1
Actually I'm gonna use the [hybrid](https://github.com/nix-community/disko/blob/master/example/hybrid-tmpfs-on-root.nix) version instead, and then strip out the MBR parts. The tmpfs example doesn't use tmpfs on root, but rather on `/tmp`.

## Edit 2
Now I'll go generate the default config and patch it to work with disko. The next step will be making it into a flake

## Edit 3
I will make it a flake after a reboot.

Speaking of which, how is it gonna know where to grab the configs from if its root is deleted every time. Ugh...

It seems that either the system is smart enough to keep /etc/nixos OR that I need to mount -o bind it. More like the latter actually.

## Edit 4 after reboot
So I don't currently have any desktop environment.

The system is usable though. I'll test if the home directory is erased on every boot and then make this a repo so you can *see* what's happenning. Cool that it works!

## Edit 5
I figured out where it gets the config from. It doesn't. The system is built using `nixos-rebuild` or `nixos-install` and then the config can be deleted, it does not care.

## Todos for 2024-06-18
- [x] make this a flake
- [x] install home manager
- [x] configure home manager
- [ ] configure git, helix and zellij

## Todos for 2024-06-19
- [ ] set up sway in such a way that I don't need a mouse

## 2024-06-19
I'm treating this file as append-only for now.

Sway was more difficult to set up on this than I thought, so I'll do it some other day. I'll focus on devtools for now.

Turns out quickemu just forwards port 22, so I have ssh access to this box.

This solves the desktop problem (at least for now).
