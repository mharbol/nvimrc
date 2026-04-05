# My [neovim](https://neovim.io) Configuration
## Prereqs
Most things work well enough on their own; if not here are a few additions.

[Java LSP tools](https://download.eclipse.org/jdtls/snapshots/?d). Requires Java 17 or later.

[Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for nvim 0.12+ requires
[`tree-sitter-cli`](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md).
The easiest way to get that is:
```bash
cargo install --locked tree-sitter-cli
```

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
# python virtual environment
sudo apt install --yes -- python3-venv
# gradle_ls
./gradlew installDist
```
