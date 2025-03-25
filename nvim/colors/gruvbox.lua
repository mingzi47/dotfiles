local colors = require("utils.colors")

local function setcolor()
    local groups = {
        -- Base groups
        Normal = { fg = colors.fg1 },
        NormalFloat = { fg = colors.fg0, bg = 'NONE' },
        FloatWin = { fg = colors.fg0 },
        FloatBorder = { fg = colors.orange },
        NormalNC = { link = 'Normal' },
        CursorLine = { bg = colors.bg1 },
        CursorColumn = { link = 'CursorLine' },
        CursorWord = { underline = true },
        TabLineTop = { fg = colors.bg0, bg = colors.bg0, bold = true },
        TabLineSel = { fg = colors.fg1, bg = colors.bg0, bold = true },
        TabLine = { fg = colors.fg4, bg = colors.bg0, bold = true },
        TabLineFill = { fg = 'NONE', bg = 'NONE' },
        MatchParen = { bg = colors.bg3, bold = true },
        ColorColumn = { bg = colors.bg1 },
        Conceal = { fg = colors.dblue },
        CursorLineNr = { fg = colors.yellow },
        NonText = { fg = colors.bg2 },
        SpecialKey = { fg = colors.fg4 },
        Visual = { reverse = true },
        VisualNOS = { link = 'Visual' },
        Search = { fg = colors.yellow, bg = colors.bg0, reverse = true },
        IncSearch = { fg = colors.orange, bg = colors.bg0, reverse = true },
        CurSearch = { link = 'IncSearch' },
        QuickFixLine = { fg = colors.bg0, bg = colors.yellow, bold = true },
        Underlined = { fg = colors.dblue, underline = true },
        StatusLine = { fg = colors.bg0, bg = colors.black },
        StatusLineNC = { fg = colors.bg0, reverse = true },
        WinBar = { fg = colors.fg4, bg = colors.bg0 },
        WinBarNC = { fg = colors.fg3, bg = colors.bg0 },
        WinSeparator = { fg = colors.bg3, bg = colors.bg0 },
        WildMenu = { fg = colors.dblue, bg = colors.bg2, bold = true },
        Directory = { fg = colors.dblue, bold = true },
        Title = { fg = colors.green, bold = true },
        ErrorMsg = { fg = colors.bg0, bg = colors.red, bold = true },
        MoreMsg = { fg = colors.yellow, bold = true },
        ModeMsg = { fg = colors.yellow, bold = true },
        Question = { fg = colors.orange, bold = true },
        WarningMsg = { fg = colors.red, bold = true },
        LineNr = { fg = colors.bg4 },
        SignColumn = { bg = colors.bg0 },
        Folded = { fg = colors.gray, bg = colors.bg1, italic = true },
        FoldColumn = { fg = colors.gray, bg = colors.bg1 },
        Cursor = { reverse = true },
        vCursor = { link = 'Cursor' },
        iCursor = { link = 'Cursor' },
        lCursor = { link = 'Cursor' },
        Special = { fg = colors.orange },
        Comment = { fg = colors.gray, italic = true },
        Error = { fg = colors.red, bold = true, reverse = true },
        Done = { fg = colors.orange, bold = true, italic = true },
        Statement = { fg = colors.red },
        Conditional = { fg = colors.red },
        Repeat = { fg = colors.red },
        Label = { fg = colors.red },
        Exception = { fg = colors.red },
        Operator = { fg = colors.orange },
        Keyword = { fg = colors.red },
        Identifier = { fg = colors.dblue },
        Function = { fg = colors.green, bold = true },
        PreProc = { fg = colors.aqua },
        Include = { fg = colors.aqua },
        Define = { fg = colors.aqua },
        Macro = { fg = colors.aqua },
        PreCondit = { fg = colors.aqua },
        Constant = { fg = colors.purple },
        Character = { fg = colors.purple },
        String = { fg = colors.green, italic = true },
        Boolean = { fg = colors.purple },
        Number = { fg = colors.purple },
        Float = { fg = colors.purple },
        Type = { fg = colors.yellow },
        StorageClass = { fg = colors.orange },
        Structure = { fg = colors.aqua },
        Typedef = { fg = colors.yellow },
        DiffDelete = { fg = colors.red, bg = colors.bg0, reverse = true },
        DiffAdd = { fg = colors.green, bg = colors.bg0, reverse = true },
        DiffChange = { fg = colors.aqua, bg = colors.bg0, reverse = true },
        DiffText = { fg = colors.yellow, bg = colors.bg0, reverse = true },
        SpellCap = { undercurl = true, sp = colors.dblue },
        SpellBad = { undercurl = true, sp = colors.red },
        SpellLocal = { undercurl = true, sp = colors.aqua },
        SpellRare = { undercurl = true, sp = colors.purple },
        Whitespace = { fg = colors.bg2 },
        Delimiter = { fg = colors.orange },
        -- LSP Diagnostic
        DiagnosticError = { fg = colors.red },
        DiagnosticSignError = { fg = colors.red },
        DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
        DiagnosticWarn = { fg = colors.yellow },
        DiagnosticSignWarn = { fg = colors.yellow },
        DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow },
        DiagnosticInfo = { fg = colors.dblue },
        DiagnosticSignInfo = { fg = colors.blue },
        DiagnosticUnderlineInfo = { undercurl = true, sp = colors.dblue },
        DiagnosticHint = { fg = colors.aqua },
        DiagnosticSignHint = { fg = colors.aqua },
        DiagnosticUnderlineHint = { undercurl = true, sp = colors.aqua },
        DiagnosticFloatingError = { fg = colors.red },
        DiagnosticFloatingWarn = { fg = colors.orange },
        DiagnosticFloatingInfo = { fg = colors.dblue },
        DiagnosticFloatingHint = { fg = colors.aqua },
        DiagnosticVirtualTextError = { fg = colors.red },
        DiagnosticVirtualTextWarn = { fg = colors.yellow },
        DiagnosticVirtualTextInfo = { fg = colors.dblue },
        DiagnosticVirtualTextHint = { fg = colors.aqua },
        LspReferenceRead = { fg = colors.yellow, bold = true },
        LspReferenceText = { fg = colors.yellow, bold = true },
        LspReferenceWrite = { fg = colors.orange, bold = true },
        LspCodeLens = { fg = colors.gray },
        LspSignatureActiveParameter = { link = 'Search' },
        -- gitcommit
        gitcommitSelectedFile = { fg = colors.green },
        gitcommitDiscardedFile = { fg = colors.red },
        -- gitsigns.nvim
        GitSignsAdd = { fg = colors.green },
        GitSignsChange = { fg = colors.magenta },
        GitSignsDelete = { fg = colors.red },
        GitSignsAddLn = { fg = colors.green },
        GitSignsChangeLn = { fg = colors.magenta },
        GitSignsDeleteLn = { fg = colors.red },
        -- diff
        diffAdded = { fg = colors.green },
        diffRemoved = { fg = colors.red },
        diffChanged = { fg = colors.aqua },
        diffFile = { fg = colors.orange },
        diffNewFile = { fg = colors.yellow },
        diffOldFile = { fg = colors.orange },
        diffLine = { fg = colors.dblue },
        diffIndexLine = { link = 'diffChanged' },
        -- lspsaga.nvim
        LspSagaCodeActionTitle = { link = 'Title' },
        LspSagaCodeActionBorder = { fg = colors.fg1 },
        LspSagaCodeActionContent = { fg = colors.green, bold = true },
        LspSagaLspFinderBorder = { fg = colors.fg1 },
        LspSagaAutoPreview = { fg = colors.orange },
        TargetWord = { fg = colors.dblue, bold = true },
        FinderSeparator = { fg = colors.aqua },
        LspSagaDefPreviewBorder = { fg = colors.dblue },
        LspSagaHoverBorder = { fg = colors.orange },
        LspSagaRenameBorder = { fg = colors.dblue },
        LspSagaDiagnosticSource = { fg = colors.orange },
        LspSagaDiagnosticBorder = { fg = colors.purple },
        LspSagaDiagnosticHeader = { fg = colors.green },
        LspSagaSignatureHelpBorder = { fg = colors.green },
        SagaShadow = { fg = colors.bg0 },
        -- Indent
        IndentLine = { fg = colors.bg2 },
        IndentLineCurrent = { link = 'Comment' },
        -- StatusLine
        -- StatusLineMode = { fg = colors.fg2 },
        -- StatusLineFileInfo = { fg = colors.fg2 },
        -- StatusLineReadOnly = { fg = colors.red },
        -- StatusLineBranch = { fg = colors.violet },
        -- StatusLineLsp = { fg = colors.fg4 },
        -- StatusLineFilesize = { fg = colors.fg4 },
        -- StatusLineEncoding = { fg = colors.fg4 },
        -- StatlsLineLnum = { fg = colors.fg2 },
        -- pmenu
        Pmenu = { fg = '#C5C8C6', bg = '#383838' },
        PmenuSel = { bg = colors.bg2 },
        PmenuSbar = { bg = colors.bg2 },
        PmenuThumb = { bg = colors.bg4 },
        PmenuKind = { fg = colors.violet, bg = colors.bg2 },
        PmenuKindSel = { fg = colors.bg2, bg = colors.dblue, bold = true },
        PmenuExtra = { fg = colors.fg1, bg = colors.bg2 },
        PmenuExtraSel = { fg = colors.bg2, bg = colors.dblue, bold = true },
        -- cmp
        Cmp = { fg = '#C5C8C6' },
        CmpBorder = { fg = colors.orange },
        BlinkCmpMenu = { link = 'Cmp' },
        BlinkCmpMenuBorder = { link = 'CmpBorder' },
        BlinkCmpDoc = { link = 'Cmp' },
        BlinkCmpDocBorder = { link = 'CmpBorder' },
        BlinkCmpLabel = { link = 'Cmp' },
        BlinkCmpLabelMatch = { fg = colors.cyan, bold = true },
        BlinkCmpKind = { link = 'Cmp' },
        NotifyBackground = { bg = '#000000' },

        -- nvim-treesitter
        -- Todo         anything that needs extra attention; mostly the
        --              keywords TODO FIXME and NOTE
        ['@comment'] = { link = 'Comment' },
        ['@comment.note'] = { fg = colors.bg0, bg = colors.blue, bold = true, italic = true },
        ['@comment.todo'] = { fg = colors.bg0, bg = colors.yellow, bold = true, italic = true },
        ['@comment.error'] = { link = 'Error' },
        ['@none'] = { bg = 'NONE', fg = 'NONE' },
        ['@preproc'] = { link = 'PreProc' },
        ['@define'] = { link = 'Define' },
        ['@operator'] = { link = 'Operator' },
        ['@punctuation.delimiter'] = { link = 'Delimiter' },
        ['@punctuation.bracket'] = { link = 'Delimiter' },
        ['@punctuation.special'] = { link = 'Delimiter' },
        ['@string'] = { link = 'String' },
        ['@string.regex'] = { link = 'String' },
        ['@string.escape'] = { link = 'SpecialChar' },
        ['@string.special'] = { link = 'SpecialChar' },
        ['@character'] = { link = 'Character' },
        ['@character.special'] = { link = 'SpecialChar' },
        ['@boolean'] = { link = 'Boolean' },
        ['@number'] = { link = 'Number' },
        ['@float'] = { link = 'Float' },
        ['@function'] = { link = 'Function' },
        ['@function.builtin'] = { link = 'Special' },
        ['@function.call'] = { link = 'Function' },
        ['@function.macro'] = { link = 'Macro' },
        ['@method'] = { link = 'Function' },
        ['@method.call'] = { link = 'Function' },
        ['@constructor'] = { link = 'Special' },
        ['@parameter'] = { link = 'Identifier' },
        ['@keyword'] = { link = 'Keyword' },
        ['@keyword.conditional'] = { link = 'Conditional' },
        ['@keyword.debug'] = { link = 'Debug' },
        ['@keyword.directive'] = { link = 'PreProc' },
        ['@keyword.directive.define'] = { link = 'Define' },
        ['@keyword.exception'] = { link = 'Exception' },
        ['@keyword.function'] = { link = 'Keyword' },
        ['@keyword.import'] = { link = 'Include' },
        ['@keyword.operator'] = { fg = colors.red },
        ['@keyword.repeat'] = { link = 'Repeat' },
        ['@keyword.return'] = { link = 'Keyword' },
        ['@keyword.storage'] = { link = 'StorageClass' },
        ['@conditional'] = { link = 'Conditional' },
        ['@repeat'] = { link = 'Repeat' },
        ['@debug'] = { link = 'Debug' },
        ['@label'] = { link = 'Label' },
        ['@include'] = { link = 'Include' },
        ['@exception'] = { link = 'Exception' },
        ['@type'] = { link = 'Type' },
        ['@type.builtin'] = { link = 'Type' },
        ['@type.definition'] = { link = 'Typedef' },
        ['@type.qualifier'] = { link = 'Type' },
        ['@storageclass'] = { link = 'StorageClass' },
        ['@attribute'] = { link = 'PreProc' },
        ['@field'] = { link = 'Identifier' },
        ['@property'] = { link = 'Identifier' },
        ['@variable'] = { link = 'Normal' },
        ['@variable.builtin'] = { link = 'Special' },
        ['@variable.member'] = { fg = colors.dblue },
        ['@constant'] = { link = 'Constant' },
        ['@constant.builtin'] = { link = 'Special' },
        ['@constant.macro'] = { link = 'Define' },
        ['@namespace'] = { fg = colors.fg1 },
        ['@symbol'] = { link = 'Identifier' },
        ['@text'] = { fg = colors.fg1 },
        ['@text.strong'] = { bold = true },
        ['@text.emphasis'] = { italic = true },
        ['@text.underline'] = { underline = true },
        ['@text.strike'] = { strikethrough = true },
        ['@text.title'] = { link = 'Title' },
        ['@text.literal'] = { link = 'String' },
        ['@text.uri'] = { link = 'Underlined' },
        ['@text.math'] = { link = 'Special' },
        ['@text.environment'] = { link = 'Macro' },
        ['@text.environment.name'] = { link = 'Type' },
        ['@text.reference'] = { link = 'Constant' },
        ['@text.note.comment'] = { fg = colors.red, bold = true },
        ['@text.warning'] = { link = 'WarningMsg' },
        ['@text.danger'] = { link = 'ErrorMsg' },
        ['@text.danger.comment'] = { fg = colors.fg0, bg = colors.red, bold = true },
        ['@text.diff.add'] = { link = 'diffAdded' },
        ['@text.diff.delete'] = { link = 'diffRemoved' },
        ['@tag'] = { link = 'Tag' },
        ['@tag.attribute'] = { link = 'Identifier' },
        ['@tag.delimiter'] = { link = 'Delimiter' },
        ['@punctuation'] = { link = 'Delimiter' },
        ['@macro'] = { link = 'Macro' },
        ['@structure'] = { link = 'Structure' },
        ['@lsp.type.class'] = { link = '@constructor' },
        ['@lsp.type.comment'] = {}, -- do not overwrite comments
        ['@lsp.type.decorator'] = { link = '@parameter' },
        ['@lsp.type.enum'] = { link = '@type' },
        ['@lsp.type.enumMember'] = { link = '@constant' },
        ['@lsp.type.function'] = { link = '@function' },
        ['@lsp.type.interface'] = { link = '@keyword' },
        ['@lsp.type.macro'] = { link = '@macro' },
        ['@lsp.type.method'] = { link = '@method' },
        ['@lsp.type.namespace'] = { link = '@namespace' },
        ['@lsp.type.parameter'] = { link = '@parameter' },
        ['@lsp.type.property'] = { link = '@property' },
        ['@lsp.type.struct'] = { link = '@constructor' },
        ['@lsp.type.type'] = { link = '@type' },
        ['@lsp.type.typeParameter'] = { link = '@type.definition' },
        ['@lsp.type.variable'] = { link = '@variable' },
    }

    return groups
end

local groups = setcolor()

-- add highlights
for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
end
