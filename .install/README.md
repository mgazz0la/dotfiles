# Installing zz-archlinux

```sh
chmod +x .install/install.sh
.install/install.sh
```

## Notes

`pkglist.txt` contains the list of `pacman` packages to install. The list is generated with the following command:

```sh
pacman -Qqen >pkglist.txt
```

`aur_pkglist.txt` contains the list of AUR packages to install via `paru`. The list is generated with the following command:

```sh
pacman -Qqem >aur_pkglist.txt
```

