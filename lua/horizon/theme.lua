local c = require('horizon.palette')

local api = vim.api

local M = {}

local highlights = {
  -- Editor
  { ['Normal'] = { fg = c.fg, bg = c.bg } },
  { ['NormalNC'] = { fg = c.fg, bg = c.bg } },
  { ['SignColumn'] = { fg = 'NONE', bg = c.bg } },
  { ['MsgArea'] = { fg = c.fg, bg = c.bg } },
  { ['ModeMsg'] = { fg = c.fg, bg = c.alt_bg } },
  { ['MsgSeparator'] = { fg = c.fg, bg = c.bg } },
  { ['SpellBad'] = { fg = 'NONE', bg = 'NONE', sp = c.red, undercurl = true } },
  { ['SpellCap'] = { fg = 'NONE', bg = 'NONE', sp = c.yellow, undercurl = true } },
  { ['SpellLocal'] = { fg = 'NONE', bg = 'NONE', sp = c.yelloworange, underline = true } },
  { ['SpellRare'] = { fg = 'NONE', bg = 'NONE', sp = c.purple, underline = true } },
  { ['NormalNC'] = { fg = c.fg, bg = c.bg } },
  { ['Pmenu'] = { fg = c.fg, bg = c.dropdown } },
  { ['PmenuSel'] = { fg = 'NONE', bg = c.ui2_blue } },
  { ['WildMenu'] = { fg = c.fg, bg = c.ui2_blue } },
  { ['CursorLineNr'] = { fg = c.light_gray, bg = 'NONE', bold = true } },
  { ['Folded'] = { fg = c.gray, bg = c.alt_bg } },
  { ['FoldColumn'] = { fg = c.gray, bg = c.alt_bg } },
  { ['LineNr'] = { fg = c.gray, bg = 'NONE' } },
  { ['FloatBoder'] = { fg = c.gray, bg = c.alt_bg } },
  { ['Whitespace'] = { fg = c.pale_grey, bg = 'NONE' } },
  { ['VertSplit'] = { fg = c.gray, bg = c.bg } },
  { ['CursorLine'] = { fg = 'NONE', bg = c.dark_gray } },
  { ['CursorColumn'] = { fg = 'NONE', bg = c.alt_bg } },
  { ['ColorColumn'] = { fg = 'NONE', bg = c.alt_bg } },
  { ['NormalFloat'] = { fg = 'NONE', bg = c.alt_bg } },
  { ['Visual'] = { fg = 'NONE', bg = c.ui_blue } },
  { ['VisualNOS'] = { fg = 'NONE', bg = c.alt_bg } },
  { ['WarningMsg'] = { fg = c.error, bg = c.bg } },
  { ['DiffText'] = { fg = c.alt_bg, bg = c.sign_delete } },
  { ['DiffAdd'] = { fg = c.alt_bg, bg = c.sign_add } },
  { ['DiffChange'] = { fg = c.alt_bg, bg = c.sign_change, underline = true } },
  { ['DiffDelete'] = { fg = c.alt_bg, bg = c.sign_delete } },
  { ['QuickFixLine'] = { fg = 'NONE', bg = c.ui2_blue } },
  { ['PmenuSbar'] = { fg = 'NONE', bg = c.alt_bg } },
  { ['PmenuThumb'] = { fg = 'NONE', bg = c.gray } },
  { ['MatchWord'] = { fg = 'NONE', bg = 'NONE', underline = true } },
  { ['MatchParen'] = { fg = c.hint, bg = 'NONE', underline = true } },
  { ['MatchWordCur'] = { fg = 'NONE', bg = 'NONE', underline = true } },
  { ['MatchParenCur'] = { fg = 'NONE', bg = 'NONE', underline = true } },
  { ['Cursor'] = { fg = c.cursor_fg, bg = c.cursor_bg } },
  { ['lCursor'] = { fg = c.cursor_fg, bg = c.cursor_bg } },
  { ['CursorIM'] = { fg = c.cursor_fg, bg = c.cursor_bg } },
  { ['TermCursor'] = { fg = c.cursor_fg, bg = c.cursor_bg } },
  { ['TermCursorNC'] = { fg = c.cursor_fg, bg = c.cursor_bg } },
  { ['Conceal'] = { fg = c.gray, bg = 'NONE' } },
  { ['Directory'] = { fg = c.folder_blue, bg = 'NONE' } },
  { ['SpecialKey'] = { fg = c.red, bg = 'NONE', bold = true } },
  { ['ErrorMsg'] = { fg = c.error, bg = c.bg, bold = true } },
  { ['Search'] = { fg = 'NONE', bg = c.ui2_blue } },
  { ['IncSearch'] = { fg = 'NONE', bg = c.ui2_blue } },
  { ['Substitute'] = { fg = 'NONE', bg = c.ui2_blue } },
  { ['MoreMsg'] = { fg = c.orange, bg = 'NONE' } },
  { ['Question'] = { fg = c.orange, bg = 'NONE' } },
  { ['EndOfBuffer'] = { fg = c.bg, bg = 'NONE' } },
  { ['NonText'] = { fg = c.bg, bg = 'NONE' } },
  { ['TabLine'] = { fg = c.light_gray, bg = c.line } },
  { ['TabLineSel'] = { fg = c.fg, bg = c.line } },
  { ['TabLineFill'] = { fg = c.line, bg = c.line } },

  -- Code
  { ['Comment'] = { fg = c.gray, bg = 'NONE' } },
  { ['Variable'] = { fg = c.red, bg = 'NONE' } },
  { ['String'] = { fg = c.yelloworange, bg = 'NONE' } },
  { ['Character'] = { fg = c.yelloworange, bg = 'NONE' } },
  { ['Number'] = { fg = c.orange, bg = 'NONE' } },
  { ['Float'] = { fg = c.orange, bg = 'NONE' } },
  { ['Boolean'] = { fg = c.orange, bg = 'NONE' } },
  { ['Constant'] = { fg = c.orange, bg = 'NONE' } },
  { ['Type'] = { fg = c.yellow, bg = 'NONE' } },
  { ['Function'] = { fg = c.cyan, bg = 'NONE' } },
  { ['Keyword'] = { fg = c.purple, bg = 'NONE' } },
  { ['Conditional'] = { fg = c.purple, bg = 'NONE' } },
  { ['Repeat'] = { fg = c.purple, bg = 'NONE' } },
  { ['Operator'] = { fg = c.fg, bg = 'NONE' } },
  { ['PreProc'] = { fg = c.purple, bg = 'NONE' } },
  { ['Include'] = { fg = c.purple, bg = 'NONE' } },
  { ['Exception'] = { fg = c.purple, bg = 'NONE' } },
  { ['StorageClass'] = { fg = c.yellow, bg = 'NONE' } },
  { ['Structure'] = { fg = c.yellow, bg = 'NONE' } },
  { ['Typedef'] = { fg = c.purple, bg = 'NONE' } },
  { ['Define'] = { fg = c.purple, bg = 'NONE' } },
  { ['Macro'] = { fg = c.purple, bg = 'NONE' } },
  { ['Debug'] = { fg = c.red, bg = 'NONE' } },
  { ['Title'] = { fg = c.yellow, bg = 'NONE', bold = true } },
  { ['Label'] = { fg = c.fg, bg = 'NONE' } },
  { ['SpecialChar'] = { fg = c.yelloworange, bg = 'NONE' } },
  { ['Delimiter'] = { fg = c.fg, bg = 'NONE' } },
  { ['SpecialComment'] = { fg = c.fg, bg = 'NONE' } },
  { ['Tag'] = { fg = c.red, bg = 'NONE' } },
  { ['Bold'] = { fg = 'NONE', bg = 'NONE', bold = true } },
  { ['Italic'] = { fg = 'NONE', bg = 'NONE', italic = true } },
  { ['Underlined'] = { fg = 'NONE', bg = 'NONE', underline = true } },
  { ['Ignore'] = { fg = c.hint, bg = 'NONE', bold = true } },
  { ['Todo'] = { fg = c.info, bg = 'NONE', bold = true } },
  { ['Error'] = { fg = c.error, bg = 'NONE', bold = true } },
  { ['Statement'] = { fg = c.purple, bg = 'NONE' } },
  { ['Identifier'] = { fg = c.fg, bg = 'NONE' } },
  { ['PreCondit'] = { fg = c.purple, bg = 'NONE' } },
  { ['Special'] = { fg = c.orange, bg = 'NONE' } },

  -- Treesitter
  { ['TSComment'] = { link = 'Comment' } },
  { ['TSVariable'] = { link = 'Variable' } },
  { ['TSString'] = { link = 'String' } },
  { ['TSStringRegex'] = { link = 'String' } },
  { ['TSStringEscape'] = { link = 'String' } },
  { ['TSCharacter'] = { link = 'String' } },
  { ['TSCharacterSpecial'] = { link = 'SpecialChar' } },
  { ['TSNumber'] = { link = 'Number' } },
  { ['TSFloat'] = { link = 'Float' } },
  { ['TSBoolean'] = { link = 'Boolean' } },
  { ['TSConstant'] = { link = 'Constant' } },
  { ['TSConstBuiltin'] = { link = 'Constant' } },
  { ['TSConstructor'] = { link = 'Type' } },
  { ['TSType'] = { link = 'Type' } },
  { ['TSInclude'] = { link = 'Include' } },
  { ['TSException'] = { link = 'Exception' } },
  { ['TSKeyword'] = { link = 'Keyword' } },
  { ['TSKeywordReturn'] = { link = 'Keyword' } },
  { ['TSKeywordOperator'] = { link = 'Keyword' } },
  { ['TSKeywordFunction'] = { link = 'Keyword' } },
  { ['TSFunction'] = { link = 'Function' } },
  { ['TSFuncBuiltin'] = { link = 'Function' } },
  { ['TSMethod'] = { link = 'Function' } },
  { ['TSFuncMacro'] = { link = 'Function' } },
  { ['TSConditional'] = { link = 'Conditional' } },
  { ['TSRepeat'] = { link = 'Repeat' } },
  { ['TSOperator'] = { link = 'Operator' } },
  { ['TSPreProc'] = { link = 'PreProc' } },
  { ['TSStorageClass'] = { link = 'StorageClass' } },
  { ['TSStructure'] = { link = 'Structure' } },
  { ['TSTypeDefinition'] = { link = 'Typedef' } },
  { ['TSDefine'] = { link = 'Define' } },
  { ['TSNote'] = { link = 'Comment' } },
  { ['TSNone'] = { fg = c.light_gray, bg = 'NONE' } },
  { ['TSTodo'] = { link = 'Todo' } },
  { ['TSDebug'] = { link = 'Debug' } },
  { ['TSDanger'] = { link = 'Error' } },
  { ['TSTitle'] = { link = 'Title' } },
  { ['TSLabel'] = { link = 'Label' } },
  { ['TSPunctDelimiter'] = { link = 'Delimiter' } },
  { ['TSTagDelimiter'] = { fg = c.red, bg = 'NONE' } },
  { ['TSPunctBracket'] = { link = 'Delimiter' } },
  { ['TSPunctSpecial'] = { link = 'Delimiter' } },
  { ['TSTag'] = { link = 'Tag' } },
  { ['TSStrong'] = { link = 'Bold' } },
  { ['TSEmphasis'] = { link = 'Italic' } },
  { ['TSUnderline'] = { link = 'Underline' } },
  { ['TSStrike'] = { fg = 'NONE', bg = 'NONE', strikethrough = true } },
  { ['TSStringSpecial'] = { fg = c.fg, bg = 'NONE' } },
  { ['TSEnvironmentName'] = { fg = c.cyan, bg = 'NONE' } },
  { ['TSVariableBuiltin'] = { fg = c.yellow, bg = 'NONE' } },
  { ['TSConstMacro'] = { fg = c.orange, bg = 'NONE' } },
  { ['TSTypeBuiltin'] = { fg = c.orange, bg = 'NONE' } },
  { ['TSAnnotation'] = { fg = c.cyan, bg = 'NONE' } },
  { ['TSNamespace'] = { fg = c.cyan, bg = 'NONE' } },
  { ['TSSymbol'] = { fg = c.fg, bg = 'NONE' } },
  { ['TSField'] = { fg = c.red, bg = 'NONE' } },
  { ['TSProperty'] = { fg = c.red, bg = 'NONE' } },
  { ['TSParameter'] = { fg = c.red, bg = 'NONE' } },
  { ['TSParameterReference'] = { fg = c.red, bg = 'NONE' } },
  { ['TSAttribute'] = { fg = c.red, bg = 'NONE' } },
  { ['TSText'] = { fg = c.alt_fg, bg = 'NONE' } },
  { ['TSTagAttribute'] = { fg = c.orange, bg = 'NONE', italic = true } },
  { ['TSError'] = { fg = c.error, bg = 'NONE' } },
  { ['TSWarning'] = { fg = c.warn, bg = 'NONE' } },
  { ['TSQueryLinterError'] = { fg = c.error, bg = 'NONE' } },
  { ['TSURI'] = { fg = c.cyan, bg = 'NONE', underline = true } },
  { ['TSMath'] = { fg = c.yellow, bg = 'NONE' } },
  { ['TSLiteral'] = { fg = c.orange, bg = 'NONE' } },
  { ['@comment'] = { link = 'Comment' } },
  { ['@variable'] = { link = 'Variable' } },
  { ['@string'] = { link = 'String' } },
  { ['@string.regex'] = { link = 'String' } },
  { ['@string.escape'] = { link = 'String' } },
  { ['@character'] = { link = 'String' } },
  { ['@character.special'] = { link = 'SpecialChar' } },
  { ['@number'] = { link = 'Number' } },
  { ['@float'] = { link = 'Float' } },
  { ['@boolean'] = { link = 'Boolean' } },
  { ['@constant'] = { link = 'Constant' } },
  { ['@constant.builtin'] = { link = 'Constant' } },
  { ['@constructor'] = { link = 'Type' } },
  { ['@type'] = { link = 'Type' } },
  { ['@include'] = { link = 'Include' } },
  { ['@exception'] = { link = 'Exception' } },
  { ['@keyword'] = { link = 'Keyword' } },
  { ['@keyword.return'] = { link = 'Keyword' } },
  { ['@keyword.operator'] = { link = 'Keyword' } },
  { ['@keyword.function'] = { link = 'Keyword' } },
  { ['@function'] = { link = 'Function' } },
  { ['@function.builtin'] = { link = 'Function' } },
  { ['@method'] = { link = 'Function' } },
  { ['@function.macro'] = { link = 'Function' } },
  { ['@conditional'] = { link = 'Conditional' } },
  { ['@repeat'] = { link = 'Repeat' } },
  { ['@operator'] = { link = 'Operator' } },
  { ['@preproc'] = { link = 'PreProc' } },
  { ['@storageclass'] = { link = 'StorageClass' } },
  { ['@structure'] = { link = 'Structure' } },
  { ['@type.definition'] = { link = 'Typedef' } },
  { ['@define'] = { link = 'Define' } },
  { ['@note'] = { link = 'Comment' } },
  { ['@none'] = { fg = c.light_gray, bg = 'NONE' } },
  { ['@todo'] = { link = 'Todo' } },
  { ['@debug'] = { link = 'Debug' } },
  { ['@danger'] = { link = 'Error' } },
  { ['@title'] = { link = 'Title' } },
  { ['@label'] = { link = 'Label' } },
  { ['@punctuation.delimiter'] = { link = 'Delimiter' } },
  { ['@tag.delimiter'] = { fg = c.red, bg = 'NONE' } },
  { ['@punctuation.bracket'] = { link = 'Delimiter' } },
  { ['@punctuation.special'] = { link = 'Delimiter' } },
  { ['@tag'] = { link = 'Tag' } },
  { ['@strong'] = { link = 'Bold' } },
  { ['@emphasis'] = { link = 'Italic' } },
  { ['@underline'] = { link = 'Underline' } },
  { ['@strike'] = { fg = 'NONE', bg = 'NONE', strikethrough = true } },
  { ['@string.special'] = { fg = c.fg, bg = 'NONE' } },
  { ['@environment.name'] = { fg = c.cyan, bg = 'NONE' } },
  { ['@variable.builtin'] = { fg = c.yellow, bg = 'NONE' } },
  { ['@const.macro'] = { fg = c.orange, bg = 'NONE' } },
  { ['@type.builtin'] = { fg = c.orange, bg = 'NONE' } },
  { ['@annotation'] = { fg = c.cyan, bg = 'NONE' } },
  { ['@namespace'] = { fg = c.cyan, bg = 'NONE' } },
  { ['@symbol'] = { fg = c.fg, bg = 'NONE' } },
  { ['@field'] = { fg = c.red, bg = 'NONE' } },
  { ['@property'] = { fg = c.red, bg = 'NONE' } },
  { ['@parameter'] = { fg = c.red, bg = 'NONE' } },
  { ['@parameter.reference'] = { fg = c.red, bg = 'NONE' } },
  { ['@attribute'] = { fg = c.red, bg = 'NONE' } },
  { ['@text'] = { fg = c.alt_fg, bg = 'NONE' } },
  { ['@tag.attribute'] = { fg = c.orange, bg = 'NONE', italic = true } },
  { ['@error'] = { fg = c.error, bg = 'NONE' } },
  { ['@warning'] = { fg = c.warn, bg = 'NONE' } },
  { ['@query.linter.error'] = { fg = c.error, bg = 'NONE' } },
  { ['@uri'] = { fg = c.cyan, bg = 'NONE', underline = true } },
  { ['@math'] = { fg = c.yellow, bg = 'NONE' } },

  -- LspSemanticTokens
  { ['@lsp.type.namespace'] = { link = '@namespace' } },
  { ['@lsp.type.type'] = { link = '@type' } },
  { ['@lsp.type.class'] = { link = '@type' } },
  { ['@lsp.type.enum'] = { link = '@type' } },
  { ['@lsp.type.interface'] = { link = '@type' } },
  { ['@lsp.type.struct'] = { link = '@structure' } },
  { ['@lsp.type.typeParameter'] = { link = 'TypeDef' } },
  { ['@lsp.type.variable'] = { link = '@variable' } },
  { ['@lsp.type.property'] = { link = '@property' } },
  { ['@lsp.type.enumMember'] = { link = '@constant' } },
  { ['@lsp.type.function'] = { link = '@function' } },
  { ['@lsp.type.method'] = { link = '@method' } },
  { ['@lsp.type.macro'] = { link = '@macro' } },
  { ['@lsp.type.decorator'] = { link = '@function' } },
  { ['@lsp.typemod.variable.readonly'] = { link = '@constant' } },
  { ['@lsp.typemod.method.defaultLibrary'] = { link = '@function.builtin' } },
  { ['@lsp.typemod.function.defaultLibrary'] = { link = '@function.builtin' } },
  { ['@lsp.typemod.variable.defaultLibrary'] = { link = '@variable.builtin' } },
  { ['@lsp.mod.deprecated'] = { fg = 'NONE', bg = 'NONE', strikethrough = true } },

  -- Whichkey
  { ['WhichKey'] = { fg = c.purple, bg = 'NONE' } },
  { ['WhichKeySeperator'] = { fg = c.yellow, bg = 'NONE' } },
  { ['WhichKeyGroup'] = { fg = c.red, bg = 'NONE' } },
  { ['WhichKeyDesc'] = { fg = c.fg, bg = 'NONE' } },
  { ['WhichKeyFloat'] = { fg = 'NONE', bg = c.alt_bg } },

  -- Git
  { ['SignAdd'] = { fg = c.sign_add, bg = 'NONE' } },
  { ['SignChange'] = { fg = c.sign_change, bg = 'NONE' } },
  { ['SignDelete'] = { fg = c.sign_delete, bg = 'NONE' } },
  { ['GitSignsAdd'] = { fg = c.sign_add, bg = 'NONE' } },
  { ['GitSignsChange'] = { fg = c.sign_change, bg = 'NONE' } },
  { ['GitSignsDelete'] = { fg = c.sign_delete, bg = 'NONE' } },

  -- LSP
  { ['DiagnosticHint'] = { fg = c.hint, bg = 'NONE' } },
  { ['DiagnosticInfo'] = { fg = c.info, bg = 'NONE' } },
  { ['DiagnosticWarn'] = { fg = c.warn, bg = 'NONE' } },
  { ['DiagnosticError'] = { fg = c.error, bg = 'NONE' } },
  { ['DiagnosticOther'] = { fg = c.ui_purple, bg = 'NONE' } },
  { ['DiagnosticSignHint'] = { link = 'DiagnosticHint' } },
  { ['DiagnosticSignInfo'] = { link = 'DiagnosticInfo' } },
  { ['DiagnosticSignWarn'] = { link = 'DiagnosticWarn' } },
  { ['DiagnosticSignError'] = { link = 'DiagnosticError' } },
  { ['DiagnosticSignOther'] = { link = 'DiagnosticOther' } },
  { ['DiagnosticSignWarning'] = { link = 'DiagnosticWarn' } },
  { ['DiagnosticFloatingHint'] = { link = 'DiagnosticHint' } },
  { ['DiagnosticFloatingInfo'] = { link = 'DiagnosticInfo' } },
  { ['DiagnosticFloatingWarn'] = { link = 'DiagnosticWarn' } },
  { ['DiagnosticFloatingError'] = { link = 'DiagnosticError' } },
  { ['DiagnosticUnderlineHint'] = { fg = 'NONE', bg = 'NONE', sp = c.hint, undercurl = true } },
  { ['DiagnosticUnderlineInfo'] = { fg = 'NONE', bg = 'NONE', sp = c.info, undercurl = true } },
  { ['DiagnosticUnderlineWarn'] = { fg = 'NONE', bg = 'NONE', sp = c.warn, undercurl = true } },
  { ['DiagnosticUnderlineError'] = { fg = 'NONE', bg = 'NONE', sp = c.error, undercurl = true } },
  { ['DiagnosticSignInformation'] = { link = 'DiagnosticInfo' } },
  { ['DiagnosticVirtualTextHint'] = { fg = c.hint, bg = c.hint_bg } },
  { ['DiagnosticVirtualTextInfo'] = { fg = c.info, bg = c.info_bg } },
  { ['DiagnosticVirtualTextWarn'] = { fg = c.warn, bg = c.warn_bg } },
  { ['DiagnosticVirtualTextError'] = { fg = c.error, bg = c.error_bg } },
  { ['LspDiagnosticsError'] = { fg = c.error, bg = 'NONE' } },
  { ['LspDiagnosticsWarning'] = { fg = c.warn, bg = 'NONE' } },
  { ['LspDiagnosticsInfo'] = { fg = c.info, bg = 'NONE' } },
  { ['LspDiagnosticsInformation'] = { link = 'LspDiagnosticsInfo' } },
  { ['LspDiagnosticsHint'] = { fg = c.hint, bg = 'NONE' } },
  { ['LspDiagnosticsDefaultError'] = { link = 'LspDiagnosticsError' } },
  { ['LspDiagnosticsDefaultWarning'] = { link = 'LspDiagnosticsWarning' } },
  { ['LspDiagnosticsDefaultInformation'] = { link = 'LspDiagnosticsInfo' } },
  { ['LspDiagnosticsDefaultInfo'] = { link = 'LspDiagnosticsInfo' } },
  { ['LspDiagnosticsDefaultHint'] = { link = 'LspDiagnosticsHint' } },
  { ['LspDiagnosticsVirtualTextError'] = { link = 'DiagnosticVirtualTextError' } },
  { ['LspDiagnosticsVirtualTextWarning'] = { link = 'DiagnosticVirtualTextWarn' } },
  { ['LspDiagnosticsVirtualTextInformation'] = { link = 'DiagnosticVirtualTextInfo' } },
  { ['LspDiagnosticsVirtualTextInfo'] = { link = 'DiagnosticVirtualTextInfo' } },
  { ['LspDiagnosticsVirtualTextHint'] = { link = 'DiagnosticVirtualTextHint' } },
  { ['LspDiagnosticsFloatingError'] = { link = 'LspDiagnosticsError' } },
  { ['LspDiagnosticsFloatingWarning'] = { link = 'LspDiagnosticsWarning' } },
  { ['LspDiagnosticsFloatingInformation'] = { link = 'LspDiagnosticsInfo' } },
  { ['LspDiagnosticsFloatingInfo'] = { link = 'LspDiagnosticsInfo' } },
  { ['LspDiagnosticsFloatingHint'] = { link = 'LspDiagnosticsHint' } },
  { ['LspDiagnosticsSignError'] = { link = 'LspDiagnosticsError' } },
  { ['LspDiagnosticsSignWarning'] = { link = 'LspDiagnosticsWarning' } },
  { ['LspDiagnosticsSignInformation'] = { link = 'LspDiagnosticsInfo' } },
  { ['LspDiagnosticsSignInfo'] = { link = 'LspDiagnosticsInfo' } },
  { ['LspDiagnosticsSignHint'] = { link = 'LspDiagnosticsHint' } },
  { ['NvimTreeLspDiagnosticsError'] = { link = 'LspDiagnosticsError' } },
  { ['NvimTreeLspDiagnosticsWarning'] = { link = 'LspDiagnosticsWarning' } },
  { ['NvimTreeLspDiagnosticsInformation'] = { link = 'LspDiagnosticsInfo' } },
  { ['NvimTreeLspDiagnosticsInfo'] = { link = 'LspDiagnosticsInfo' } },
  { ['NvimTreeLspDiagnosticsHint'] = { link = 'LspDiagnosticsHint' } },
  { ['LspDiagnosticsUnderlineError'] = { link = 'DiagnosticUnderlineError' } },
  { ['LspDiagnosticsUnderlineWarning'] = { link = 'DiagnosticUnderlineWarn' } },
  { ['LspDiagnosticsUnderlineInformation'] = { link = 'DiagnosticUnderlineInfo' } },
  { ['LspDiagnosticsUnderlineInfo'] = { link = 'DiagnosticUnderlineInfo' } },
  { ['LspDiagnosticsUnderlineHint'] = { link = 'DiagnosticUnderlineHint' } },
  { ['LspReferenceRead'] = { fg = 'NONE', bg = c.reference } },
  { ['LspReferenceText'] = { fg = 'NONE', bg = c.reference } },
  { ['LspReferenceWrite'] = { fg = 'NONE', bg = c.reference } },
  { ['LspCodeLens'] = { fg = c.context, bg = 'NONE', italic = true } },
  { ['LspCodeLensSeparator'] = { fg = c.context, bg = 'NONE', italic = true } },

  -- Quickscope
  { ['QuickScopePrimary'] = { fg = '#ff007c', bg = 'NONE', underline = true } },
  { ['QuickScopeSecondary'] = { fg = '#00dfff', bg = 'NONE', underline = true } },

  -- Telescope
  { ['TelescopeSelection'] = { fg = 'NONE', bg = c.ui2_blue } },
  { ['TelescopeSelectionCaret'] = { fg = c.red, bg = c.ui2_blue } },
  { ['TelescopeMatching'] = { fg = c.yellow, bg = 'NONE', bold = true, italic = true } },
  { ['TelescopeBorder'] = { fg = c.alt_fg, bg = 'NONE' } },
  { ['TelescopeNormal'] = { fg = c.light_gray, bg = c.alt_bg } },
  { ['TelescopePromptTitle'] = { fg = c.orange, bg = 'NONE' } },
  { ['TelescopePromptPrefix'] = { fg = c.cyan, bg = 'NONE' } },
  { ['TelescopeResultsTitle'] = { fg = c.orange, bg = 'NONE' } },
  { ['TelescopePreviewTitle'] = { fg = c.orange, bg = 'NONE' } },
  { ['TelescopePromptCounter'] = { fg = c.red, bg = 'NONE' } },
  { ['TelescopePreviewHyphen'] = { fg = c.red, bg = 'NONE' } },

  -- NvimTree
  { ['NvimTreeFolderIcon'] = { fg = c.fg, bg = 'NONE' } },
  { ['NvimTreeIndentMarker'] = { fg = c.light_gray, bg = 'NONE' } },
  { ['NvimTreeNormal'] = { fg = c.fg, bg = c.alt_bg } },
  { ['NvimTreeVertSplit'] = { fg = c.alt_bg, bg = c.alt_bg } },
  { ['NvimTreeFolderName'] = { fg = c.fg, bg = 'NONE' } },
  { ['NvimTreeOpenedFolderName'] = { fg = c.fg, bg = 'NONE', bold = true, italic = true } },
  { ['NvimTreeEmptyFolderName'] = { fg = c.gray, bg = 'NONE', italic = true } },
  { ['NvimTreeGitIgnored'] = { fg = c.gray, bg = 'NONE', italic = true } },
  { ['NvimTreeImageFile'] = { fg = c.light_gray, bg = 'NONE' } },
  { ['NvimTreeSpecialFile'] = { fg = c.orange, bg = 'NONE' } },
  { ['NvimTreeEndOfBuffer'] = { fg = c.alt_bg, bg = 'NONE' } },
  { ['NvimTreeCursorLine'] = { fg = 'NONE', bg = c.dark_gray } },
  { ['NvimTreeGitStaged'] = { fg = c.sign_add_alt, bg = 'NONE' } },
  { ['NvimTreeGitNew'] = { fg = c.sign_add_alt, bg = 'NONE' } },
  { ['NvimTreeGitRenamed'] = { fg = c.sign_add_alt, bg = 'NONE' } },
  { ['NvimTreeGitDeleted'] = { fg = c.sign_delete, bg = 'NONE' } },
  { ['NvimTreeGitMerge'] = { fg = c.sign_change_alt, bg = 'NONE' } },
  { ['NvimTreeGitDirty'] = { fg = c.sign_change_alt, bg = 'NONE' } },
  { ['NvimTreeSymlink'] = { fg = c.cyan, bg = 'NONE' } },
  { ['NvimTreeRootFolder'] = { fg = c.fg, bg = 'NONE', bold = true } },
  { ['NvimTreeExecFile'] = { fg = '#9FBA89', bg = 'NONE' } },

  -- NeoTree
  { ['NeoTreeFolderIcon'] = { fg = c.fg, bg = 'NONE' } },
  { ['NeoTreeIndentMarker'] = { fg = c.gray, bg = 'NONE' } },
  { ['NeoTreeNormal'] = { fg = c.fg, bg = c.alt_bg } },
  { ['NeoTreeVertSplit'] = { fg = c.alt_bg, bg = c.alt_bg } },
  { ['NeoTreeWinSeparator'] = { fg = c.alt_bg, bg = c.alt_bg } },
  { ['NeoTreeDirectoryName'] = { fg = c.fg, bg = 'NONE' } },
  { ['NeoTreeDirectoryIcon'] = { fg = c.fg, bg = 'NONE' } },
  { ['NeoTreeFileName'] = { fg = c.light_gray, bg = 'NONE' } },
  { ['NeoTreeOpenedFolderName'] = { fg = c.fg, bg = 'NONE', bold = true, italic = true } },
  { ['NeoTreeEmptyFolderName'] = { fg = c.gray, bg = 'NONE', italic = true } },
  { ['NeoTreeGitIgnored'] = { fg = c.gray, bg = 'NONE', italic = true } },
  { ['NeoTreeDotfile'] = { fg = c.gray, bg = 'NONE', italic = true } },
  { ['NeoTreeHiddenByName'] = { fg = c.gray, bg = 'NONE', italic = true } },
  { ['NeoTreeEndOfBuffer'] = { fg = c.alt_bg, bg = 'NONE' } },
  { ['NeoTreeCursorLine'] = { fg = 'NONE', bg = c.dark_gray } },
  { ['NeoTreeGitStaged'] = { fg = c.sign_add_alt, bg = 'NONE' } },
  { ['NeoTreeGitUntracked'] = { fg = c.sign_add_alt, bg = 'NONE' } },
  { ['NeoTreeGitDeleted'] = { fg = c.sign_delete, bg = 'NONE' } },
  { ['NeoTreeGitModified'] = { fg = c.sign_change_alt, bg = 'NONE' } },
  { ['NeoTreeSymbolicLinkTarget'] = { fg = c.cyan, bg = 'NONE' } },
  { ['NeoTreeRootName'] = { fg = c.fg, bg = 'NONE', bold = true } },
  { ['NeoTreeTitleBar'] = { fg = c.dark_gray, bg = c.fg, bold = true } },

  -- Buffer
  { ['BufferCurrent'] = { fg = c.fg, bg = c.bg } },
  { ['BufferCurrentIndex'] = { fg = c.fg, bg = c.bg } },
  { ['BufferCurrentMod'] = { fg = c.info, bg = c.bg } },
  { ['BufferCurrentSign'] = { fg = c.hint, bg = c.bg } },
  { ['BufferCurrentTarget'] = { fg = c.red, bg = c.bg, bold = true } },
  { ['BufferVisible'] = { fg = c.fg, bg = c.bg } },
  { ['BufferVisibleIndex'] = { fg = c.fg, bg = c.bg } },
  { ['BufferVisibleMod'] = { fg = c.info, bg = c.bg } },
  { ['BufferVisibleSign'] = { fg = c.gray, bg = c.bg } },
  { ['BufferVisibleTarget'] = { fg = c.red, bg = c.bg, bold = true } },
  { ['BufferInactive'] = { fg = c.gray, bg = c.alt_bg } },
  { ['BufferInactiveIndex'] = { fg = c.gray, bg = c.alt_bg } },
  { ['BufferInactiveMod'] = { fg = c.info, bg = c.alt_bg } },
  { ['BufferInactiveSign'] = { fg = c.gray, bg = c.alt_bg } },
  { ['BufferInactiveTarget'] = { fg = c.red, bg = c.alt_bg, bold = true } },

  -- StatusLine
  { ['StatusLine'] = { fg = c.context, bg = c.bg } },
  { ['StatusLineNC'] = { fg = c.line, bg = c.bg } },
  { ['StatusLineSeparator'] = { fg = c.line, bg = 'NONE' } },
  { ['StatusLineTerm'] = { fg = c.line, bg = 'NONE' } },
  { ['StatusLineTermNC'] = { fg = c.line, bg = 'NONE' } },

  -- IndentBlankline
  { ['IndentBlanklineContextChar'] = { fg = c.context, bg = 'NONE' } },
  { ['IndentBlanklineContextStart'] = { fg = 'NONE', bg = 'NONE', underline = true } },
  { ['IndentBlanklineChar'] = { fg = c.gray, bg = 'NONE' } },

  -- Cmp
  { ['CmpItemAbbrDeprecated'] = { fg = c.gray, bg = 'NONE', strikethrough = true } },
  { ['CmpItemAbbrMatch'] = { fg = c.ui3_blue, bg = 'NONE' } },
  { ['CmpItemAbbrMatchFuzzy'] = { fg = c.ui3_blue, bg = 'NONE' } },
  { ['CmpItemKindFunction'] = { fg = c.cyan, bg = 'NONE' } },
  { ['CmpItemKindMethod'] = { fg = c.cyan, bg = 'NONE' } },
  { ['CmpItemKindConstructor'] = { fg = c.yellow, bg = 'NONE' } },
  { ['CmpItemKindClass'] = { fg = c.yellow, bg = 'NONE' } },
  { ['CmpItemKindEnum'] = { fg = c.yellow, bg = 'NONE' } },
  { ['CmpItemKindEvent'] = { fg = c.red, bg = 'NONE' } },
  { ['CmpItemKindInterface'] = { fg = c.yellow, bg = 'NONE' } },
  { ['CmpItemKindStruct'] = { fg = c.yellow, bg = 'NONE' } },
  { ['CmpItemKindVariable'] = { fg = c.red, bg = 'NONE' } },
  { ['CmpItemKindField'] = { fg = c.red, bg = 'NONE' } },
  { ['CmpItemKindProperty'] = { fg = c.red, bg = 'NONE' } },
  { ['CmpItemKindEnumMember'] = { fg = c.orange, bg = 'NONE' } },
  { ['CmpItemKindConstant'] = { fg = c.orange, bg = 'NONE' } },
  { ['CmpItemKindKeyword'] = { fg = c.purple, bg = 'NONE' } },
  { ['CmpItemKindModule'] = { fg = c.yelloworange, bg = 'NONE' } },
  { ['CmpItemKindValue'] = { fg = c.fg, bg = 'NONE' } },
  { ['CmpItemKindUnit'] = { fg = c.fg, bg = 'NONE' } },
  { ['CmpItemKindText'] = { fg = c.fg, bg = 'NONE' } },
  { ['CmpItemKindSnippet'] = { fg = c.purple, bg = 'NONE' } },
  { ['CmpItemKindFile'] = { fg = c.fg, bg = 'NONE' } },
  { ['CmpItemKindFolder'] = { fg = c.fg, bg = 'NONE' } },
  { ['CmpItemKindColor'] = { fg = c.fg, bg = 'NONE' } },
  { ['CmpItemKindReference'] = { fg = c.fg, bg = 'NONE' } },
  { ['CmpItemKindOperator'] = { fg = c.fg, bg = 'NONE' } },
  { ['CmpItemKindTypeParameter'] = { fg = c.red, bg = 'NONE' } },

  -- Navic
  { ['NavicIconsFile'] = { fg = c.fg, bg = 'NONE' } },
  { ['NavicIconsModule'] = { fg = c.yelloworange, bg = 'NONE' } },
  { ['NavicIconsNamespace'] = { fg = c.fg, bg = 'NONE' } },
  { ['NavicIconsPackage'] = { fg = c.fg, bg = 'NONE' } },
  { ['NavicIconsClass'] = { fg = c.yellow, bg = 'NONE' } },
  { ['NavicIconsMethod'] = { fg = c.cyan, bg = 'NONE' } },
  { ['NavicIconsProperty'] = { fg = c.red, bg = 'NONE' } },
  { ['NavicIconsField'] = { fg = c.red, bg = 'NONE' } },
  { ['NavicIconsConstructor'] = { fg = c.yellow, bg = 'NONE' } },
  { ['NavicIconsEnum'] = { fg = c.orange, bg = 'NONE' } },
  { ['NavicIconsInterface'] = { fg = c.yellow, bg = 'NONE' } },
  { ['NavicIconsFunction'] = { fg = c.cyan, bg = 'NONE' } },
  { ['NavicIconsVariable'] = { fg = c.red, bg = 'NONE' } },
  { ['NavicIconsConstant'] = { fg = c.orange, bg = 'NONE' } },
  { ['NavicIconsString'] = { fg = c.yelloworange, bg = 'NONE' } },
  { ['NavicIconsNumber'] = { fg = c.orange, bg = 'NONE' } },
  { ['NavicIconsBoolean'] = { fg = c.orange, bg = 'NONE' } },
  { ['NavicIconsArray'] = { fg = c.yellow, bg = 'NONE' } },
  { ['NavicIconsObject'] = { fg = c.yellow, bg = 'NONE' } },
  { ['NavicIconsKey'] = { fg = c.purple, bg = 'NONE' } },
  { ['NavicIconsKeyword'] = { fg = c.purple, bg = 'NONE' } },
  { ['NavicIconsNull'] = { fg = c.orange, bg = 'NONE' } },
  { ['NavicIconsEnumMember'] = { fg = c.orange, bg = 'NONE' } },
  { ['NavicIconsStruct'] = { fg = c.cyan, bg = 'NONE' } },
  { ['NavicIconsEvent'] = { fg = c.yellow, bg = 'NONE' } },
  { ['NavicIconsOperator'] = { fg = c.fg, bg = 'NONE' } },
  { ['NavicIconsTypeParameter'] = { fg = c.red, bg = 'NONE' } },
  { ['NavicText'] = { fg = c.fg, bg = 'NONE' } },
  { ['NavicSeparator'] = { fg = c.fg, bg = 'NONE' } },

  -- Packer
  { ['packerString'] = { fg = c.ui_orange, bg = 'NONE' } },
  { ['packerHash'] = { fg = c.ui4_blue, bg = 'NONE' } },
  { ['packerOutput'] = { fg = c.ui_purple, bg = 'NONE' } },
  { ['packerRelDate'] = { fg = c.gray, bg = 'NONE' } },
  { ['packerSuccess'] = { fg = c.success_green, bg = 'NONE' } },
  { ['packerStatusSuccess'] = { fg = c.ui4_blue, bg = 'NONE' } },

  -- SymbolOutline
  { ['SymbolsOutlineConnector'] = { fg = c.gray, bg = 'NONE' } },
  { ['FocusedSymbol'] = { fg = 'NONE', bg = '#36383F' } },

  -- Notify
  { ['NotifyERRORBorder'] = { fg = '#8A1F1F', bg = 'NONE' } },
  { ['NotifyWARNBorder'] = { fg = '#79491D', bg = 'NONE' } },
  { ['NotifyINFOBorder'] = { fg = c.ui_blue, bg = 'NONE' } },
  { ['NotifyDEBUGBorder'] = { fg = c.gray, bg = 'NONE' } },
  { ['NotifyTRACEBorder'] = { fg = '#4F3552', bg = 'NONE' } },
  { ['NotifyERRORIcon'] = { fg = c.error, bg = 'NONE' } },
  { ['NotifyWARNIcon'] = { fg = c.warn, bg = 'NONE' } },
  { ['NotifyINFOIcon'] = { fg = c.ui4_blue, bg = 'NONE' } },
  { ['NotifyDEBUGIcon'] = { fg = c.gray, bg = 'NONE' } },
  { ['NotifyTRACEIcon'] = { fg = c.ui_purple, bg = 'NONE' } },
  { ['NotifyERRORTitle'] = { fg = c.error, bg = 'NONE' } },
  { ['NotifyWARNTitle'] = { fg = c.warn, bg = 'NONE' } },
  { ['NotifyINFOTitle'] = { fg = c.ui4_blue, bg = 'NONE' } },
  { ['NotifyDEBUGTitle'] = { fg = c.gray, bg = 'NONE' } },
  { ['NotifyTRACETitle'] = { fg = c.ui_purple, bg = 'NONE' } },

  -- Hop
  { ['HopNextKey'] = { fg = '#4ae0ff', bg = 'NONE' } },
  { ['HopNextKey1'] = { fg = '#d44eed', bg = 'NONE' } },
  { ['HopNextKey2'] = { fg = '#b42ecd', bg = 'NONE' } },
  { ['HopUnmatched'] = { fg = c.gray, bg = 'NONE' } },
  { ['HopPreview'] = { fg = '#c7ba7d', bg = 'NONE' } },

  -- Crates
  { ['CratesNvimLoading'] = { fg = c.hint, bg = 'NONE' } },
  { ['CratesNvimVersion'] = { fg = c.hint, bg = 'NONE' } },
}

function M.set_highlights()
  for _, value in ipairs(highlights) do
    local name = next(value)
    api.nvim_set_hl(0, name, value[name])
  end
end

return M
