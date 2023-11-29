# My [neovim](https://neovim.io) Configuration
## Prereqs
Most things work well enough on their own; if not here are a few additions.

[Java LSP tools](https://download.eclipse.org/jdtls/snapshots/?d). Requres Java 17 or later.

For the best fitting font, run the following command and install to your shell/terminal:
```bash
curl -sS https://webi.sh/nerdfont | sh
```
LSP clients and other functionalities:
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
# ripgrep (rg)
cargo install ripgrep
```
