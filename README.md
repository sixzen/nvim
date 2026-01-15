<div align="center">

# Neovim Configuration

My personal Neovim setup for full-stack development.

[![Neovim](https://img.shields.io/badge/Neovim-0.11+-blueviolet.svg?style=flat-square&logo=Neovim&logoColor=white)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Lua-5.1+-blue.svg?style=flat-square&logo=lua)](http://www.lua.org)

</div>

## Overview

This is my personal Neovim configuration built with Lua. It's optimized for my workflow and preferences, but feel free to browse and take inspiration for your own setup.

## Features

- LSP support for multiple languages (TypeScript, Python, Go, Java, Lua, R, and more)
- AI-assisted coding with GitHub Copilot and Avante
- Full debugging support with DAP
- Rich markdown and Quarto notebook support
- Fuzzy finding with Telescope
- Git integration
- Custom statusline and UI components

## Requirements

- Neovim >= 0.11.0
- Git
- A Nerd Font
- Node.js
- ripgrep
- fd

## Installation

```bash
git clone git@github.com:sixzen/nvim.git ~/.config/nvim
nvim
```

Plugins will be installed automatically on first launch via [lazy.nvim](https://github.com/folke/lazy.nvim).

## Structure

```
.
├── ftplugin/       # Filetype-specific settings
├── lsp/            # Language server configurations
├── lua/
│   ├── config/     # General configuration
│   ├── plugins/    # Plugin specifications
│   └── sixzen/     # Core settings and modules
└── init.lua        # Entry point
```

## Note

This configuration is tailored to my personal workflow and preferences. It's made public in case anyone wants to reference specific configurations or get ideas for their own setup.

---

<div align="center">

**[Sixzen](https://github.com/sixzen)**

</div>
