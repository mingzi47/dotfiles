# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A Neovim configuration written in Lua, using **lazy.nvim** as the plugin manager. The config is modular, performance-conscious, and built around the Gruvbox colorscheme.

## Entry Point & Load Order

`init.lua` loads modules in this order:
```
option → keymap → plugin (lazy.nvim) → autocmd → tabline → statusline
```

Colorscheme (`gruvbox`) is set before requiring any modules.

## Directory Structure

- `lua/` — core modules (`option.lua`, `keymap.lua`, `autocmd.lua`, `statusline.lua`, `tabline.lua`, `plugin.lua`)
- `lua/plugins/` — one file per plugin, each exports a lazy.nvim spec table
- `lua/utils/` — shared `colors.lua` (Gruvbox palette) and `icons.lua` (LSP/git/diagnostic icons)
- `after/lsp/` — per-language LSP overrides loaded automatically by Neovim's `after/` mechanism

## Plugin System

`lua/plugin.lua` bootstraps lazy.nvim and imports all specs from `lua/plugins/`. Adding a new plugin means creating a new file in `lua/plugins/` that returns a valid lazy.nvim spec.

Disabled built-ins: `gzip`, `netrwPlugin`, `tarPlugin`, `tohtml`, `tutor`, `zipPlugin`, `rplugin`, `spellfile`.

## LSP Architecture

LSP servers are enabled in `lua/plugins/lsp.lua` via a simple list: `clangd`, `gopls`, `lua_ls`, `ruff`, `pyright`, `rust_analyzer`, `ts_ls`. Per-server configuration lives in `after/lsp/<server>.lua` — Neovim auto-loads these on server attach.

LspAttach keymaps: `gd` (definition), `K` (hover), `grf` (format). Diagnostics float on `CursorHold` with rounded borders.

## Completion

Uses **blink.cmp** (Rust-based, requires `cargo` to be installed). It is built with `cargo build --release` via lazy.nvim's `build` hook. Sources: snippets, LSP, path, buffer. Super-tab preset; `<C-j>/<C-k>` for menu navigation.

## Statusline & Tabline

Both are custom-built in `lua/statusline.lua` and `lua/tabline.lua` — no plugins involved. They import from `lua/utils/icons.lua` and `lua/utils/colors.lua`.

## Utilities

- `lua/utils/colors.lua` — extended Gruvbox palette (40+ named colors; comments use Chinese color names)
- `lua/utils/icons.lua` — centralized icon definitions for LSP kinds, diagnostics, git status, borders

When adding icons or colors, update these files rather than hardcoding values elsewhere.

## Snippets

`snippets/` uses VS Code snippet format (`package.json` + per-language JSON files). Currently only `tasks.json` (C++ build template) exists.
