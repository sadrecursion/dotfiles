# My shitty dotfiles

**Warning:** this repository is highly opinionated and tailored to my own workflow.

## Usage

The dotfiles are managed with [`stow`](https://www.gnu.org/software/stow/manual/stow.html).
Stow only the packages you need:

```sh
cd ~/dotfiles
stow nvim foot
```

- `stow PACKAGE` installs a package.
- `stow -D PACKAGE` removes it.
- `stow -n PACKAGE` shows what would happen, without changing anything.

Packages:

- `bash` — `~/.bashrc`: vi mode, aliases and history settings.
- `foot` — `~/.config/foot/foot.ini`: terminal emulator config.
- `git` — `~/.gitconfig`: aliases, `main` as default branch, `zdiff3` conflicts, colored output.
- `i3status-rust` — `~/.config/i3status-rust/config.toml`: status bar for Sway.
- `nvim` — `~/.config/nvim/`: Neovim config with pinned plugins.
- `sway` — `~/.config/sway/config`: keybindings and app launchers.
- `zathura` — `~/.config/zathura/zathurarc`: PDF viewer config.

`scripts/` and `wallpapers/` are not dotfile config, so they are not listed above.

## Arch Linux install
The list of packages is defined in `packages.txt`.

 1. Partition and mount your disks.
 2. Connect to the internet.
 3. Run `arch-install.sh`.

## More scripts
 - `nmcli-connect-eduroam.sh` creates and configures an eduroam connection.

## TODO
 - [ ] Bootloader recovery script
 - [ ] GitHub SSH key generation script
