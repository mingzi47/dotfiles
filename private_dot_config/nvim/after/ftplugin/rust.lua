local setup_lsp = require("utils.tools").setup_lsp
setup_lsp("rust_analyzer", {
    settings = {
        cargo = {
            allFeatures = true,
            allTargets = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
                enable = true,
            },
        },
        checkOnSave = {
            allFeatures = true,
            command = "clippy",
        }
    }
})
