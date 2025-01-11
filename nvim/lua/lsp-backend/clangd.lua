local config = {
    capabilities = {
        textDocument = { completion = { completionItem = { snippetSupport = false } } },
    },
    cmd = {
        'clangd',
        '--background-index',
        '--header-insertion-decorators=true',
    },
    init_options = {
        fallbackFlags = {
            '--std=c++20',
        },
    },
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
