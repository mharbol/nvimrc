# My [neovim](https://neovim.io) Configuration
## Prereqs
Most things work well enough on their own; if not here are a few additions.

[Java LSP tools](https://download.eclipse.org/jdtls/snapshots/?d). Requires Java 17 or later.

The exact font used is [`DroidSansM Nerd Font Mono`](https://www.nerdfonts.com/font-downloads).
This works well on both macOS and WSL.

## LSP clients and other functionalities:
[Telescope](https://github.com/nvim-telescope/telescope.nvim) specifically uses
[`ripgrep`](https://github.com/BurntSushi/ripgrep) for global searching in files.
I assume there is a way to point it to regular `grep` but I just installed it:
```bash
cargo install ripgrep
```

I am not totally certain how many of these needed to get downloaded manually but if they give you issues
here are the commands I used to rectify those situations.
```bash
# gopls
go install -v golang.org/x/tools/gopls@latest
# python virtual environment
sudo apt install --yes -- python3-venv
# Typescript Language Server
npm install -g typescript typescript-language-server
# Astro JS Build Tool
npm install -g @astrojs/language-server
# gradle_ls
./gradlew installDist
```
