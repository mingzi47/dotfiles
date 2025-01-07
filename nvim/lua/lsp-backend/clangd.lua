local config = {
    capabilities = {
        textDocument = { completion = { completionItem = { snippetSupport = false } } },
    },
    cmd = {
        'clangd',
        '--background-index',
        '--header-insertion-decorators=false',
    },
    init_options = { fallbackFlags = { vim.bo.filetype == 'cpp' and '-std=c++20' or nil } },
    root_dir = function(fname)
        return require('lspconfig').util.root_pattern(unpack({
            '.git',
            'Makefile',
            'CMakeLists.txt',
            '.clangd',
            '.clang-tidy',
            '.clang-format',
        }))(fname) or require('lspconfig').util.find_git_ancestor(fname)
    end,
}


return config
