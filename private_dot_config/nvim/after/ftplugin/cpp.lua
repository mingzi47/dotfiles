local setup_lsp = require("utils.tools").setup_lsp
setup_lsp("clangd", {
    cmd = {
        'clangd',
        '--background-index',
        '--header-insertion-decorators=true',
    },
    init_options = {
        fallbackFlags = {
            vim.bo.filetype == 'cpp' and '--std=c++20' or nil,
        },
    },
    root_markers = {
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac", -- AutoTools
        "Makefile",
        "configure.ac",
        "configure.in",
        "config.h.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja",
        ".git",
    },
})
