# My [neovim](https://neovim.io) Configuration
## Prereqs
[Java LSP tools](https://download.eclipse.org/jdtls/snapshots/?d). Requres Java 17 or later.

For the best fitting font, run the following command and install to your shell/terminal:
```bash
curl -sS https://webi.sh/nerdfont | sh
```
LSP clients and other functionalities:
```bash
# gopls
go install -v golang.org/x/tools/gopls@latest
# Typescript Language Server
npm install -g typescript typescript-language-server
# Astro JS Build Tool
npm install -g @astrojs/language-server
# gradle_ls
./gradlew installDist
# ripgrep (rg)
cargo install ripgrep
```

## Here is my cheesy demo:
https://github.com/mharbol/nvimrc/assets/27396316/7c423e66-a9d4-4411-a045-d3f564026231
