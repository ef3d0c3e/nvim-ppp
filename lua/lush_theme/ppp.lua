local lush = require("lush")
local hsl = lush.hsl
local hsluv = lush.hsluv

local colors = {
	bg = hsl("#0f0f15"),
	fg = hsl("#e4f0fb"),
}
-- Line number & status col
colors.linenr = {
	bg = colors.bg.de(-10).li(-20),
	fg = colors.fg.de(-10).li(-65),
}

-- Statusline (Lualine)
colors.line = {
	bg = hsl("#14161b"),
	fg = hsl("#e0e2ea"),
	accent = hsl("#c2437f"),

}

-- Modes
colors.modes = {
	-- NOTE: Cursorline colors is determined by `hi CursorLine`
	normal = hsl("#7fb070"),
	insert = hsl("#29393f"),
	visual = hsl("#2e243e"),
	replace =hsl("#df8040"),


	-- Cursorline colors
	get_cursorline = function(color)
		return color.de(-30) -- temp
	end,

	get_line = function(color)
		return color.de(-20).li(15)
	end,
}

-- Dignostics
colors.diagnostics = {
	hint = hsl("#a6dbff"),
	warn = hsl("#fce094"),
	error = hsl("#ffb0b9"),
	info = hsl("#af7caf"),
	ok = hsl("#afccaf"),

	-- Signcolumn
	get_sign = function(color)
		return color.de(10).li(-10)
	end,

	-- Lualine
	get_line = function(color)
		return color.li(-15)
	end,

	-- Diagnostic underline color
	get_underline = function(color)
		return color.li(-25).de(-50)
	end,

	-- Virtual text
	get_virtual = function(color)
		return color.li(-25).ro(5).de(20)
	end,
}

-- Highlight
colors.hl = {
	base = hsl("#f0f0ff"),
	type = hsl("#aeb5d5"),
	namespace = hsl("#4e5575"),
	variable = hsl("#ba9cba"),
	fn = hsl("#5ee4c7"),
	macro = hsl("#398e80"),
	import = hsl("#CE2C5D"),
	operator = hsl("#e4845e"),

	literals = {
		string = hsl("#7F7862"),
		special = hsl("#d63f85"),
		char = hsl("#7f6268"),
		number = hsl("#78627f"),
	},

	comment = {
		text = hsl("#3e3b4A"),
		todo = hsl("#3f77A0"),
	},
}

---@diagnostic disable: undefined-global
return lush(function(injected_functions)
	local sym = injected_functions.sym
	return {
		-- UI
		Normal                                 { bg=colors.bg, fg=colors.fg, },
		WinBar                                 { Normal, },
		EdgyWinBar                             { Normal },
		WinBarNC                               { Normal, },
		CursorLine                             { bg=colors.bg.li(5).de(30), }, -- CursorLine     xxx guibg=#303340

		NormalFloat                            { bg = colors.bg.de(5), },
		DapUIFloatNormal                       { NormalFloat },
		NoicePopup                             { NormalFloat },
		NoiceSplit                             { NormalFloat },

		FloatBorder                            { bg = colors.bg.de(20), },
		WhichKeyBorder                         { FloatBorder },
		NoiceSplitBorder                       { FloatBorder },
		NoicePopupmenuBorder                   { FloatBorder },
		NoicePopupBorder                       { FloatBorder },

		-- Decorations
		WinSeparator                           { fg=colors.bg.de(10).li(-20) },
		Edgycolors                             { WinSeparator },

		-- Column
		LineNr                                 { bg = colors.linenr.bg, fg=colors.linenr.fg },
		SignColumn                             { LineNr, },
		CursorLineNr                           { bg = colors.linenr.bg, fg = colors.linenr.fg.li(25), },
		WarningMsg                             { fg = colors.diagnostics.warn },

		-- {{{ Diagnostics
		TroubleSignInformation				   { fg=colors.diagnostics.get_sign(colors.diagnostics.info) },
		DiagnosticSignOk					   { fg=colors.diagnostics.get_sign(colors.diagnostics.ok), bg = colors.linenr.bg},
		DiagnosticUnnecessary                  { fg=colors.diagnostics.ok.li(20).de(15) },


		-- Error
		DiagnosticSignError					   { fg=colors.diagnostics.get_sign(colors.diagnostics.error), bg=colors.linenr.bg },
		DiagnosticUnderlineError			   { sp=colors.diagnostics.get_underline(colors.diagnostics.error), gui="undercurl" },
		TroubleSignError					   { fg=colors.diagnostics.get_sign(colors.diagnostics.error) },
		DiagnosticError                        { fg=colors.diagnostics.error },
		DiagnosticFloatingError                { DiagnosticError },
		DiagnosticErrorBorder                  { DiagnosticError },
		TroubleError                           { DiagnosticError },
		DiagnosticVirtualTextError             { fg=colors.diagnostics.get_virtual(colors.diagnostics.error) },
		NvimDapVirtualTextError                { DiagnosticVirtualTextError },
		NoiceFormatLevelError                  { DiagnosticVirtualTextError },

		-- Info
		DiagnosticSignInfo					   { fg=colors.diagnostics.get_sign(colors.diagnostics.info), bg=colors.linenr.bg },
		DiagnosticUnderlineInfo			   	   { sp=colors.diagnostics.get_underline(colors.diagnostics.info), gui="undercurl" },
		DiagnosticInfo                         { fg=colors.diagnostics.info },
		DiagnosticFloatingInfo                 { DiagnosticInfo },
		DiagnosticInfoBorder                   { DiagnosticInfo },
		TroubleInformation                     { DiagnosticInfo },
		DiagnosticVirtualTextInfo              { fg=colors.diagnostics.get_virtual(colors.diagnostics.info) },

		-- Warning
		DiagnosticSignWarn					   { fg=colors.diagnostics.get_sign(colors.diagnostics.warn), bg=colors.bg.de(-10).li(-20) },
		DiagnosticUnderlineWarn				   { sp=colors.diagnostics.get_underline(colors.diagnostics.warn), gui="undercurl" },
		TroubleSignWarning					   { fg=colors.diagnostics.get_sign(colors.diagnostics.warn) },
		DiagnosticWarn                         { fg=colors.diagnostics.warn },
		DiagnosticFloatingWarn                 { DiagnosticWarn },
		DiagnosticWarnBorder                   { DiagnosticWarn },
		TroubleWarning                         { DiagnosticWarn },
		DiagnosticVirtualTextWarn              { fg=colors.diagnostics.get_virtual(colors.diagnostics.warn) },
		NvimDapVirtualTextChanged              { DiagnosticVirtualTextWarn },
		NoiceFormatLevelWarn                   { DiagnosticVirtualTextWarn },

		-- Hint
		DiagnosticSignHint					   { fg=colors.diagnostics.get_sign(colors.diagnostics.hint), bg=colors.linenr.bg},
		DiagnosticUnderlineHint				   { sp=colors.diagnostics.get_underline(colors.diagnostics.hint), gui="undercurl" },
		TroubleSignHint						   { fg=colors.diagnostics.get_sign(colors.diagnostics.hint) },
		DiagnosticHint                         { fg=colors.diagnostics.hint },
		DiagnosticFloatingHint                 { DiagnosticHint },
		DiagnosticHintBorder                   { DiagnosticHint },
		TroubleHint                            { DiagnosticHint },

		DiagnosticUnderlineOk			   	   { sp=colors.diagnostics.get_underline(colors.diagnostics.ok), gui="undercurl" },
		DiagnosticOk                           { fg="nvimlightgreen", },
		DiagnosticFloatingOk                   { DiagnosticOk },
		DiagnosticVirtualTextOk                { DiagnosticOk },
		-- }}}

		-- Lualine
		StatusLine		    			 	   { bg = hsl("#FF0000"), fg = colors.line.fg },
		LualineNormal 						   { bg = colors.line.bg, fg = colors.line.fg },
		LualineAccent 						   { bg = colors.line.accent, fg = colors.line.bg },
		LualineDiagInfo						   { fg = colors.diagnostics.get_line(colors.diagnostics.hint) },
		LualineDiagWarn						   { fg = colors.diagnostics.get_line(colors.diagnostics.warn) },
		LualineDiagError					   { fg = colors.diagnostics.get_line(colors.diagnostics.error) },

		-- IBL
		IblIndent                              { fg=colors.fg.de(10).li(-50) },
		IblWhitespace                          { IblIndent },
		IblScope                               { fg=colors.fg.de(-10).li(-40), },

		-- Type
		StorageClass                           { fg=colors.hl.type.de(25).li(-30), style="italic" },
		Type                                   { fg=colors.hl.type.li(-20).de(25), },
		sym"@keyword.type"                     { Type },
		sym"@type"                             { Type },
		sym"@type.builtin"                     { Type },
		sym"@lsp.type.class"                   { fg=colors.hl.type.li(10).de(-25) },
		sym"@lsp.type.typeParameter"           { fg=colors.hl.type.de(-15).li(15).ro(25), style="bold" },
		LspInlayHint                           { fg=colors.hl.type.li(-40), gui="italic" },


		-- Namespace
		sym"@namespace"                        { fg=colors.hl.namespace },
		sym"@lsp.type.namespace"               { sym"@namespace" },

		-- Property
		sym"@property"                         { fg=colors.hl.variable.li(-20).de(5), },
		sym"@lsp.type.property"				   { sym"@property" },

		-- Functions
		Function						       { fg = colors.hl.fn },
		sym "@function"						   { fg = colors.hl.fn },
		sym "@function.builtin"				   { fg = colors.hl.fn.de(20).li(-25) },
		sym "@function.call"				   { fg = colors.hl.fn },

		-- Macros/Preprocessor
		Include                                { fg=colors.hl.import, },
		sym "@keyword.import"                  { Include },
		PreProc                                { fg = colors.hl.macro, },
		Define                                 { PreProc },
		Macro                                  { PreProc },
		PreCondit                              { PreProc },
		sym "@keyword.directive"               { PreProc },
		sym "@constant.macro"                  { fg = colors.hl.macro.li(50) },
		sym "@function.macro"				   { fg = colors.hl.macro.li(-30).de(15) },
		sym"@lsp.type.macro" { sym"@constant.macro" },


		-- Operators
		Operator                               { fg = colors.hl.operator, },
		sym"@operator"                         { Operator },
		sym"@keyword.conditional.ternary"      { Operator },
		sym"@keyword.operator"				   { Operator },

		-- Literals
		String                                 { fg = colors.hl.literals.string, },
		sym"@string"                           { String },

		Character                              { fg = colors.hl.literals.string.ro(10).li(-15).de(-15), },
		sym"@character"                        { Character },

		Special                                { fg = colors.hl.literals.special, gui="bold" },
		SpecialChar                            { Special },
		sym"@character.special"                { Special },
		sym"@string.special"                   { Special },

		Boolean                                { fg = colors.hl.literals.bool, },
		sym"@boolean"                          { Boolean },
		Number                                 { fg = colors.hl.literals.number, },
		sym"@number"                           { Number },
		Float                                  { fg = colors.hl.literals.number.ro(20).li(-15).de(10), },
		sym"@number.float"                     { Float },
		sym"@number.double"                    { Float },

		-- Comments
		Comment                                { fg=colors.hl.comment.text, },
		sym"@lsp.type.comment"                 { fg=colors.hl.comment.text, },
		sym"@comment.documentation"            { fg=colors.hl.comment.text.li(25).de(10) },
		sym"@keyword.doxygen"                  { fg=colors.hl.comment.text.li(45).de(30), gui="bold italic" },
		sym"@comment"                          { Comment },
		sym"@comment.error"                    { DiagnosticError },
		sym"@comment.warning"                  { DiagnosticWarn },
		Todo                                   { bg=colors.hl.comment.todo },
		sym"@comment.todo"                     { Todo },
		sym"@comment.note"                     { DiagnosticInfo },
		

--@keyword.directive         ; various preprocessor directives & shebangs
--@keyword.directive.define  ; preprocessor definition directives


		--[[
@function             ; function definitions
@function.builtin     ; built-in functions
@function.call        ; function calls
@function.macro       ; preprocessor macros

@function.method      ; method definitions
@function.method.call ; method calls

@constructor          ; constructor calls and definitions
@operator             ; symbolic operators (e.g. `+` / `*`)
--]]

		sym"@keyword"                          { fg=colors.hl.base, gui="bold" },
		sym"@keyword.modifier"                 { fg=colors.hl.type.ro(50).li(-15).de(10), gui="italic" },
		sym"@keyword.function"				   { fg=colors.hl.fn.li(15).de(30) }, -- function()/end
		sym"@keyword.coroutine"				   { fg=colors.hl.fn.ro(-20).li(-15).de(30) },


		--[[
@keyword                   ; keywords not fitting into specific categories
@keyword.operator          ; operators that are English words (e.g. `and` / `or`)
@keyword.import            ; keywords for including or exporting modules (e.g. `import` / `from` in Python)
@keyword.modifier          ; keywords modifying other constructs (e.g. `const`, `static`, `public`)
@keyword.repeat            ; keywords related to loops (e.g. `for` / `while`)
@keyword.return            ; keywords like `return` and `yield`
@keyword.debug             ; keywords related to debugging
@keyword.exception         ; keywords related to exceptions (e.g. `throw` / `catch`)

@keyword.conditional         ; keywords related to conditionals (e.g. `if` / `else`)
@keyword.conditional.ternary ; ternary operator (e.g. `?` / `:`)

@keyword.directive         ; various preprocessor directives & shebangs
@keyword.directive.define  ; preprocessor definition directives
		--]]

		Constant                               { fg="#e4f0fb", }, -- Constant       xxx guifg=#e4f0fb
		sym"@constant"                         { Constant }, -- @constant      xxx links to Constant
		Delimiter                              { fg="#a6accd", }, -- Delimiter      xxx guifg=#a6accd
		sym"@punctuation"                      { Delimiter }, -- @punctuation   xxx links to Delimiter
		Keyword                                { fg="#91b4d5", }, -- Keyword        xxx guifg=#91b4d5

		sym"@parameter"                        { fg="#e4f0fb", }, -- @parameter     xxx guifg=#e4f0fb
		sym"@tag.attribute"                    { gui="italic", fg="#91b4d5", }, -- @tag.attribute xxx gui=italic guifg=#91b4d5
		sym"@punctuation.bracket"              { fg="#e4f0fb", }, -- @punctuation.bracket xxx guifg=#e4f0fb
		sym"@method"                           { fg="#5de4c7", }, -- @method        xxx guifg=#5de4c7
		sym"@constant.falsy"                   { fg="#d0679d", }, -- @constant.falsy xxx guifg=#d0679d
		sym"@import.identifier.typescript"     { fg="#add7ff", }, -- @import.identifier.typescript xxx guifg=#add7ff
		sym"@import.identifier.tsx"            { fg="#add7ff", }, -- @import.identifier.tsx xxx guifg=#add7ff
		sym"@title"                            { gui="bold", fg="#5fb3a1", }, -- @title         xxx gui=bold guifg=#5fb3a1
		sym"@text"                             { fg="#e4f0fb", }, -- @text          xxx guifg=#e4f0fb
		sym"@tag.delimiter"                    { fg="#e4f0fb", }, -- @tag.delimiter xxx guifg=#e4f0fb
		sym"@punctuation.delimiter"            { fg="#91b4d5", }, -- @punctuation.delimiter xxx guifg=#91b4d5
		sym"@constructor"                      { fg="#5de4c7", }, -- @constructor   xxx guifg=#5de4c7
		sym"@punctuation.special"              { fg="#91b4d5", }, -- @punctuation.special xxx guifg=#91b4d5
		sym"@markup.strong"                    { gui="bold", }, -- @markup.strong xxx cterm=bold gui=bold
		sym"@markup.italic"                    { gui="italic", }, -- @markup.italic xxx cterm=italic gui=italic
		sym"@markup.strikethrough"             { gui="strikethrough", }, -- @markup.strikethrough xxx cterm=strikethrough gui=strikethrough
		sym"@markup.underline"                 { gui="underline", }, -- @markup.underline xxx cterm=underline gui=underline
		sym"@variable"                         { fg=colors.hl.variable, }, -- @variable      xxx guifg=#e4f0fb
		sym"@variable.builtin"                 { fg=colors.hl.variable.li(-20).de(15) }, -- @variable.builtin xxx guifg=#add7ff
		sym"@lsp.type.selfKeyword"             { fg=colors.hl.variable.li(25).de(-15) },
		sym"@constant.builtin"                 { fg="#add7ff", }, -- @constant.builtin xxx guifg=#add7ff
		sym"@label"                            { fg="#91b4d5", }, -- @label         xxx guifg=#91b4d5

		--sym"@lsp.type.namespace" { sym"@namespace" },
		--sym"@lsp.type.type" { sym"@type" },
		--sym"@lsp.type.class" { sym"@type" },
		--sym"@lsp.type.enum" { sym"@type" },
		--sym"@lsp.type.interface" { sym"@type" },
		--sym"@lsp.type.struct" { sym"@structure" },
		--sym"@lsp.type.parameter" { sym"@parameter" },
		--sym"@lsp.type.variable" { sym"@variable" },
		--sym"@lsp.type.enumMember" { sym"@constant" },
		sym"@lsp.type.function" { sym"@function" },
		--sym"@lsp.type.method" { sym"@method" },
		sym"@lsp.type.decorator" { sym"@function" },

		SpecialKey                             { fg="#5de4c7", }, -- SpecialKey     xxx guifg=#5de4c7
		TermCursor                             { gui="reverse", }, -- TermCursor     xxx cterm=reverse gui=reverse
		GitSignsAddInline                      { TermCursor }, -- GitSignsAddInline xxx links to TermCursor
		GitSignsDeleteInline                   { TermCursor }, -- GitSignsDeleteInline xxx links to TermCursor
		GitSignsChangeInline                   { TermCursor }, -- GitSignsChangeInline xxx links to TermCursor
		NonText                                { fg="#7390aa", }, -- NonText        xxx guifg=#7390aa
		EndOfBuffer                            { NonText }, -- EndOfBuffer    xxx links to NonText
		TelescopePromptCounter                 { NonText }, -- TelescopePromptCounter xxx links to NonText
		TelescopeResultsDiffUntracked          { NonText }, -- TelescopeResultsDiffUntracked xxx links to NonText
		TelescopePreviewHyphen                 { NonText }, -- TelescopePreviewHyphen xxx links to NonText
		GitSignsCurrentLineBlame               { NonText }, -- GitSignsCurrentLineBlame xxx links to NonText
		NoiceLspProgressTitle                  { NonText }, -- NoiceLspProgressTitle xxx links to NonText
		NoiceFormatLevelOff                    { NonText }, -- NoiceFormatLevelOff xxx links to NonText
		NoiceFormatLevelTrace                  { NonText }, -- NoiceFormatLevelTrace xxx links to NonText
		NoiceFormatLevelDebug                  { NonText }, -- NoiceFormatLevelDebug xxx links to NonText
		NoiceFormatKind                        { NonText }, -- NoiceFormatKind xxx links to NonText
		NoiceFormatEvent                       { NonText }, -- NoiceFormatEvent xxx links to NonText
		Directory                              { fg="#91b4d5", }, -- Directory      xxx ctermfg=14 guifg=#91b4d5
		TelescopePreviewDate                   { Directory }, -- TelescopePreviewDate xxx links to Directory
		TelescopePreviewDirectory              { Directory }, -- TelescopePreviewDirectory xxx links to Directory
		TroubleFile                            { Directory }, -- TroubleFile    xxx links to Directory
		ErrorMsg                               { gui="bold", fg="#d0679d", }, -- ErrorMsg       xxx ctermfg=9 gui=bold guifg=#d0679d
		NvimInvalidSpacing                     { ErrorMsg }, -- NvimInvalidSpacing xxx links to ErrorMsg
		IncSearch                              { bg="#add7ff", fg="#171922", }, -- IncSearch      xxx guifg=#171922 guibg=#add7ff
		WildMenu                               { IncSearch }, -- WildMenu       xxx links to IncSearch
		Search                                 { bg="#506477", fg="#ffffff", }, -- Search         xxx ctermfg=0 ctermbg=11 guifg=#ffffff guibg=#506477
		Substitute                             { Search }, -- Substitute     xxx links to Search
		TelescopePreviewMatch                  { Search }, -- TelescopePreviewMatch xxx links to Search
		TroublePreview                         { Search }, -- TroublePreview xxx links to Search
		PounceMatch                            { Search }, -- PounceMatch    xxx links to Search
		PounceGap                              { Search }, -- PounceGap      xxx links to Search
		RenameMatch                            { Search }, -- RenameMatch    xxx links to Search
		DefinitionSearch                       { Search }, -- DefinitionSearch xxx links to Search
		FinderPreviewSearch                    { Search }, -- FinderPreviewSearch xxx links to Search
		CurSearch                              { }, -- CurSearch      xxx ctermfg=0 ctermbg=11
		MoreMsg                                { fg="#91b4d5", }, -- MoreMsg        xxx ctermfg=14 guifg=#91b4d5
		ModeMsg                                { fg="#91b4d5", }, -- ModeMsg        xxx ctermfg=10 guifg=#91b4d5
		LineNrAbove                            { LineNr }, -- LineNrAbove    xxx links to LineNr
		LineNrBelow                            { LineNr }, -- LineNrBelow    xxx links to LineNr
		TelescopeResultsLineNr                 { LineNr }, -- TelescopeResultsLineNr xxx links to LineNr
		TroubleLocation                        { LineNr }, -- TroubleLocation xxx links to LineNr
		TroubleIndent                          { LineNr }, -- TroubleIndent  xxx links to LineNr
		TroubleFoldIcon                        { CursorLineNr }, -- TroubleFoldIcon xxx links to CursorLineNr
		Question                               { fg="#fffac2", }, -- Question       xxx ctermfg=14 guifg=#fffac2
		MsgSeparator                           { StatusLine }, -- MsgSeparator   xxx links to StatusLine
		StatusLineTerm                         { StatusLine }, -- StatusLineTerm xxx links to StatusLine
		StatusLineNC                           { bg="#1b1e28", fg="#91b4d5", }, -- StatusLineNC   xxx cterm=bold guifg=#91b4d5 guibg=#1b1e28
		StatusLineTermNC                       { StatusLineNC }, -- StatusLineTermNC xxx links to StatusLineNC
		VertSplit                              { fg="#171922", }, -- VertSplit      xxx guifg=#171922
		Title                                  { fg="#e4f0fb", }, -- Title          xxx cterm=bold guifg=#e4f0fb
		sym"@markup.heading"                   { Title }, -- @markup.heading xxx links to Title
		LspInfoTitle                           { Title }, -- LspInfoTitle   xxx links to Title
		NoiceLspProgressClient                 { Title }, -- NoiceLspProgressClient xxx links to Title
		NoiceFormatTitle                       { Title }, -- NoiceFormatTitle xxx links to Title
		NoiceCmdlinePrompt                     { Title }, -- NoiceCmdlinePrompt xxx links to Title
		--EdgyTitle                              { bg=Normal.bg.de(10).li(), }, -- EdgyTitle      xxx links to Title
		Visual                                 { bg="#506477", fg="#e4f0fb", }, -- Visual         xxx ctermfg=0 ctermbg=15 guifg=#e4f0fb guibg=#506477
		VisualNOS                              { Visual }, -- VisualNOS      xxx links to Visual
		SnippetTabstop                         { Visual }, -- SnippetTabstop xxx links to Visual
		TelescopePreviewLine                   { Visual }, -- TelescopePreviewLine xxx links to Visual
		NoiceFormatConfirmDefault              { Visual }, -- NoiceFormatConfirmDefault xxx links to Visual
		NvimSurroundHighlight                  { Visual }, -- NvimSurroundHighlight xxx links to Visual
		Folded                                 { bg="#171922", fg="#e4f0fb", }, -- Folded         xxx guifg=#e4f0fb guibg=#171922
		FoldColumn                             { fg="#767c9d", }, -- FoldColumn     xxx guifg=#767c9d
		CursorLineFold                         { FoldColumn }, -- CursorLineFold xxx links to FoldColumn
		DiffAdd                                { bg="#3c8178", }, -- DiffAdd        xxx ctermfg=0 ctermbg=10 guibg=#3c8178
		GitSignsAddLn                          { DiffAdd }, -- GitSignsAddLn  xxx links to DiffAdd
		GitSignsAddPreview                     { DiffAdd }, -- GitSignsAddPreview xxx links to DiffAdd
		diffAdded                              { DiffAdd }, -- diffAdded      xxx links to DiffAdd
		DiffChange                             { bg="#a6accd", }, -- DiffChange     xxx guibg=#a6accd
		GitSignsChangeLn                       { DiffChange }, -- GitSignsChangeLn xxx links to DiffChange
		diffChanged                            { DiffChange }, -- diffChanged    xxx links to DiffChange
		DiffDelete                             { bg="#764363", }, -- DiffDelete     xxx cterm=bold ctermfg=9 guibg=#764363
		GitSignsDeletePreview                  { DiffDelete }, -- GitSignsDeletePreview xxx links to DiffDelete
		GitSignsDeleteVirtLn                   { DiffDelete }, -- GitSignsDeleteVirtLn xxx links to DiffDelete
		diffRemoved                            { DiffDelete }, -- diffRemoved    xxx links to DiffDelete
		DiffText                               { bg="#3d6965", }, -- DiffText       xxx ctermfg=0 ctermbg=14 guibg=#3d6965
		CursorLineSign                         { SignColumn }, -- CursorLineSign xxx links to SignColumn
		EdgyIcon                               { SignColumn }, -- EdgyIcon       xxx links to SignColumn
		SpellBad                               { gui="undercurl", sp="#d0679d", }, -- SpellBad       xxx cterm=undercurl gui=undercurl guisp=#d0679d
		SpellCap                               { gui="undercurl", sp="#89ddff", }, -- SpellCap       xxx cterm=undercurl gui=undercurl guisp=#89ddff
		SpellRare                              { gui="undercurl", sp="#89ddff", }, -- SpellRare      xxx cterm=undercurl gui=undercurl guisp=#89ddff
		SpellLocal                             { gui="undercurl", sp="#fffac2", }, -- SpellLocal     xxx cterm=undercurl gui=undercurl guisp=#fffac2
		Pmenu                                  { bg="#171922", fg="#a6accd", }, -- Pmenu          xxx cterm=reverse guifg=#a6accd guibg=#171922
		PmenuKind                              { Pmenu }, -- PmenuKind      xxx links to Pmenu
		PmenuExtra                             { Pmenu }, -- PmenuExtra     xxx links to Pmenu
		NoicePopupmenu                         { Pmenu }, -- NoicePopupmenu xxx links to Pmenu
		PmenuSel                               { bg="#303340", blend=0, fg="#e4f0fb", }, -- PmenuSel       xxx cterm=underline,reverse guifg=#e4f0fb guibg=#303340 blend=0
		PmenuKindSel                           { PmenuSel }, -- PmenuKindSel   xxx links to PmenuSel
		PmenuExtraSel                          { PmenuSel }, -- PmenuExtraSel  xxx links to PmenuSel
		NoicePopupmenuSelected                 { PmenuSel }, -- NoicePopupmenuSelected xxx links to PmenuSel
		PmenuSbar                              { bg="#767c9d", }, -- PmenuSbar      xxx guibg=#767c9d
		NoiceScrollbar                         { PmenuSbar }, -- NoiceScrollbar xxx links to PmenuSbar
		PmenuThumb                             { bg="#506477", }, -- PmenuThumb     xxx guibg=#506477
		NoiceScrollbarThumb                    { PmenuThumb }, -- NoiceScrollbarThumb xxx links to PmenuThumb
		TabLine                                { bg="#171922", fg="#91b4d5", }, -- TabLine        xxx guifg=#91b4d5 guibg=#171922
		TabLineSel                             { bg="#303340", fg="#e4f0fb", }, -- TabLineSel     xxx cterm=bold guifg=#e4f0fb guibg=#303340
		TroubleCount                           { TabLineSel }, -- TroubleCount   xxx links to TabLineSel
		TabLineFill                            { bg="#171922", }, -- TabLineFill    xxx guibg=#171922
		CursorColumn                           { bg="#303340", }, -- CursorColumn   xxx guibg=#303340
		NoiceFormatConfirm                     { CursorLine }, -- NoiceFormatConfirm xxx links to CursorLine
		NoiceFormatProgressTodo                { CursorLine }, -- NoiceFormatProgressTodo xxx links to CursorLine
		ColorColumn                            { bg="#a6accd", }, -- ColorColumn    xxx cterm=reverse guibg=#a6accd
		QuickFixLine                           { fg="nvimlightcyan", }, -- QuickFixLine   xxx ctermfg=14 guifg=NvimLightCyan
		Whitespace                             { fg="#506477", }, -- Whitespace     xxx guifg=#506477
		IndentBlanklineSpaceCharBlankline      { Whitespace }, -- IndentBlanklineSpaceCharBlankline xxx links to Whitespace
		IndentBlanklineSpaceChar               { Whitespace }, -- IndentBlanklineSpaceChar xxx links to Whitespace
		NormalNC                               { bg="#1b1e28", fg="#e4f0fb", }, -- NormalNC       xxx guifg=#e4f0fb guibg=#1b1e28
		Cursor                                 { bg="#a6accd", fg="#171922", }, -- Cursor         xxx guifg=#171922 guibg=#a6accd
		CursorIM                               { Cursor }, -- CursorIM       xxx links to Cursor
		NoiceCursor                            { Cursor }, -- NoiceCursor    xxx links to Cursor
		FloatTitle                             { fg="#767c9d", }, -- FloatTitle     xxx guifg=#767c9d
		FloatFooter                            { FloatTitle }, -- FloatFooter    xxx links to FloatTitle
		RedrawDebugNormal                      { gui="reverse", }, -- RedrawDebugNormal xxx cterm=reverse gui=reverse
		Underlined                             { gui="underline", }, -- Underlined     xxx cterm=underline gui=underline
		sym"@string.special.url"               { Underlined }, -- @string.special.url xxx links to Underlined
		sym"@markup.link"                      { Underlined }, -- @markup.link   xxx links to Underlined
		lCursor                                { bg="fg", fg="bg", }, -- lCursor        xxx guifg=bg guibg=fg
		Ignore                                 { Normal }, -- Ignore         xxx links to Normal
		NvimSpacing                            { Normal }, -- NvimSpacing    xxx links to Normal
		NotifyBackground                       { Normal }, -- NotifyBackground xxx links to Normal
		NotifyERRORBody                        { Normal }, -- NotifyERRORBody xxx links to Normal
		NotifyWARNBody                         { Normal }, -- NotifyWARNBody xxx links to Normal
		NotifyINFOBody                         { Normal }, -- NotifyINFOBody xxx links to Normal
		NotifyDEBUGBody                        { Normal }, -- NotifyDEBUGBody xxx links to Normal
		NotifyTRACEBody                        { Normal }, -- NotifyTRACEBody xxx links to Normal
		TroubleText                            { Normal }, -- TroubleText    xxx links to Normal
		TroubleNormal                          { Normal }, -- TroubleNormal  xxx links to Normal
		DapUINormal                            { Normal }, -- DapUINormal    xxx links to Normal
		DapUIVariable                          { Normal }, -- DapUIVariable  xxx links to Normal
		DapUIValue                             { Normal }, -- DapUIValue     xxx links to Normal
		DapUIFrameName                         { Normal }, -- DapUIFrameName xxx links to Normal
		NoiceConfirm                           { Normal }, -- NoiceConfirm   xxx links to Normal
		NoiceCmdlinePopup                      { Normal }, -- NoiceCmdlinePopup xxx links to Normal
		TelescopePreviewUser                   { Constant }, -- TelescopePreviewUser xxx links to Constant
		TelescopeResultsConstant               { Constant }, -- TelescopeResultsConstant xxx links to Constant
		TelescopePreviewGroup                  { Constant }, -- TelescopePreviewGroup xxx links to Constant
		TelescopePreviewRead                   { Constant }, -- TelescopePreviewRead xxx links to Constant
		TelescopePreviewBlock                  { Constant }, -- TelescopePreviewBlock xxx links to Constant
		TelescopePreviewCharDev                { Constant }, -- TelescopePreviewCharDev xxx links to Constant
		TelescopePreviewPipe                   { Constant }, -- TelescopePreviewPipe xxx links to Constant
		NoiceLspProgressSpinner                { Constant }, -- NoiceLspProgressSpinner xxx links to Constant
		EdgyIconActive                         { Constant }, -- EdgyIconActive xxx links to Constant
		NvimNumber                             { Number }, -- NvimNumber     xxx links to Number
		TelescopeResultsNumber                 { Number }, -- TelescopeResultsNumber xxx links to Number
		Conditional                            { fg="#a6accd", }, -- Conditional    xxx guifg=#a6accd
		Statement                              { fg="#e4f0fb", }, -- Statement      xxx cterm=bold guifg=#e4f0fb
		TelescopePreviewWrite                  { Statement }, -- TelescopePreviewWrite xxx links to Statement
		TelescopePreviewSocket                 { Statement }, -- TelescopePreviewSocket xxx links to Statement
		Repeat                                 { fg="#91b4d5", }, -- Repeat         xxx guifg=#91b4d5
		Label                                  { fg="#e4f0fb", }, -- Label          xxx guifg=#e4f0fb
		LspInfoBorder                          { Label }, -- LspInfoBorder  xxx links to Label
		FinderCount                            { Label }, -- FinderCount    xxx links to Label
		TelescopePreviewSticky                 { Keyword }, -- TelescopePreviewSticky xxx links to Keyword
		Exception                              { fg="#91b4d5", }, -- Exception      xxx guifg=#91b4d5
		Structure                              { Type }, -- Structure      xxx links to Type
		Typedef                                { Type }, -- Typedef        xxx links to Type
		NvimNumberPrefix                       { Type }, -- NvimNumberPrefix xxx links to Type
		NvimOptionSigil                        { Type }, -- NvimOptionSigil xxx links to Type
		TelescopeMultiSelection                { Type }, -- TelescopeMultiSelection xxx links to Type
		LspInfoFiletype                        { Type }, -- LspInfoFiletype xxx links to Type
		Tag                                    { fg="#e4f0fb", }, -- Tag            xxx guifg=#e4f0fb
		Debug                                  { Special }, -- Debug          xxx links to Special
		TelescopePreviewLink                   { Special }, -- TelescopePreviewLink xxx links to Special
		NotifyLogTitle                         { Special }, -- NotifyLogTitle xxx links to Special
		DressingSelectIdx                      { Special }, -- DressingSelectIdx xxx links to Special
		NoiceCompletionItemKindDefault         { Special }, -- NoiceCompletionItemKindDefault xxx links to Special
		NoiceFormatDate                        { Special }, -- NoiceFormatDate xxx links to Special
		NoicePopupmenuMatch                    { Special }, -- NoicePopupmenuMatch xxx links to Special
		SpecialComment                         { fg="#a6accd", }, -- SpecialComment xxx guifg=#a6accd
		TelescopeResultsSpecialComment         { SpecialComment }, -- TelescopeResultsSpecialComment xxx links to SpecialComment
		LspCodeLens                            { fg="#a6accd", }, -- LspCodeLens    xxx guifg=#a6accd
		LspCodeLensSeparator                   { fg="#506477", }, -- LspCodeLensSeparator xxx guifg=#506477
		LspReferenceRead                       { bg="#add7ff", }, -- LspReferenceRead xxx guibg=#add7ff
		LspReferenceText                       { bg="#add7ff", }, -- LspReferenceText xxx guibg=#add7ff
		LspReferenceWrite                      { bg="#add7ff", }, -- LspReferenceWrite xxx guibg=#add7ff
		LspSignatureActiveParameter            { bg="#a6accd", }, -- LspSignatureActiveParameter xxx guibg=#a6accd
		NvimDapVirtualTextInfo                 { DiagnosticVirtualTextInfo }, -- NvimDapVirtualTextInfo xxx links to DiagnosticVirtualTextInfo
		NoiceFormatLevelInfo                   { DiagnosticVirtualTextInfo }, -- NoiceFormatLevelInfo xxx links to DiagnosticVirtualTextInfo
		NoiceVirtualText                       { DiagnosticVirtualTextInfo }, -- NoiceVirtualText xxx links to DiagnosticVirtualTextInfo
		DiagnosticVirtualTextHint              { fg="#89ddff", }, -- DiagnosticVirtualTextHint xxx guifg=#89ddff
		NoiceCmdlinePopupBorderSearch          { DiagnosticSignWarn }, -- NoiceCmdlinePopupBorderSearch xxx links to DiagnosticSignWarn
		NoiceCmdlineIconSearch                 { DiagnosticSignWarn }, -- NoiceCmdlineIconSearch xxx links to DiagnosticSignWarn
		NoiceConfirmBorder                     { DiagnosticSignInfo }, -- NoiceConfirmBorder xxx links to DiagnosticSignInfo
		NoiceCmdlinePopupTitle                 { DiagnosticSignInfo }, -- NoiceCmdlinePopupTitle xxx links to DiagnosticSignInfo
		NoiceCmdlinePopupBorder                { DiagnosticSignInfo }, -- NoiceCmdlinePopupBorder xxx links to DiagnosticSignInfo
		NoiceCmdlineIcon                       { DiagnosticSignInfo }, -- NoiceCmdlineIcon xxx links to DiagnosticSignInfo
		LspSagaLightBulb                       { DiagnosticSignHint }, -- LspSagaLightBulb xxx links to DiagnosticSignHint
		TelescopeResultsComment                { Comment }, -- TelescopeResultsComment xxx links to Comment
		NotifyLogTime                          { Comment }, -- NotifyLogTime  xxx links to Comment
		NvimDapSubtleFrame                     { Comment }, -- NvimDapSubtleFrame xxx links to Comment
		LspInfoTip                             { Comment }, -- LspInfoTip     xxx links to Comment
		NeogitSignatureNone                    { Comment }, -- NeogitSignatureNone xxx links to Comment
		NeogitRebaseDone                       { Comment }, -- NeogitRebaseDone xxx links to Comment
		NeogitPopupActionDisabled              { Comment }, -- NeogitPopupActionDisabled xxx links to Comment
		NeogitPopupConfigDisabled              { Comment }, -- NeogitPopupConfigDisabled xxx links to Comment
		NeogitPopupSwitchDisabled              { Comment }, -- NeogitPopupSwitchDisabled xxx links to Comment
		NeogitStash                            { Comment }, -- NeogitStash    xxx links to Comment
		NeogitObjectId                         { Comment }, -- NeogitObjectId xxx links to Comment
		NeogitPopupOptionDisabled              { Comment }, -- NeogitPopupOptionDisabled xxx links to Comment
		NeogitCommandText                      { Comment }, -- NeogitCommandText xxx links to Comment
		NeogitCommandTime                      { Comment }, -- NeogitCommandTime xxx links to Comment
		TroubleSource                          { Comment }, -- TroubleSource  xxx links to Comment
		TroubleCode                            { Comment }, -- TroubleCode    xxx links to Comment
		NvimDapVirtualText                     { Comment }, -- NvimDapVirtualText xxx links to Comment
		NvimString                             { String }, -- NvimString     xxx links to String
		TelescopePreviewSize                   { String }, -- TelescopePreviewSize xxx links to String
		TelescopePreviewExecute                { String }, -- TelescopePreviewExecute xxx links to String
		NeogitCommitViewDescription            { String }, -- NeogitCommitViewDescription xxx links to String
		NeogitPopupBranchName                  { String }, -- NeogitPopupBranchName xxx links to String
		NeogitCommandCodeNormal                { String }, -- NeogitCommandCodeNormal xxx links to String
		Identifier                             { fg="#a6accd", }, -- Identifier     xxx ctermfg=12 guifg=#a6accd
		NvimIdentifier                         { Identifier }, -- NvimIdentifier xxx links to Identifier
		TelescopeMultiIcon                     { Identifier }, -- TelescopeMultiIcon xxx links to Identifier
		TelescopeResultsIdentifier             { Identifier }, -- TelescopeResultsIdentifier xxx links to Identifier
		TelescopeResultsClass                  { Function }, -- TelescopeResultsClass xxx links to Function
		TelescopeResultsFunction               { Function }, -- TelescopeResultsFunction xxx links to Function
		TelescopeResultsField                  { Function }, -- TelescopeResultsField xxx links to Function
		LspInfoList                            { Function }, -- LspInfoList    xxx links to Function
		NeogitPopupSectionTitle                { Function }, -- NeogitPopupSectionTitle xxx links to Function
		NvimAssignment                         { Operator }, -- NvimAssignment xxx links to Operator
		NvimOperator                           { Operator }, -- NvimOperator   xxx links to Operator
		TelescopeResultsOperator               { Operator }, -- TelescopeResultsOperator xxx links to Operator
		NvimParenthesis                        { Delimiter }, -- NvimParenthesis xxx links to Delimiter
		NvimColon                              { Delimiter }, -- NvimColon      xxx links to Delimiter
		NvimComma                              { Delimiter }, -- NvimComma      xxx links to Delimiter
		NvimArrow                              { Delimiter }, -- NvimArrow      xxx links to Delimiter
		Added                                  { fg="nvimlightgreen", }, -- Added          xxx ctermfg=10 guifg=NvimLightGreen
		sym"@diff.plus"                        { Added }, -- @diff.plus     xxx links to Added
		Removed                                { fg="nvimlightred", }, -- Removed        xxx ctermfg=9 guifg=NvimLightRed
		sym"@diff.minus"                       { Removed }, -- @diff.minus    xxx links to Removed
		Changed                                { fg="nvimlightcyan", }, -- Changed        xxx ctermfg=14 guifg=NvimLightCyan
		sym"@diff.delta"                       { Changed }, -- @diff.delta    xxx links to Changed
		sym"@tag"                              { fg="#5de4c7", }, -- @tag           xxx guifg=#5de4c7
		DiagnosticDeprecated                   { gui="strikethrough", sp="nvimlightred", }, -- DiagnosticDeprecated xxx cterm=strikethrough gui=strikethrough guisp=NvimLightRed
		sym"@lsp.mod.deprecated"               { DiagnosticDeprecated }, -- @lsp.mod.deprecated xxx links to DiagnosticDeprecated
		FloatShadow                            { bg="nvimdarkgrey4", blend=80, }, -- FloatShadow    xxx ctermbg=0 guibg=NvimDarkGrey4 blend=80
		FloatShadowThrough                     { bg="nvimdarkgrey4", blend=100, }, -- FloatShadowThrough xxx ctermbg=0 guibg=NvimDarkGrey4 blend=100
		MatchParen                             { bg="#506477", fg="#171922", }, -- MatchParen     xxx cterm=bold,underline guifg=#171922 guibg=#506477
		RedrawDebugClear                       { bg="#fffac2", fg="#ffffff", }, -- RedrawDebugClear xxx ctermfg=0 ctermbg=11 guifg=#ffffff guibg=#fffac2
		RedrawDebugComposed                    { bg="#5fb3a1", fg="#ffffff", }, -- RedrawDebugComposed xxx ctermfg=0 ctermbg=10 guifg=#ffffff guibg=#5fb3a1
		RedrawDebugRecompose                   { bg="#d0679d", fg="#ffffff", }, -- RedrawDebugRecompose xxx ctermfg=0 ctermbg=9 guifg=#ffffff guibg=#d0679d
		Error                                  { fg="#d0679d", }, -- Error          xxx ctermfg=0 ctermbg=9 guifg=#d0679d
		NvimInvalid                            { Error }, -- NvimInvalid    xxx links to Error
		NeogitCommandCodeError                 { Error }, -- NeogitCommandCodeError xxx links to Error
		NvimInternalError                      { bg="#d0679d", fg="#ffffff", }, -- NvimInternalError xxx ctermfg=9 ctermbg=9 guifg=#ffffff guibg=#d0679d
		NvimFigureBrace                        { NvimInternalError }, -- NvimFigureBrace xxx links to NvimInternalError
		NvimSingleQuotedUnknownEscape          { NvimInternalError }, -- NvimSingleQuotedUnknownEscape xxx links to NvimInternalError
		NvimInvalidSingleQuotedUnknownEscape   { NvimInternalError }, -- NvimInvalidSingleQuotedUnknownEscape xxx links to NvimInternalError
		TelescopeBorder                        { fg="#303340", }, -- TelescopeBorder xxx guifg=#303340
		TelescopePreviewBorder                 { TelescopeBorder }, -- TelescopePreviewBorder xxx links to TelescopeBorder
		TelescopeResultsBorder                 { TelescopeBorder }, -- TelescopeResultsBorder xxx links to TelescopeBorder
		TelescopePreviewTitle                  { bg="#5de4c7", fg="#1b1e28", }, -- TelescopePreviewTitle xxx guifg=#1b1e28 guibg=#5de4c7
		TelescopePromptNormal                  { fg="#e4f0fb", }, -- TelescopePromptNormal xxx guifg=#e4f0fb
		TelescopePromptBorder                  { fg="#303340", }, -- TelescopePromptBorder xxx guifg=#303340
		TelescopeResultsTitle                  { bg="#1f2335", }, -- TelescopeResultsTitle xxx guibg=#1f2335
		TelescopePromptTitle                   { bg="#89ddff", fg="#1b1e28", }, -- TelescopePromptTitle xxx guifg=#1b1e28 guibg=#89ddff
		TelescopeNormal                        { fg="#e4f0fb", }, -- TelescopeNormal xxx guifg=#e4f0fb
		TelescopeResultsNormal                 { TelescopeNormal }, -- TelescopeResultsNormal xxx links to TelescopeNormal
		TelescopePreviewNormal                 { TelescopeNormal }, -- TelescopePreviewNormal xxx links to TelescopeNormal
		TelescopePromptPrefix                  { fg="#767c9d", }, -- TelescopePromptPrefix xxx guifg=#767c9d
		TelescopeMatching                      { fg="#5de4c7", }, -- TelescopeMatching xxx guifg=#5de4c7
		TelescopeTitle                         { fg="#767c9d", }, -- TelescopeTitle xxx guifg=#767c9d
		TelescopeSelection                     { bg="#303340", fg="#e4f0fb", }, -- TelescopeSelection xxx guifg=#e4f0fb guibg=#303340
		TelescopeSelectionCaret                { TelescopeSelection }, -- TelescopeSelectionCaret xxx links to TelescopeSelection
		TelescopeResultsDiffDelete             { fg="#d0679d", }, -- TelescopeResultsDiffDelete xxx guifg=#d0679d
		TelescopeResultsDiffAdd                { fg="#5de4c7", }, -- TelescopeResultsDiffAdd xxx guifg=#5de4c7
		TelescopeResultsDiffChange             { fg="#fffac2", }, -- TelescopeResultsDiffChange xxx guifg=#fffac2
		NotifyERRORBorder                      { fg="#d0679d", }, -- NotifyERRORBorder xxx guifg=#d0679d
		NotifyERRORIcon                        { NotifyERRORBorder }, -- NotifyERRORIcon xxx links to NotifyERRORBorder
		NotifyERRORTitle                       { NotifyERRORBorder }, -- NotifyERRORTitle xxx links to NotifyERRORBorder
		NotifyWARNBorder                       { fg="#fffac2", }, -- NotifyWARNBorder xxx guifg=#fffac2
		NotifyWARNIcon                         { NotifyWARNBorder }, -- NotifyWARNIcon xxx links to NotifyWARNBorder
		NotifyWARNTitle                        { NotifyWARNBorder }, -- NotifyWARNTitle xxx links to NotifyWARNBorder
		NotifyINFOBorder                       { fg="#5de4c7", }, -- NotifyINFOBorder xxx guifg=#5de4c7
		NotifyINFOIcon                         { NotifyINFOBorder }, -- NotifyINFOIcon xxx links to NotifyINFOBorder
		NotifyINFOTitle                        { NotifyINFOBorder }, -- NotifyINFOTitle xxx links to NotifyINFOBorder
		NotifyDEBUGBorder                      { fg="#89ddff", }, -- NotifyDEBUGBorder xxx guifg=#89ddff
		NotifyDEBUGIcon                        { NotifyDEBUGBorder }, -- NotifyDEBUGIcon xxx links to NotifyDEBUGBorder
		NotifyDEBUGTitle                       { NotifyDEBUGBorder }, -- NotifyDEBUGTitle xxx links to NotifyDEBUGBorder
		NotifyTRACEBorder                      { fg="#89ddff", }, -- NotifyTRACEBorder xxx guifg=#89ddff
		NotifyTRACEIcon                        { NotifyTRACEBorder }, -- NotifyTRACEIcon xxx links to NotifyTRACEBorder
		NotifyTRACETitle                       { NotifyTRACEBorder }, -- NotifyTRACETitle xxx links to NotifyTRACEBorder
		debugPC                                { bg="#303340", }, -- debugPC        xxx guibg=#303340
		RainbowDelimiterRed                    { fg="#cc241d", }, -- RainbowDelimiterRed xxx ctermfg=9 guifg=#cc241d
		RainbowDelimiterOrange                 { fg="#d65d0e", }, -- RainbowDelimiterOrange xxx ctermfg=15 guifg=#d65d0e
		RainbowDelimiterYellow                 { fg="#d79921", }, -- RainbowDelimiterYellow xxx ctermfg=11 guifg=#d79921
		RainbowDelimiterGreen                  { fg="#689d6a", }, -- RainbowDelimiterGreen xxx ctermfg=10 guifg=#689d6a
		RainbowDelimiterCyan                   { fg="#a89984", }, -- RainbowDelimiterCyan xxx ctermfg=14 guifg=#a89984
		RainbowDelimiterBlue                   { fg="#458588", }, -- RainbowDelimiterBlue xxx ctermfg=12 guifg=#458588
		RainbowDelimiterViolet                 { fg="#b16286", }, -- RainbowDelimiterViolet xxx ctermfg=13 guifg=#b16286
		RainbowRed                             { fg="#e06c75", }, -- RainbowRed     xxx guifg=#e06c75
		RainbowYellow                          { fg="#e5c07b", }, -- RainbowYellow  xxx guifg=#e5c07b
		RainbowBlue                            { fg="#61afef", }, -- RainbowBlue    xxx guifg=#61afef
		RainbowOrange                          { fg="#d19a66", }, -- RainbowOrange  xxx guifg=#d19a66
		RainbowGreen                           { fg="#98c379", }, -- RainbowGreen   xxx guifg=#98c379
		RainbowViolet                          { fg="#c678dd", }, -- RainbowViolet  xxx guifg=#c678dd
		RainbowCyan                            { fg="#56b6c2", }, -- RainbowCyan    xxx guifg=#56b6c2
		sym"@ibl.indent.char.1"                { gui="nocombine", fg="#e06c75", }, -- @ibl.indent.char.1 xxx cterm=nocombine gui=nocombine guifg=#e06c75
		sym"@ibl.indent.char.2"                { gui="nocombine", fg="#e5c07b", }, -- @ibl.indent.char.2 xxx cterm=nocombine gui=nocombine guifg=#e5c07b
		sym"@ibl.indent.char.3"                { gui="nocombine", fg="#61afef", }, -- @ibl.indent.char.3 xxx cterm=nocombine gui=nocombine guifg=#61afef
		sym"@ibl.indent.char.4"                { gui="nocombine", fg="#d19a66", }, -- @ibl.indent.char.4 xxx cterm=nocombine gui=nocombine guifg=#d19a66
		sym"@ibl.indent.char.5"                { gui="nocombine", fg="#98c379", }, -- @ibl.indent.char.5 xxx cterm=nocombine gui=nocombine guifg=#98c379
		sym"@ibl.indent.char.6"                { gui="nocombine", fg="#c678dd", }, -- @ibl.indent.char.6 xxx cterm=nocombine gui=nocombine guifg=#c678dd
		sym"@ibl.indent.char.7"                { gui="nocombine", fg="#56b6c2", }, -- @ibl.indent.char.7 xxx cterm=nocombine gui=nocombine guifg=#56b6c2
		sym"@ibl.whitespace.char.1"            { gui="nocombine", fg="#e06c75", }, -- @ibl.whitespace.char.1 xxx cterm=nocombine gui=nocombine guifg=#e06c75
		sym"@ibl.whitespace.char.2"            { gui="nocombine", fg="#e5c07b", }, -- @ibl.whitespace.char.2 xxx cterm=nocombine gui=nocombine guifg=#e5c07b
		sym"@ibl.whitespace.char.3"            { gui="nocombine", fg="#61afef", }, -- @ibl.whitespace.char.3 xxx cterm=nocombine gui=nocombine guifg=#61afef
		sym"@ibl.whitespace.char.4"            { gui="nocombine", fg="#d19a66", }, -- @ibl.whitespace.char.4 xxx cterm=nocombine gui=nocombine guifg=#d19a66
		sym"@ibl.whitespace.char.5"            { gui="nocombine", fg="#98c379", }, -- @ibl.whitespace.char.5 xxx cterm=nocombine gui=nocombine guifg=#98c379
		sym"@ibl.whitespace.char.6"            { gui="nocombine", fg="#c678dd", }, -- @ibl.whitespace.char.6 xxx cterm=nocombine gui=nocombine guifg=#c678dd
		sym"@ibl.whitespace.char.7"            { gui="nocombine", fg="#56b6c2", }, -- @ibl.whitespace.char.7 xxx cterm=nocombine gui=nocombine guifg=#56b6c2
		sym"@ibl.scope.char.1"                 { gui="nocombine", fg="#506477", }, -- @ibl.scope.char.1 xxx cterm=nocombine gui=nocombine guifg=#506477
		sym"@ibl.scope.underline.1"            { gui="underline", sp="#506477", }, -- @ibl.scope.underline.1 xxx cterm=underline gui=underline guisp=#506477
		CmpItemAbbr                            { fg="#767c9d", }, -- CmpItemAbbr    xxx guifg=#767c9d
		CmpItemAbbrDefault                     { fg="#a6accd", }, -- CmpItemAbbrDefault xxx guifg=#a6accd
		CmpItemAbbrDeprecated                  { gui="strikethrough", fg="#d0679d", }, -- CmpItemAbbrDeprecated xxx gui=strikethrough guifg=#d0679d
		CmpItemAbbrDeprecatedDefault           { fg="#a6accd", }, -- CmpItemAbbrDeprecatedDefault xxx guifg=#a6accd
		CmpItemAbbrMatch                       { gui="bold", fg="#e4f0fb", }, -- CmpItemAbbrMatch xxx gui=bold guifg=#e4f0fb
		CmpItemAbbrMatchDefault                { fg="#a6accd", }, -- CmpItemAbbrMatchDefault xxx guifg=#a6accd
		CmpItemAbbrMatchFuzzy                  { gui="bold", fg="#5de4c7", }, -- CmpItemAbbrMatchFuzzy xxx gui=bold guifg=#5de4c7
		CmpItemAbbrMatchFuzzyDefault           { fg="#a6accd", }, -- CmpItemAbbrMatchFuzzyDefault xxx guifg=#a6accd
		CmpItemKind                            { fg="#91b4d5", }, -- CmpItemKind    xxx guifg=#91b4d5
		CmpItemKindConstantDefault             { CmpItemKind }, -- CmpItemKindConstantDefault xxx links to CmpItemKind
		CmpItemKindSnippetDefault              { CmpItemKind }, -- CmpItemKindSnippetDefault xxx links to CmpItemKind
		CmpItemKindMethodDefault               { CmpItemKind }, -- CmpItemKindMethodDefault xxx links to CmpItemKind
		CmpItemKindInterfaceDefault            { CmpItemKind }, -- CmpItemKindInterfaceDefault xxx links to CmpItemKind
		CmpItemKindModuleDefault               { CmpItemKind }, -- CmpItemKindModuleDefault xxx links to CmpItemKind
		CmpItemKindPropertyDefault             { CmpItemKind }, -- CmpItemKindPropertyDefault xxx links to CmpItemKind
		CmpItemKindTypeParameterDefault        { CmpItemKind }, -- CmpItemKindTypeParameterDefault xxx links to CmpItemKind
		CmpItemKindOperatorDefault             { CmpItemKind }, -- CmpItemKindOperatorDefault xxx links to CmpItemKind
		CmpItemKindEnumMemberDefault           { CmpItemKind }, -- CmpItemKindEnumMemberDefault xxx links to CmpItemKind
		CmpItemKindVariableDefault             { CmpItemKind }, -- CmpItemKindVariableDefault xxx links to CmpItemKind
		CmpItemKindEventDefault                { CmpItemKind }, -- CmpItemKindEventDefault xxx links to CmpItemKind
		CmpItemKindEnumDefault                 { CmpItemKind }, -- CmpItemKindEnumDefault xxx links to CmpItemKind
		CmpItemKindStructDefault               { CmpItemKind }, -- CmpItemKindStructDefault xxx links to CmpItemKind
		CmpItemKindFileDefault                 { CmpItemKind }, -- CmpItemKindFileDefault xxx links to CmpItemKind
		CmpItemKindConstructorDefault          { CmpItemKind }, -- CmpItemKindConstructorDefault xxx links to CmpItemKind
		CmpItemKindKeywordDefault              { CmpItemKind }, -- CmpItemKindKeywordDefault xxx links to CmpItemKind
		CmpItemKindFunctionDefault             { CmpItemKind }, -- CmpItemKindFunctionDefault xxx links to CmpItemKind
		CmpItemKindTextDefault                 { CmpItemKind }, -- CmpItemKindTextDefault xxx links to CmpItemKind
		CmpItemKindFieldDefault                { CmpItemKind }, -- CmpItemKindFieldDefault xxx links to CmpItemKind
		CmpItemKindClassDefault                { CmpItemKind }, -- CmpItemKindClassDefault xxx links to CmpItemKind
		CmpItemKindFolderDefault               { CmpItemKind }, -- CmpItemKindFolderDefault xxx links to CmpItemKind
		CmpItemKindReferenceDefault            { CmpItemKind }, -- CmpItemKindReferenceDefault xxx links to CmpItemKind
		CmpItemKindColorDefault                { CmpItemKind }, -- CmpItemKindColorDefault xxx links to CmpItemKind
		CmpItemKindValueDefault                { CmpItemKind }, -- CmpItemKindValueDefault xxx links to CmpItemKind
		CmpItemKindUnitDefault                 { CmpItemKind }, -- CmpItemKindUnitDefault xxx links to CmpItemKind
		CmpItemKindDefault                     { fg="#767c9d", }, -- CmpItemKindDefault xxx guifg=#767c9d
		CmpItemMenuDefault                     { fg="#a6accd", }, -- CmpItemMenuDefault xxx guifg=#a6accd
		CmpItemMenu                            { CmpItemMenuDefault }, -- CmpItemMenu    xxx links to CmpItemMenuDefault
		CmpItemKindSnippet                     { fg="#a6accd", }, -- CmpItemKindSnippet xxx guifg=#a6accd
		CmpItemKindMethod                      { fg="#d0679d", }, -- CmpItemKindMethod xxx guifg=#d0679d
		CmpItemKindInterface                   { fg="#add7ff", }, -- CmpItemKindInterface xxx guifg=#add7ff
		CmpItemKindVariable                    { fg="#5de4c7", }, -- CmpItemKindVariable xxx guifg=#5de4c7
		CmpItemKindFunction                    { fg="#89ddff", }, -- CmpItemKindFunction xxx guifg=#89ddff
		CmpItemKindClass                       { fg="#fffac2", }, -- CmpItemKindClass xxx guifg=#fffac2
		NeogitGraphAuthor                      { fg="#8cf8f7", }, -- NeogitGraphAuthor xxx guifg=#8cf8f7
		NeogitTagName                          { fg="#e0e2ea", }, -- NeogitTagName  xxx guifg=#e0e2ea
		NeogitRemote                           { gui="bold", fg="#b3f6c0", }, -- NeogitRemote   xxx cterm=bold gui=bold guifg=#b3f6c0
		NeogitBranch                           { gui="bold", fg="#e0e2ea", }, -- NeogitBranch   xxx cterm=bold gui=bold guifg=#e0e2ea
		NeogitBranchHead                       { gui="bold,underline", fg="#e0e2ea", }, -- NeogitBranchHead xxx cterm=bold,underline gui=bold,underline guifg=#e0e2ea
		NeogitGraphYellow                      { fg="#e0e2ea", }, -- NeogitGraphYellow xxx guifg=#e0e2ea
		NeogitSignatureGoodExpiredKey          { NeogitGraphYellow }, -- NeogitSignatureGoodExpiredKey xxx links to NeogitGraphYellow
		NeogitGraphRed                         { fg="#eef1f8", }, -- NeogitGraphRed xxx guifg=#eef1f8
		NeogitSignatureGoodRevokedKey          { NeogitGraphRed }, -- NeogitSignatureGoodRevokedKey xxx links to NeogitGraphRed
		NeogitGraphBoldRed                     { gui="bold", fg="#eef1f8", }, -- NeogitGraphBoldRed xxx cterm=bold gui=bold guifg=#eef1f8
		NeogitSignatureBad                     { NeogitGraphBoldRed }, -- NeogitSignatureBad xxx links to NeogitGraphBoldRed
		NeogitGraphGreen                       { fg="#b3f6c0", }, -- NeogitGraphGreen xxx guifg=#b3f6c0
		NeogitSignatureGood                    { NeogitGraphGreen }, -- NeogitSignatureGood xxx links to NeogitGraphGreen
		NeogitGraphOrange                      { fg="#8cf8f7", }, -- NeogitGraphOrange xxx guifg=#8cf8f7
		NeogitSignatureGoodExpired             { NeogitGraphOrange }, -- NeogitSignatureGoodExpired xxx links to NeogitGraphOrange
		NeogitGraphBlue                        { fg="#e0e2ea", }, -- NeogitGraphBlue xxx guifg=#e0e2ea
		NeogitSignatureGoodUnknown             { NeogitGraphBlue }, -- NeogitSignatureGoodUnknown xxx links to NeogitGraphBlue
		NeogitGraphPurple                      { fg="#e0e2ea", }, -- NeogitGraphPurple xxx guifg=#e0e2ea
		NeogitSignatureMissing                 { NeogitGraphPurple }, -- NeogitSignatureMissing xxx links to NeogitGraphPurple
		NeogitTagDistance                      { fg="#e0e2ea", }, -- NeogitTagDistance xxx guifg=#e0e2ea
		NeogitSectionHeader                    { gui="bold", fg="#b8b9c0", }, -- NeogitSectionHeader xxx cterm=bold gui=bold guifg=#b8b9c0
		NeogitReverting                        { NeogitSectionHeader }, -- NeogitReverting xxx links to NeogitSectionHeader
		NeogitPicking                          { NeogitSectionHeader }, -- NeogitPicking  xxx links to NeogitSectionHeader
		NeogitRebasing                         { NeogitSectionHeader }, -- NeogitRebasing xxx links to NeogitSectionHeader
		NeogitStashes                          { NeogitSectionHeader }, -- NeogitStashes  xxx links to NeogitSectionHeader
		NeogitStagedchanges                    { NeogitSectionHeader }, -- NeogitStagedchanges xxx links to NeogitSectionHeader
		NeogitRecentcommits                    { NeogitSectionHeader }, -- NeogitRecentcommits xxx links to NeogitSectionHeader
		NeogitUnpulledchanges                  { NeogitSectionHeader }, -- NeogitUnpulledchanges xxx links to NeogitSectionHeader
		NeogitUnmergedchanges                  { NeogitSectionHeader }, -- NeogitUnmergedchanges xxx links to NeogitSectionHeader
		NeogitUnstagedchanges                  { NeogitSectionHeader }, -- NeogitUnstagedchanges xxx links to NeogitSectionHeader
		NeogitUntrackedfiles                   { NeogitSectionHeader }, -- NeogitUntrackedfiles xxx links to NeogitSectionHeader
		NeogitChangeNewFile                    { gui="bold,italic", fg="#93ca9d", }, -- NeogitChangeNewFile xxx cterm=bold,italic gui=bold,italic guifg=#93ca9d
		NeogitChangeBothModified               { gui="bold,italic", fg="#babcc2", }, -- NeogitChangeBothModified xxx cterm=bold,italic gui=bold,italic guifg=#babcc2
		NeogitChangeCopied                     { gui="bold,italic", fg="#b8b9c0", }, -- NeogitChangeCopied xxx cterm=bold,italic gui=bold,italic guifg=#b8b9c0
		NeogitChangeUpdated                    { gui="bold,italic", fg="#74cecd", }, -- NeogitChangeUpdated xxx cterm=bold,italic gui=bold,italic guifg=#74cecd
		NeogitChangeDeleted                    { gui="bold,italic", fg="#c3c6cb", }, -- NeogitChangeDeleted xxx cterm=bold,italic gui=bold,italic guifg=#c3c6cb
		NeogitCursorLine                       { bg="#181a1f", }, -- NeogitCursorLine xxx guibg=#181a1f
		NeogitChangeModified                   { gui="bold,italic", fg="#b8b9c0", }, -- NeogitChangeModified xxx cterm=bold,italic gui=bold,italic guifg=#b8b9c0
		NeogitHunkHeaderHighlight              { bg="#e6e7ee", gui="bold", fg="#14161b", }, -- NeogitHunkHeaderHighlight xxx cterm=bold gui=bold guifg=#14161b guibg=#e6e7ee
		NeogitHunkHeader                       { bg="#727376", gui="bold", fg="#14161b", }, -- NeogitHunkHeader xxx cterm=bold gui=bold guifg=#14161b guibg=#727376
		NeogitUnpulledFrom                     { gui="bold", fg="#b8b9c0", }, -- NeogitUnpulledFrom xxx cterm=bold gui=bold guifg=#b8b9c0
		NeogitDiffHeader                       { bg="#2e3034", gui="bold", fg="#e0e2ea", }, -- NeogitDiffHeader xxx cterm=bold gui=bold guifg=#e0e2ea guibg=#2e3034
		NeogitUnmergedInto                     { gui="bold", fg="#b8b9c0", }, -- NeogitUnmergedInto xxx cterm=bold gui=bold guifg=#b8b9c0
		NeogitDiffDeleteHighlight              { bg="#3c4763", fg="#eef1f8", }, -- NeogitDiffDeleteHighlight xxx guifg=#eef1f8 guibg=#3c4763
		NeogitDiffDelete                       { bg="#3c4763", fg="#c3c6cb", }, -- NeogitDiffDelete xxx guifg=#c3c6cb guibg=#3c4763
		NeogitDiffContextHighlight             { bg="#23252a", }, -- NeogitDiffContextHighlight xxx guibg=#23252a
		NeogitPopupConfigKey                   { fg="#e0e2ea", }, -- NeogitPopupConfigKey xxx guifg=#e0e2ea
		NeogitDiffContext                      { bg="#181a1f", }, -- NeogitDiffContext xxx guibg=#181a1f
		NeogitDiffAddHighlight                 { bg="#005523", fg="#b3f6c0", }, -- NeogitDiffAddHighlight xxx guifg=#b3f6c0 guibg=#005523
		NeogitDiffAdd                          { bg="#005523", fg="#93ca9d", }, -- NeogitDiffAdd  xxx guifg=#93ca9d guibg=#005523
		NeogitPopupSwitchKey                   { fg="#e0e2ea", }, -- NeogitPopupSwitchKey xxx guifg=#e0e2ea
		NeogitPopupBold                        { gui="bold", }, -- NeogitPopupBold xxx cterm=bold gui=bold
		NeogitGraphBoldGray                    { gui="bold", fg="#727376", }, -- NeogitGraphBoldGray xxx cterm=bold gui=bold guifg=#727376
		NeogitGraphBoldPurple                  { gui="bold", fg="#e0e2ea", }, -- NeogitGraphBoldPurple xxx cterm=bold gui=bold guifg=#e0e2ea
		NeogitGraphBoldBlue                    { gui="bold", fg="#e0e2ea", }, -- NeogitGraphBoldBlue xxx cterm=bold gui=bold guifg=#e0e2ea
		NeogitGraphBoldCyan                    { gui="bold", fg="#e0e2ea", }, -- NeogitGraphBoldCyan xxx cterm=bold gui=bold guifg=#e0e2ea
		NeogitGraphBoldGreen                   { gui="bold", fg="#b3f6c0", }, -- NeogitGraphBoldGreen xxx cterm=bold gui=bold guifg=#b3f6c0
		NeogitGraphBoldYellow                  { gui="bold", fg="#e0e2ea", }, -- NeogitGraphBoldYellow xxx cterm=bold gui=bold guifg=#e0e2ea
		NeogitGraphBoldWhite                   { gui="bold", }, -- NeogitGraphBoldWhite xxx cterm=bold gui=bold
		NeogitGraphGray                        { fg="#727376", }, -- NeogitGraphGray xxx guifg=#727376
		NeogitGraphCyan                        { fg="#e0e2ea", }, -- NeogitGraphCyan xxx guifg=#e0e2ea
		NeogitChangeRenamed                    { gui="bold,italic", fg="#b8b9c0", }, -- NeogitChangeRenamed xxx cterm=bold,italic gui=bold,italic guifg=#b8b9c0
		NeogitChangeAdded                      { gui="bold,italic", fg="#93ca9d", }, -- NeogitChangeAdded xxx cterm=bold,italic gui=bold,italic guifg=#93ca9d
		NeogitUnpushedTo                       { gui="bold", fg="#b8b9c0", }, -- NeogitUnpushedTo xxx cterm=bold gui=bold guifg=#b8b9c0
		NeogitDiffHeaderHighlight              { bg="#2e3034", gui="bold", fg="#8cf8f7", }, -- NeogitDiffHeaderHighlight xxx cterm=bold gui=bold guifg=#8cf8f7 guibg=#2e3034
		NeogitCommitViewHeader                 { bg="#b8b9c0", fg="#14161b", }, -- NeogitCommitViewHeader xxx guifg=#14161b guibg=#b8b9c0
		NeogitFilePath                         { gui="italic", fg="#e0e2ea", }, -- NeogitFilePath xxx cterm=italic gui=italic guifg=#e0e2ea
		NeogitPopupActionKey                   { fg="#e0e2ea", }, -- NeogitPopupActionKey xxx guifg=#e0e2ea
		NeogitPopupOptionKey                   { fg="#e0e2ea", }, -- NeogitPopupOptionKey xxx guifg=#e0e2ea
		BufferLineNumbersSelected              { bg="#14161b", gui="bold,italic", fg="#e0e2ea", }, -- BufferLineNumbersSelected xxx cterm=bold,italic gui=bold,italic guifg=#e0e2ea guibg=#14161b
		BufferLineFill                         { bg="#0b0c0e", fg="#9b9ea4", }, -- BufferLineFill xxx guifg=#9b9ea4 guibg=#0b0c0e
		BufferLineBufferVisible                { bg="#121418", fg="#9b9ea4", }, -- BufferLineBufferVisible xxx guifg=#9b9ea4 guibg=#121418
		BufferLineCloseButtonSelected          { bg="#14161b", fg="#e0e2ea", }, -- BufferLineCloseButtonSelected xxx guifg=#e0e2ea guibg=#14161b
		BufferLineCloseButtonVisible           { bg="#121418", fg="#9b9ea4", }, -- BufferLineCloseButtonVisible xxx guifg=#9b9ea4 guibg=#121418
		BufferLineCloseButton                  { bg="#0f1014", fg="#9b9ea4", }, -- BufferLineCloseButton xxx guifg=#9b9ea4 guibg=#0f1014
		BufferLineTabClose                     { bg="#0f1014", fg="#9b9ea4", }, -- BufferLineTabClose xxx guifg=#9b9ea4 guibg=#0f1014
		BufferLineTabSelected                  { bg="#14161b", fg="#2c2e33", }, -- BufferLineTabSelected xxx guifg=#2c2e33 guibg=#14161b
		BufferLineGroupLabel                   { bg="#9b9ea4", fg="#0b0c0e", }, -- BufferLineGroupLabel xxx guifg=#0b0c0e guibg=#9b9ea4
		BufferLineTruncMarker                  { bg="#0b0c0e", fg="#9b9ea4", }, -- BufferLineTruncMarker xxx guifg=#9b9ea4 guibg=#0b0c0e
		BufferLinePickSelected                 { bg="#14161b", gui="bold,italic", fg="#ffc0b9", }, -- BufferLinePickSelected xxx cterm=bold,italic gui=bold,italic guifg=#ffc0b9 guibg=#14161b
		BufferLineIndicatorVisible             { bg="#121418", fg="#121418", }, -- BufferLineIndicatorVisible xxx guifg=#121418 guibg=#121418
		BufferLineIndicatorSelected            { bg="#14161b", fg="#2c2e33", }, -- BufferLineIndicatorSelected xxx guifg=#2c2e33 guibg=#14161b
		BufferLineTabSeparatorSelected         { bg="#14161b", fg="#0b0c0e", }, -- BufferLineTabSeparatorSelected xxx guifg=#0b0c0e guibg=#14161b
		BufferLineTabSeparator                 { bg="#0f1014", fg="#0b0c0e", }, -- BufferLineTabSeparator xxx guifg=#0b0c0e guibg=#0f1014
		BufferLineSeparatorVisible             { bg="#121418", fg="#0b0c0e", }, -- BufferLineSeparatorVisible xxx guifg=#0b0c0e guibg=#121418
		BufferLineDiagnostic                   { bg="#0f1014", fg="#74767b", }, -- BufferLineDiagnostic xxx guifg=#74767b guibg=#0f1014
		BufferLineDuplicate                    { bg="#0f1014", gui="italic", fg="#93969b", }, -- BufferLineDuplicate xxx cterm=italic gui=italic guifg=#93969b guibg=#0f1014
		BufferLineDuplicateVisible             { bg="#121418", gui="italic", fg="#93969b", }, -- BufferLineDuplicateVisible xxx cterm=italic gui=italic guifg=#93969b guibg=#121418
		BufferLineError                        { bg="#0f1014", fg="#9b9ea4", sp="#ffc0b9", }, -- BufferLineError xxx guifg=#9b9ea4 guibg=#0f1014 guisp=#ffc0b9
		BufferLineModifiedSelected             { bg="#14161b", fg="#b3f6c0", }, -- BufferLineModifiedSelected xxx guifg=#b3f6c0 guibg=#14161b
		BufferLineBuffer                       { bg="#0f1014", fg="#9b9ea4", }, -- BufferLineBuffer xxx guifg=#9b9ea4 guibg=#0f1014
		BufferLineErrorDiagnosticSelected      { bg="#14161b", gui="bold,italic", fg="#bf908a", sp="#bf908a", }, -- BufferLineErrorDiagnosticSelected xxx cterm=bold,italic gui=bold,italic guifg=#bf908a guibg=#14161b guisp=#bf908a
		BufferLineErrorDiagnosticVisible       { bg="#121418", fg="#74767b", }, -- BufferLineErrorDiagnosticVisible xxx guifg=#74767b guibg=#121418
		BufferLineErrorDiagnostic              { bg="#0f1014", fg="#74767b", sp="#bf908a", }, -- BufferLineErrorDiagnostic xxx guifg=#74767b guibg=#0f1014 guisp=#bf908a
		BufferLineErrorSelected                { bg="#14161b", gui="bold,italic", fg="#ffc0b9", sp="#ffc0b9", }, -- BufferLineErrorSelected xxx cterm=bold,italic gui=bold,italic guifg=#ffc0b9 guibg=#14161b guisp=#ffc0b9
		BufferLineErrorVisible                 { bg="#121418", fg="#9b9ea4", }, -- BufferLineErrorVisible xxx guifg=#9b9ea4 guibg=#121418
		BufferLineWarningDiagnosticSelected    { bg="#14161b", gui="bold,italic", fg="#bda86f", sp="#bda86f", }, -- BufferLineWarningDiagnosticSelected xxx cterm=bold,italic gui=bold,italic guifg=#bda86f guibg=#14161b guisp=#bda86f
		BufferLineGroupSeparator               { bg="#0b0c0e", fg="#9b9ea4", }, -- BufferLineGroupSeparator xxx guifg=#9b9ea4 guibg=#0b0c0e
		BufferLinePick                         { bg="#0f1014", gui="bold,italic", fg="#ffc0b9", }, -- BufferLinePick xxx cterm=bold,italic gui=bold,italic guifg=#ffc0b9 guibg=#0f1014
		BufferLineOffsetSeparator              { bg="#0b0c0e", fg="#e0e2ea", }, -- BufferLineOffsetSeparator xxx guifg=#e0e2ea guibg=#0b0c0e
		BufferLineNumbers                      { bg="#0f1014", fg="#9b9ea4", }, -- BufferLineNumbers xxx guifg=#9b9ea4 guibg=#0f1014
		BufferLinePickVisible                  { bg="#121418", gui="bold,italic", fg="#ffc0b9", }, -- BufferLinePickVisible xxx cterm=bold,italic gui=bold,italic guifg=#ffc0b9 guibg=#121418
		BufferLineSeparator                    { bg="#0f1014", fg="#0b0c0e", }, -- BufferLineSeparator xxx guifg=#0b0c0e guibg=#0f1014
		BufferLineSeparatorSelected            { bg="#14161b", fg="#0b0c0e", }, -- BufferLineSeparatorSelected xxx guifg=#0b0c0e guibg=#14161b
		BufferLineDuplicateSelected            { bg="#14161b", gui="italic", fg="#93969b", }, -- BufferLineDuplicateSelected xxx cterm=italic gui=italic guifg=#93969b guibg=#14161b
		BufferLineModifiedVisible              { bg="#121418", fg="#b3f6c0", }, -- BufferLineModifiedVisible xxx guifg=#b3f6c0 guibg=#121418
		BufferLineModified                     { bg="#0f1014", fg="#b3f6c0", }, -- BufferLineModified xxx guifg=#b3f6c0 guibg=#0f1014
		BufferLineInfo                         { bg="#0f1014", fg="#9b9ea4", sp="#8cf8f7", }, -- BufferLineInfo xxx guifg=#9b9ea4 guibg=#0f1014 guisp=#8cf8f7
		BufferLineWarning                      { bg="#0f1014", fg="#9b9ea4", sp="#fce094", }, -- BufferLineWarning xxx guifg=#9b9ea4 guibg=#0f1014 guisp=#fce094
		BufferLineBufferSelected               { bg="#14161b", gui="bold,italic", fg="#e0e2ea", }, -- BufferLineBufferSelected xxx cterm=bold,italic gui=bold,italic guifg=#e0e2ea guibg=#14161b
		BufferLineHint                         { bg="#0f1014", fg="#9b9ea4", sp="#a6dbff", }, -- BufferLineHint xxx guifg=#9b9ea4 guibg=#0f1014 guisp=#a6dbff
		BufferLineBackground                   { bg="#0f1014", fg="#9b9ea4", }, -- BufferLineBackground xxx guifg=#9b9ea4 guibg=#0f1014
		BufferLineTab                          { bg="#0f1014", fg="#9b9ea4", }, -- BufferLineTab  xxx guifg=#9b9ea4 guibg=#0f1014
		BufferLineWarningDiagnosticVisible     { bg="#121418", fg="#74767b", }, -- BufferLineWarningDiagnosticVisible xxx guifg=#74767b guibg=#121418
		BufferLineWarningDiagnostic            { bg="#0f1014", fg="#74767b", sp="#bda86f", }, -- BufferLineWarningDiagnostic xxx guifg=#74767b guibg=#0f1014 guisp=#bda86f
		BufferLineWarningSelected              { bg="#14161b", gui="bold,italic", fg="#fce094", sp="#fce094", }, -- BufferLineWarningSelected xxx cterm=bold,italic gui=bold,italic guifg=#fce094 guibg=#14161b guisp=#fce094
		BufferLineWarningVisible               { bg="#121418", fg="#9b9ea4", }, -- BufferLineWarningVisible xxx guifg=#9b9ea4 guibg=#121418
		BufferLineInfoDiagnosticSelected       { bg="#14161b", gui="bold,italic", fg="#69bab9", sp="#69bab9", }, -- BufferLineInfoDiagnosticSelected xxx cterm=bold,italic gui=bold,italic guifg=#69bab9 guibg=#14161b guisp=#69bab9
		BufferLineInfoDiagnosticVisible        { bg="#121418", fg="#74767b", }, -- BufferLineInfoDiagnosticVisible xxx guifg=#74767b guibg=#121418
		BufferLineInfoDiagnostic               { bg="#0f1014", fg="#74767b", sp="#69bab9", }, -- BufferLineInfoDiagnostic xxx guifg=#74767b guibg=#0f1014 guisp=#69bab9
		BufferLineInfoSelected                 { bg="#14161b", gui="bold,italic", fg="#8cf8f7", sp="#8cf8f7", }, -- BufferLineInfoSelected xxx cterm=bold,italic gui=bold,italic guifg=#8cf8f7 guibg=#14161b guisp=#8cf8f7
		BufferLineInfoVisible                  { bg="#121418", fg="#9b9ea4", }, -- BufferLineInfoVisible xxx guifg=#9b9ea4 guibg=#121418
		BufferLineHintDiagnosticSelected       { bg="#14161b", gui="bold,italic", fg="#7ca4bf", sp="#7ca4bf", }, -- BufferLineHintDiagnosticSelected xxx cterm=bold,italic gui=bold,italic guifg=#7ca4bf guibg=#14161b guisp=#7ca4bf
		BufferLineHintDiagnosticVisible        { bg="#121418", fg="#74767b", }, -- BufferLineHintDiagnosticVisible xxx guifg=#74767b guibg=#121418
		BufferLineHintDiagnostic               { bg="#0f1014", fg="#74767b", sp="#7ca4bf", }, -- BufferLineHintDiagnostic xxx guifg=#74767b guibg=#0f1014 guisp=#7ca4bf
		BufferLineHintSelected                 { bg="#14161b", gui="bold,italic", fg="#a6dbff", sp="#a6dbff", }, -- BufferLineHintSelected xxx cterm=bold,italic gui=bold,italic guifg=#a6dbff guibg=#14161b guisp=#a6dbff
		BufferLineHintVisible                  { bg="#121418", fg="#9b9ea4", }, -- BufferLineHintVisible xxx guifg=#9b9ea4 guibg=#121418
		BufferLineDiagnosticSelected           { bg="#14161b", gui="bold,italic", fg="#a8a9af", }, -- BufferLineDiagnosticSelected xxx cterm=bold,italic gui=bold,italic guifg=#a8a9af guibg=#14161b
		BufferLineDiagnosticVisible            { bg="#121418", fg="#74767b", }, -- BufferLineDiagnosticVisible xxx guifg=#74767b guibg=#121418
		BufferLineNumbersVisible               { bg="#121418", fg="#9b9ea4", }, -- BufferLineNumbersVisible xxx guifg=#9b9ea4 guibg=#121418
		GitSignsAdd                            { fg="#5de4c7", }, -- GitSignsAdd    xxx guifg=#5de4c7
		GitSignsUntracked                      { GitSignsAdd }, -- GitSignsUntracked xxx links to GitSignsAdd
		GitSignsAddNr                          { GitSignsAdd }, -- GitSignsAddNr  xxx links to GitSignsAdd
		SignAdd                                { GitSignsAdd }, -- SignAdd        xxx links to GitSignsAdd
		GitSignsChange                         { fg="#add7ff", }, -- GitSignsChange xxx guifg=#add7ff
		GitSignsChangedelete                   { GitSignsChange }, -- GitSignsChangedelete xxx links to GitSignsChange
		GitSignsChangeNr                       { GitSignsChange }, -- GitSignsChangeNr xxx links to GitSignsChange
		SignChange                             { GitSignsChange }, -- SignChange     xxx links to GitSignsChange
		GitSignsDelete                         { fg="#d0679d", }, -- GitSignsDelete xxx guifg=#d0679d
		GitSignsTopdelete                      { GitSignsDelete }, -- GitSignsTopdelete xxx links to GitSignsDelete
		GitSignsDeleteNr                       { GitSignsDelete }, -- GitSignsDeleteNr xxx links to GitSignsDelete
		SignDelete                             { GitSignsDelete }, -- SignDelete     xxx links to GitSignsDelete
		GitSignsStagedAdd                      { fg="#597b60", }, -- GitSignsStagedAdd xxx guifg=#597b60
		GitSignsStagedChange                   { fg="#467c7b", }, -- GitSignsStagedChange xxx guifg=#467c7b
		GitSignsStagedDelete                   { fg="#7f605c", }, -- GitSignsStagedDelete xxx guifg=#7f605c
		GitSignsStagedChangedelete             { fg="#467c7b", }, -- GitSignsStagedChangedelete xxx guifg=#467c7b
		GitSignsStagedTopdelete                { fg="#7f605c", }, -- GitSignsStagedTopdelete xxx guifg=#7f605c
		GitSignsStagedAddNr                    { fg="#597b60", }, -- GitSignsStagedAddNr xxx guifg=#597b60
		GitSignsStagedChangeNr                 { fg="#467c7b", }, -- GitSignsStagedChangeNr xxx guifg=#467c7b
		GitSignsStagedDeleteNr                 { fg="#7f605c", }, -- GitSignsStagedDeleteNr xxx guifg=#7f605c
		GitSignsStagedChangedeleteNr           { fg="#467c7b", }, -- GitSignsStagedChangedeleteNr xxx guifg=#467c7b
		GitSignsStagedTopdeleteNr              { fg="#7f605c", }, -- GitSignsStagedTopdeleteNr xxx guifg=#7f605c
		GitSignsStagedAddLn                    { bg="#005523", fg="#77787c", }, -- GitSignsStagedAddLn xxx guifg=#77787c guibg=#005523
		GitSignsStagedChangeLn                 { bg="#4f5258", fg="#77787c", }, -- GitSignsStagedChangeLn xxx guifg=#77787c guibg=#4f5258
		GitSignsStagedChangedeleteLn           { bg="#4f5258", fg="#77787c", }, -- GitSignsStagedChangedeleteLn xxx guifg=#77787c guibg=#4f5258
		DapUIScope                             { fg="#00f1f5", }, -- DapUIScope     xxx guifg=#00f1f5
		DapUIType                              { fg="#d484ff", }, -- DapUIType      xxx guifg=#d484ff
		DapUIModifiedValue                     { gui="bold", fg="#00f1f5", }, -- DapUIModifiedValue xxx gui=bold guifg=#00f1f5
		DapUIDecoration                        { fg="#00f1f5", }, -- DapUIDecoration xxx guifg=#00f1f5
		DapUIThread                            { fg="#a9ff68", }, -- DapUIThread    xxx guifg=#a9ff68
		DapUIStoppedThread                     { fg="#00f1f5", }, -- DapUIStoppedThread xxx guifg=#00f1f5
		DapUISource                            { fg="#d484ff", }, -- DapUISource    xxx guifg=#d484ff
		DapUILineNumber                        { fg="#00f1f5", }, -- DapUILineNumber xxx guifg=#00f1f5
		DapUIBreakpointsLine                   { DapUILineNumber }, -- DapUIBreakpointsLine xxx links to DapUILineNumber
		DapUIFloatBorder                       { fg="#00f1f5", }, -- DapUIFloatBorder xxx guifg=#00f1f5
		DapUIWatchesEmpty                      { fg="#f70067", }, -- DapUIWatchesEmpty xxx guifg=#f70067
		DapUIWatchesValue                      { fg="#a9ff68", }, -- DapUIWatchesValue xxx guifg=#a9ff68
		DapUIWatchesError                      { fg="#f70067", }, -- DapUIWatchesError xxx guifg=#f70067
		DapUIBreakpointsPath                   { fg="#00f1f5", }, -- DapUIBreakpointsPath xxx guifg=#00f1f5
		DapUIBreakpointsInfo                   { fg="#a9ff68", }, -- DapUIBreakpointsInfo xxx guifg=#a9ff68
		DapUIBreakpointsCurrentLine            { gui="bold", fg="#a9ff68", }, -- DapUIBreakpointsCurrentLine xxx gui=bold guifg=#a9ff68
		DapUICurrentFrameName                  { DapUIBreakpointsCurrentLine }, -- DapUICurrentFrameName xxx links to DapUIBreakpointsCurrentLine
		DapUIBreakpointsDisabledLine           { fg="#424242", }, -- DapUIBreakpointsDisabledLine xxx guifg=#424242
		DapUIStepOver                          { fg="#00f1f5", }, -- DapUIStepOver  xxx guifg=#00f1f5
		DapUIStepInto                          { fg="#00f1f5", }, -- DapUIStepInto  xxx guifg=#00f1f5
		DapUIStepBack                          { fg="#00f1f5", }, -- DapUIStepBack  xxx guifg=#00f1f5
		DapUIStepOut                           { fg="#00f1f5", }, -- DapUIStepOut   xxx guifg=#00f1f5
		DapUIStop                              { fg="#f70067", }, -- DapUIStop      xxx guifg=#f70067
		DapUIPlayPause                         { fg="#a9ff68", }, -- DapUIPlayPause xxx guifg=#a9ff68
		DapUIRestart                           { fg="#a9ff68", }, -- DapUIRestart   xxx guifg=#a9ff68
		DapUIUnavailable                       { fg="#424242", }, -- DapUIUnavailable xxx guifg=#424242
		DapUIWinSelect                         { gui="bold", fg="#00f1f5", }, -- DapUIWinSelect xxx ctermfg=14 gui=bold guifg=#00f1f5
		DapUINormalNC                          { bg="#07080d", }, -- DapUINormalNC  xxx guibg=#07080d
		DapUIPlayPauseNC                       { bg="#07080d", fg="#a9ff68", }, -- DapUIPlayPauseNC xxx guifg=#a9ff68 guibg=#07080d
		DapUIRestartNC                         { bg="#07080d", fg="#a9ff68", }, -- DapUIRestartNC xxx guifg=#a9ff68 guibg=#07080d
		DapUIStopNC                            { bg="#07080d", fg="#f70067", }, -- DapUIStopNC    xxx guifg=#f70067 guibg=#07080d
		DapUIUnavailableNC                     { bg="#07080d", fg="#424242", }, -- DapUIUnavailableNC xxx guifg=#424242 guibg=#07080d
		DapUIStepOverNC                        { bg="#07080d", fg="#00f1f5", }, -- DapUIStepOverNC xxx guifg=#00f1f5 guibg=#07080d
		DapUIStepIntoNC                        { bg="#07080d", fg="#00f1f5", }, -- DapUIStepIntoNC xxx guifg=#00f1f5 guibg=#07080d
		DapUIStepBackNC                        { bg="#07080d", fg="#00f1f5", }, -- DapUIStepBackNC xxx guifg=#00f1f5 guibg=#07080d
		DapUIStepOutNC                         { bg="#07080d", fg="#00f1f5", }, -- DapUIStepOutNC xxx guifg=#00f1f5 guibg=#07080d
		DevIconDefault                         { fg="#6d8086", }, -- DevIconDefault xxx ctermfg=66 guifg=#6d8086
		DevIconRar                             { fg="#eca517", }, -- DevIconRar     xxx ctermfg=214 guifg=#eca517
		DevIconConf                            { fg="#6d8086", }, -- DevIconConf    xxx ctermfg=66 guifg=#6d8086
		DevIconCSharpProject                   { fg="#512bd4", }, -- DevIconCSharpProject xxx ctermfg=56 guifg=#512bd4
		DevIconQt                              { fg="#40cd52", }, -- DevIconQt      xxx ctermfg=77 guifg=#40cd52
		DevIconRss                             { fg="#fb9d3b", }, -- DevIconRss     xxx ctermfg=215 guifg=#fb9d3b
		DevIconLocalization                    { fg="#2596be", }, -- DevIconLocalization xxx ctermfg=31 guifg=#2596be
		DevIconThunderbird                     { fg="#137be1", }, -- DevIconThunderbird xxx ctermfg=33 guifg=#137be1
		DevIconPxi                             { fg="#5aa7e4", }, -- DevIconPxi     xxx ctermfg=39 guifg=#5aa7e4
		DevIcon3DObjectFile                    { fg="#888888", }, -- DevIcon3DObjectFile xxx ctermfg=102 guifg=#888888
		DevIconR                               { fg="#2266ba", }, -- DevIconR       xxx ctermfg=25 guifg=#2266ba
		DevIconKotlin                          { fg="#7f52ff", }, -- DevIconKotlin  xxx ctermfg=99 guifg=#7f52ff
		DevIconKotlinScript                    { fg="#7f52ff", }, -- DevIconKotlinScript xxx ctermfg=99 guifg=#7f52ff
		DevIconTerminal                        { fg="#31b53e", }, -- DevIconTerminal xxx ctermfg=34 guifg=#31b53e
		DevIconJl                              { fg="#a270ba", }, -- DevIconJl      xxx ctermfg=133 guifg=#a270ba
		DevIconPart                            { fg="#44cda8", }, -- DevIconPart    xxx ctermfg=43 guifg=#44cda8
		DevIconVRML                            { fg="#888888", }, -- DevIconVRML    xxx ctermfg=102 guifg=#888888
		DevIconPrisma                          { fg="#5a67d8", }, -- DevIconPrisma  xxx ctermfg=62 guifg=#5a67d8
		DevIconOggVorbis                       { fg="#0075aa", }, -- DevIconOggVorbis xxx ctermfg=24 guifg=#0075aa
		DevIconNswag                           { fg="#85ea2d", }, -- DevIconNswag   xxx ctermfg=112 guifg=#85ea2d
		DevIconNfo                             { fg="#ffffcd", }, -- DevIconNfo     xxx ctermfg=230 guifg=#ffffcd
		DevIconPl                              { fg="#519aba", }, -- DevIconPl      xxx ctermfg=74 guifg=#519aba
		DevIconEx                              { fg="#a074c4", }, -- DevIconEx      xxx ctermfg=140 guifg=#a074c4
		DevIconPhp                             { fg="#a074c4", }, -- DevIconPhp     xxx ctermfg=140 guifg=#a074c4
		DevIconMpp                             { fg="#519aba", }, -- DevIconMpp     xxx ctermfg=74 guifg=#519aba
		DevIconBibTeX                          { fg="#cbcb41", }, -- DevIconBibTeX  xxx ctermfg=185 guifg=#cbcb41
		DevIconMp4                             { fg="#fd971f", }, -- DevIconMp4     xxx ctermfg=208 guifg=#fd971f
		DevIconMPEGAudioLayerIII               { fg="#00afff", }, -- DevIconMPEGAudioLayerIII xxx ctermfg=39 guifg=#00afff
		DevIconH                               { fg="#a074c4", }, -- DevIconH       xxx ctermfg=140 guifg=#a074c4
		DevIconMOV                             { fg="#fd971f", }, -- DevIconMOV     xxx ctermfg=208 guifg=#fd971f
		DevIconOrgMode                         { fg="#77aa99", }, -- DevIconOrgMode xxx ctermfg=73 guifg=#77aa99
		DevIconMobi                            { fg="#eab16d", }, -- DevIconMobi    xxx ctermfg=215 guifg=#eab16d
		DevIconAwk                             { fg="#4d5a5e", }, -- DevIconAwk     xxx ctermfg=240 guifg=#4d5a5e
		DevIconAstro                           { fg="#e23f67", }, -- DevIconAstro   xxx ctermfg=197 guifg=#e23f67
		DevIconImage                           { fg="#d0bec8", }, -- DevIconImage   xxx ctermfg=181 guifg=#d0bec8
		DevIconMkv                             { fg="#fd971f", }, -- DevIconMkv     xxx ctermfg=208 guifg=#fd971f
		DevIconXresources                      { fg="#e54d18", }, -- DevIconXresources xxx ctermfg=196 guifg=#e54d18
		DevIconNix                             { fg="#7ebae4", }, -- DevIconNix     xxx ctermfg=110 guifg=#7ebae4
		DevIconJsx                             { fg="#20c2e3", }, -- DevIconJsx     xxx ctermfg=45 guifg=#20c2e3
		DevIconLuau                            { fg="#00a2ff", }, -- DevIconLuau    xxx ctermfg=75 guifg=#00a2ff
		DevIconsbt                             { fg="#cc3e44", }, -- DevIconsbt     xxx ctermfg=167 guifg=#cc3e44
		DevIconStaticLibraryArchive            { fg="#dcddd6", }, -- DevIconStaticLibraryArchive xxx ctermfg=253 guifg=#dcddd6
		DevIconGulpfile                        { fg="#cc3e44", }, -- DevIconGulpfile xxx ctermfg=167 guifg=#cc3e44
		DevIconSvg                             { fg="#ffb13b", }, -- DevIconSvg     xxx ctermfg=214 guifg=#ffb13b
		DevIconRmd                             { fg="#519aba", }, -- DevIconRmd     xxx ctermfg=74 guifg=#519aba
		DevIconGruntfile                       { fg="#e37933", }, -- DevIconGruntfile xxx ctermfg=166 guifg=#e37933
		DevIconZshrc                           { fg="#89e051", }, -- DevIconZshrc   xxx ctermfg=113 guifg=#89e051
		DevIconGradleWrapperProperties         { fg="#005f87", }, -- DevIconGradleWrapperProperties xxx ctermfg=24 guifg=#005f87
		DevIconGradleProperties                { fg="#005f87", }, -- DevIconGradleProperties xxx ctermfg=24 guifg=#005f87
		DevIconTex                             { fg="#3d6117", }, -- DevIconTex     xxx ctermfg=22 guifg=#3d6117
		DevIconFreeCADConfig                   { fg="#cb0d0d", }, -- DevIconFreeCADConfig xxx ctermfg=160 guifg=#cb0d0d
		DevIconKiCadFootprintTable             { fg="#ffffff", }, -- DevIconKiCadFootprintTable xxx ctermfg=231 guifg=#ffffff
		DevIconLinux                           { fg="#fdfdfb", }, -- DevIconLinux   xxx ctermfg=231 guifg=#fdfdfb
		DevIconKiCadCache                      { fg="#ffffff", }, -- DevIconKiCadCache xxx ctermfg=231 guifg=#ffffff
		DevIconCp                              { fg="#519aba", }, -- DevIconCp      xxx ctermfg=74 guifg=#519aba
		DevIconFavicon                         { fg="#cbcb41", }, -- DevIconFavicon xxx ctermfg=185 guifg=#cbcb41
		DevIconTypoScriptSetup                 { fg="#ff8700", }, -- DevIconTypoScriptSetup xxx ctermfg=208 guifg=#ff8700
		DevIconMarkdown                        { fg="#dddddd", }, -- DevIconMarkdown xxx ctermfg=253 guifg=#dddddd
		DevIconDockerfile                      { fg="#458ee6", }, -- DevIconDockerfile xxx ctermfg=68 guifg=#458ee6
		DevIconZip                             { fg="#eca517", }, -- DevIconZip     xxx ctermfg=214 guifg=#eca517
		DevIconHtml                            { fg="#e44d26", }, -- DevIconHtml    xxx ctermfg=196 guifg=#e44d26
		DevIconCss                             { fg="#42a5f5", }, -- DevIconCss     xxx ctermfg=75 guifg=#42a5f5
		DevIconXz                              { fg="#eca517", }, -- DevIconXz      xxx ctermfg=214 guifg=#eca517
		DevIconBSPWM                           { fg="#4f4f4f", }, -- DevIconBSPWM   xxx ctermfg=239 guifg=#4f4f4f
		DevIconXpi                             { fg="#ff1b01", }, -- DevIconXpi     xxx ctermfg=196 guifg=#ff1b01
		DevIconJsonc                           { fg="#cbcb41", }, -- DevIconJsonc   xxx ctermfg=185 guifg=#cbcb41
		DevIconVimrc                           { fg="#019833", }, -- DevIconVimrc   xxx ctermfg=28 guifg=#019833
		DevIconGvimrc                          { fg="#019833", }, -- DevIconGvimrc  xxx ctermfg=28 guifg=#019833
		DevIconMd5                             { fg="#8c86af", }, -- DevIconMd5     xxx ctermfg=103 guifg=#8c86af
		DevIcon7z                              { fg="#eca517", }, -- DevIcon7z      xxx ctermfg=214 guifg=#eca517
		DevIconXcLocalization                  { fg="#2596be", }, -- DevIconXcLocalization xxx ctermfg=31 guifg=#2596be
		DevIconXInitrc                         { fg="#e54d18", }, -- DevIconXInitrc xxx ctermfg=196 guifg=#e54d18
		DevIconJava                            { fg="#cc3e44", }, -- DevIconJava    xxx ctermfg=167 guifg=#cc3e44
		DevIconXauthority                      { fg="#e54d18", }, -- DevIconXauthority xxx ctermfg=196 guifg=#e54d18
		DevIconGIMP                            { fg="#635b46", }, -- DevIconGIMP    xxx ctermfg=240 guifg=#635b46
		DevIconDll                             { fg="#4d2c0b", }, -- DevIconDll     xxx ctermfg=52 guifg=#4d2c0b
		DevIconSettingsJson                    { fg="#854cc7", }, -- DevIconSettingsJson xxx ctermfg=98 guifg=#854cc7
		DevIconXaml                            { fg="#512bd4", }, -- DevIconXaml    xxx ctermfg=56 guifg=#512bd4
		DevIconLogos                           { fg="#599eff", }, -- DevIconLogos   xxx ctermfg=111 guifg=#599eff
		DevIconIni                             { fg="#6d8086", }, -- DevIconIni     xxx ctermfg=66 guifg=#6d8086
		DevIconMd                              { fg="#dddddd", }, -- DevIconMd      xxx ctermfg=253 guifg=#dddddd
		DevIconGTK                             { fg="#ffffff", }, -- DevIconGTK     xxx ctermfg=231 guifg=#ffffff
		DevIconGitlabCI                        { fg="#e24329", }, -- DevIconGitlabCI xxx ctermfg=196 guifg=#e24329
		DevIconHurl                            { fg="#ff0288", }, -- DevIconHurl    xxx ctermfg=198 guifg=#ff0288
		DevIconTempl                           { fg="#dbbd30", }, -- DevIconTempl   xxx ctermfg=178 guifg=#dbbd30
		DevIconWebOpenFontFormat               { fg="#ececec", }, -- DevIconWebOpenFontFormat xxx ctermfg=255 guifg=#ececec
		DevIconWindowsMediaAudio               { fg="#00afff", }, -- DevIconWindowsMediaAudio xxx ctermfg=39 guifg=#00afff
		DevIconEslintIgnore                    { fg="#4b32c3", }, -- DevIconEslintIgnore xxx ctermfg=56 guifg=#4b32c3
		DevIconEnv                             { fg="#faf743", }, -- DevIconEnv     xxx ctermfg=227 guifg=#faf743
		DevIconYaml                            { fg="#6d8086", }, -- DevIconYaml    xxx ctermfg=66 guifg=#6d8086
		DevIconCMake                           { fg="#6d8086", }, -- DevIconCMake   xxx ctermfg=66 guifg=#6d8086
		DevIconVsix                            { fg="#854cc7", }, -- DevIconVsix    xxx ctermfg=98 guifg=#854cc7
		DevIconOpenBSD                         { fg="#f2ca30", }, -- DevIconOpenBSD xxx ctermfg=220 guifg=#f2ca30
		DevIconFreeBSD                         { fg="#c90f02", }, -- DevIconFreeBSD xxx ctermfg=160 guifg=#c90f02
		DevIconVue                             { fg="#8dc149", }, -- DevIconVue     xxx ctermfg=113 guifg=#8dc149
		DevIconSharedObject                    { fg="#dcddd6", }, -- DevIconSharedObject xxx ctermfg=253 guifg=#dcddd6
		DevIconGradleWrapperScript             { fg="#005f87", }, -- DevIconGradleWrapperScript xxx ctermfg=24 guifg=#005f87
		DevIconVala                            { fg="#7239b3", }, -- DevIconVala    xxx ctermfg=91 guifg=#7239b3
		DevIconDesktopEntry                    { fg="#563d7c", }, -- DevIconDesktopEntry xxx ctermfg=54 guifg=#563d7c
		DevIconXorgConf                        { fg="#e54d18", }, -- DevIconXorgConf xxx ctermfg=196 guifg=#e54d18
		DevIconPKGBUILD                        { fg="#0f94d2", }, -- DevIconPKGBUILD xxx ctermfg=67 guifg=#0f94d2
		DevIconTypoScript                      { fg="#ff8700", }, -- DevIconTypoScript xxx ctermfg=208 guifg=#ff8700
		DevIconBashrc                          { fg="#89e051", }, -- DevIconBashrc  xxx ctermfg=113 guifg=#89e051
		DevIconTwig                            { fg="#8dc149", }, -- DevIconTwig    xxx ctermfg=113 guifg=#8dc149
		DevIconGo                              { fg="#519aba", }, -- DevIconGo      xxx ctermfg=74 guifg=#519aba
		DevIconToml                            { fg="#9c4221", }, -- DevIconToml    xxx ctermfg=124 guifg=#9c4221
		DevIconTmux                            { fg="#14ba19", }, -- DevIconTmux    xxx ctermfg=34 guifg=#14ba19
		DevIconGradleSettings                  { fg="#005f87", }, -- DevIconGradleSettings xxx ctermfg=24 guifg=#005f87
		DevIconGradleBuildScript               { fg="#005f87", }, -- DevIconGradleBuildScript xxx ctermfg=24 guifg=#005f87
		DevIconQuery                           { fg="#90a850", }, -- DevIconQuery   xxx ctermfg=107 guifg=#90a850
		DevIconMixLock                         { fg="#a074c4", }, -- DevIconMixLock xxx ctermfg=140 guifg=#a074c4
		DevIconWindows                         { fg="#00a4ef", }, -- DevIconWindows xxx ctermfg=39 guifg=#00a4ef
		DevIconEditorConfig                    { fg="#fff2f2", }, -- DevIconEditorConfig xxx ctermfg=255 guifg=#fff2f2
		DevIconTcl                             { fg="#1e5cb3", }, -- DevIconTcl     xxx ctermfg=25 guifg=#1e5cb3
		DevIconMpv                             { fg="#3b1342", }, -- DevIconMpv     xxx ctermfg=53 guifg=#3b1342
		DevIconTerraform                       { fg="#5f43e9", }, -- DevIconTerraform xxx ctermfg=93 guifg=#5f43e9
		DevIconCoffee                          { fg="#cbcb41", }, -- DevIconCoffee  xxx ctermfg=185 guifg=#cbcb41
		DevIconBmp                             { fg="#a074c4", }, -- DevIconBmp     xxx ctermfg=140 guifg=#a074c4
		DevIconGitAttributes                   { fg="#f54d27", }, -- DevIconGitAttributes xxx ctermfg=196 guifg=#f54d27
		DevIconGemfile                         { fg="#701516", }, -- DevIconGemfile xxx ctermfg=52 guifg=#701516
		DevIconBrewfile                        { fg="#701516", }, -- DevIconBrewfile xxx ctermfg=52 guifg=#701516
		DevIconAvif                            { fg="#a074c4", }, -- DevIconAvif    xxx ctermfg=140 guifg=#a074c4
		DevIconNPMrc                           { fg="#e8274b", }, -- DevIconNPMrc   xxx ctermfg=197 guifg=#e8274b
		DevIconLicense                         { fg="#cbcb41", }, -- DevIconLicense xxx ctermfg=185 guifg=#cbcb41
		DevIconVagrantfile                     { fg="#1563ff", }, -- DevIconVagrantfile xxx ctermfg=27 guifg=#1563ff
		DevIconOpenTypeFont                    { fg="#ececec", }, -- DevIconOpenTypeFont xxx ctermfg=255 guifg=#ececec
		DevIconPng                             { fg="#a074c4", }, -- DevIconPng     xxx ctermfg=140 guifg=#a074c4
		DevIconPpt                             { fg="#cb4a32", }, -- DevIconPpt     xxx ctermfg=160 guifg=#cb4a32
		DevIconPsd                             { fg="#519aba", }, -- DevIconPsd     xxx ctermfg=74 guifg=#519aba
		DevIconZsh                             { fg="#89e051", }, -- DevIconZsh     xxx ctermfg=113 guifg=#89e051
		DevIconBzl                             { fg="#89e051", }, -- DevIconBzl     xxx ctermfg=113 guifg=#89e051
		DevIconBackup                          { fg="#6d8086", }, -- DevIconBackup  xxx ctermfg=66 guifg=#6d8086
		DevIconDiff                            { fg="#41535b", }, -- DevIconDiff    xxx ctermfg=239 guifg=#41535b
		DevIconSql                             { fg="#dad8d8", }, -- DevIconSql     xxx ctermfg=188 guifg=#dad8d8
		DevIconPm                              { fg="#519aba", }, -- DevIconPm      xxx ctermfg=74 guifg=#519aba
		DevIconJson                            { fg="#cbcb41", }, -- DevIconJson    xxx ctermfg=185 guifg=#cbcb41
		DevIconVim                             { fg="#019833", }, -- DevIconVim     xxx ctermfg=28 guifg=#019833
		DevIconCobol                           { fg="#005ca5", }, -- DevIconCobol   xxx ctermfg=25 guifg=#005ca5
		DevIconTxt                             { fg="#89e051", }, -- DevIconTxt     xxx ctermfg=113 guifg=#89e051
		DevIconScalaScript                     { fg="#cc3e44", }, -- DevIconScalaScript xxx ctermfg=167 guifg=#cc3e44
		DevIconProlog                          { fg="#e4b854", }, -- DevIconProlog  xxx ctermfg=179 guifg=#e4b854
		DevIconMXLinux                         { fg="#ffffff", }, -- DevIconMXLinux xxx ctermfg=231 guifg=#ffffff
		DevIconManjaro                         { fg="#33b959", }, -- DevIconManjaro xxx ctermfg=35 guifg=#33b959
		DevIconElisp                           { fg="#8172be", }, -- DevIconElisp   xxx ctermfg=97 guifg=#8172be
		DevIconTypeScript                      { fg="#519aba", }, -- DevIconTypeScript xxx ctermfg=74 guifg=#519aba
		DevIconScss                            { fg="#f55385", }, -- DevIconScss    xxx ctermfg=204 guifg=#f55385
		DevIconSig                             { fg="#e37933", }, -- DevIconSig     xxx ctermfg=166 guifg=#e37933
		DevIconKsh                             { fg="#4d5a5e", }, -- DevIconKsh     xxx ctermfg=240 guifg=#4d5a5e
		DevIconLXLE                            { fg="#474747", }, -- DevIconLXLE    xxx ctermfg=238 guifg=#474747
		DevIconScala                           { fg="#cc3e44", }, -- DevIconScala   xxx ctermfg=167 guifg=#cc3e44
		DevIconLocOS                           { fg="#fab402", }, -- DevIconLocOS   xxx ctermfg=214 guifg=#fab402
		DevIconAutoCADDxf                      { fg="#839463", }, -- DevIconAutoCADDxf xxx ctermfg=101 guifg=#839463
		DevIconKubuntu                         { fg="#007ac2", }, -- DevIconKubuntu xxx ctermfg=32 guifg=#007ac2
		DevIconLog                             { fg="#dddddd", }, -- DevIconLog     xxx ctermfg=253 guifg=#dddddd
		DevIconObjectiveCPlusPlus              { fg="#519aba", }, -- DevIconObjectiveCPlusPlus xxx ctermfg=74 guifg=#519aba
		DevIconKDEneon                         { fg="#20a6a4", }, -- DevIconKDEneon xxx ctermfg=37 guifg=#20a6a4
		DevIconKali                            { fg="#2777ff", }, -- DevIconKali    xxx ctermfg=69 guifg=#2777ff
		DevIconCPlusPlus                       { fg="#f34b7d", }, -- DevIconCPlusPlus xxx ctermfg=204 guifg=#f34b7d
		DevIconIllumos                         { fg="#ff430f", }, -- DevIconIllumos xxx ctermfg=196 guifg=#ff430f
		DevIconHyperbolaGNULinuxLibre          { fg="#c0c0c0", }, -- DevIconHyperbolaGNULinuxLibre xxx ctermfg=250 guifg=#c0c0c0
		DevIconGuix                            { fg="#ffcc00", }, -- DevIconGuix    xxx ctermfg=220 guifg=#ffcc00
		DevIconGentoo                          { fg="#b1abce", }, -- DevIconGentoo  xxx ctermfg=146 guifg=#b1abce
		DevIconGarudaLinux                     { fg="#2974e1", }, -- DevIconGarudaLinux xxx ctermfg=33 guifg=#2974e1
		DevIconVoid                            { fg="#295340", }, -- DevIconVoid    xxx ctermfg=23 guifg=#295340
		DevIconFedora                          { fg="#072a5e", }, -- DevIconFedora  xxx ctermfg=17 guifg=#072a5e
		DevIconCsh                             { fg="#4d5a5e", }, -- DevIconCsh     xxx ctermfg=240 guifg=#4d5a5e
		DevIconEndeavour                       { fg="#7b3db9", }, -- DevIconEndeavour xxx ctermfg=91 guifg=#7b3db9
		DevIconElementary                      { fg="#5890c2", }, -- DevIconElementary xxx ctermfg=67 guifg=#5890c2
		DevIconDevuan                          { fg="#404a52", }, -- DevIconDevuan  xxx ctermfg=238 guifg=#404a52
		DevIconDeepin                          { fg="#2ca7f8", }, -- DevIconDeepin  xxx ctermfg=39 guifg=#2ca7f8
		DevIconDebian                          { fg="#a80030", }, -- DevIconDebian  xxx ctermfg=88 guifg=#a80030
		DevIconCrystalLinux                    { fg="#a900ff", }, -- DevIconCrystalLinux xxx ctermfg=129 guifg=#a900ff
		DevIconBigLinux                        { fg="#189fc8", }, -- DevIconBigLinux xxx ctermfg=38 guifg=#189fc8
		DevIconArtix                           { fg="#41b4d7", }, -- DevIconArtix   xxx ctermfg=38 guifg=#41b4d7
		DevIconBazelBuild                      { fg="#89e051", }, -- DevIconBazelBuild xxx ctermfg=113 guifg=#89e051
		DevIconArcoLinux                       { fg="#6690eb", }, -- DevIconArcoLinux xxx ctermfg=68 guifg=#6690eb
		DevIconCts                             { fg="#519aba", }, -- DevIconCts     xxx ctermfg=74 guifg=#519aba
		DevIconArchlabs                        { fg="#503f42", }, -- DevIconArchlabs xxx ctermfg=238 guifg=#503f42
		DevIconInfo                            { fg="#ffffcd", }, -- DevIconInfo    xxx ctermfg=230 guifg=#ffffcd
		DevIconArchcraft                       { fg="#86bba3", }, -- DevIconArchcraft xxx ctermfg=108 guifg=#86bba3
		DevIconAsciinema                       { fg="#fd971f", }, -- DevIconAsciinema xxx ctermfg=208 guifg=#fd971f
		DevIconAOSC                            { fg="#c00000", }, -- DevIconAOSC    xxx ctermfg=124 guifg=#c00000
		DevIconAlpine                          { fg="#0d597f", }, -- DevIconAlpine  xxx ctermfg=24 guifg=#0d597f
		DevIconSass                            { fg="#f55385", }, -- DevIconSass    xxx ctermfg=204 guifg=#f55385
		DevIconLuaurc                          { fg="#00a2ff", }, -- DevIconLuaurc  xxx ctermfg=75 guifg=#00a2ff
		DevIconFsi                             { fg="#519aba", }, -- DevIconFsi     xxx ctermfg=74 guifg=#519aba
		DevIconFsx                             { fg="#519aba", }, -- DevIconFsx     xxx ctermfg=74 guifg=#519aba
		DevIconBabelrc                         { fg="#cbcb41", }, -- DevIconBabelrc xxx ctermfg=185 guifg=#cbcb41
		DevIconGodotTextScene                  { fg="#6d8086", }, -- DevIconGodotTextScene xxx ctermfg=66 guifg=#6d8086
		DevIconAppleScript                     { fg="#6d8085", }, -- DevIconAppleScript xxx ctermfg=66 guifg=#6d8085
		DevIconGDScript                        { fg="#6d8086", }, -- DevIconGDScript xxx ctermfg=66 guifg=#6d8086
		DevIconBash                            { fg="#89e051", }, -- DevIconBash    xxx ctermfg=113 guifg=#89e051
		DevIconXml                             { fg="#e37933", }, -- DevIconXml     xxx ctermfg=166 guifg=#e37933
		DevIconGraphQL                         { fg="#e535ab", }, -- DevIconGraphQL xxx ctermfg=199 guifg=#e535ab
		DevIconSub                             { fg="#ffb713", }, -- DevIconSub     xxx ctermfg=214 guifg=#ffb713
		DevIconAss                             { fg="#ffb713", }, -- DevIconAss     xxx ctermfg=214 guifg=#ffb713
		DevIconErb                             { fg="#701516", }, -- DevIconErb     xxx ctermfg=52 guifg=#701516
		DevIconSrt                             { fg="#ffb713", }, -- DevIconSrt     xxx ctermfg=214 guifg=#ffb713
		DevIconHs                              { fg="#a074c4", }, -- DevIconHs      xxx ctermfg=140 guifg=#a074c4
		DevIconErl                             { fg="#b83998", }, -- DevIconErl     xxx ctermfg=163 guifg=#b83998
		DevIconEpp                             { fg="#ffa61a", }, -- DevIconEpp     xxx ctermfg=214 guifg=#ffa61a
		DevIconWebp                            { fg="#a074c4", }, -- DevIconWebp    xxx ctermfg=140 guifg=#a074c4
		DevIconWebm                            { fg="#fd971f", }, -- DevIconWebm    xxx ctermfg=208 guifg=#fd971f
		DevIconExs                             { fg="#a074c4", }, -- DevIconExs     xxx ctermfg=140 guifg=#a074c4
		DevIconSublime                         { fg="#e37933", }, -- DevIconSublime xxx ctermfg=166 guifg=#e37933
		DevIconElf                             { fg="#9f0500", }, -- DevIconElf     xxx ctermfg=124 guifg=#9f0500
		DevIconLeex                            { fg="#a074c4", }, -- DevIconLeex    xxx ctermfg=140 guifg=#a074c4
		DevIconRlib                            { fg="#dea584", }, -- DevIconRlib    xxx ctermfg=216 guifg=#dea584
		DevIconPyo                             { fg="#ffe291", }, -- DevIconPyo     xxx ctermfg=222 guifg=#ffe291
		DevIconPyd                             { fg="#ffe291", }, -- DevIconPyd     xxx ctermfg=222 guifg=#ffe291
		DevIconPyc                             { fg="#ffe291", }, -- DevIconPyc     xxx ctermfg=222 guifg=#ffe291
		DevIconPsb                             { fg="#519aba", }, -- DevIconPsb     xxx ctermfg=74 guifg=#519aba
		DevIconProcfile                        { fg="#a074c4", }, -- DevIconProcfile xxx ctermfg=140 guifg=#a074c4
		DevIconPackedResource                  { fg="#6d8086", }, -- DevIconPackedResource xxx ctermfg=66 guifg=#6d8086
		DevIconOpusAudioFile                   { fg="#0075aa", }, -- DevIconOpusAudioFile xxx ctermfg=24 guifg=#0075aa
		DevIconMint                            { fg="#87c095", }, -- DevIconMint    xxx ctermfg=108 guifg=#87c095
		DevIconMdx                             { fg="#519aba", }, -- DevIconMdx     xxx ctermfg=74 guifg=#519aba
		DevIconMaterial                        { fg="#b83998", }, -- DevIconMaterial xxx ctermfg=163 guifg=#b83998
		DevIconGv                              { fg="#30638e", }, -- DevIconGv      xxx ctermfg=24 guifg=#30638e
		DevIconIco                             { fg="#cbcb41", }, -- DevIconIco     xxx ctermfg=185 guifg=#cbcb41
		DevIconSln                             { fg="#854cc7", }, -- DevIconSln     xxx ctermfg=98 guifg=#854cc7
		DevIconHaxe                            { fg="#ea8220", }, -- DevIconHaxe    xxx ctermfg=208 guifg=#ea8220
		DevIconGodotProject                    { fg="#6d8086", }, -- DevIconGodotProject xxx ctermfg=66 guifg=#6d8086
		DevIconBinaryGLTF                      { fg="#ffb13b", }, -- DevIconBinaryGLTF xxx ctermfg=214 guifg=#ffb13b
		DevIconSml                             { fg="#e37933", }, -- DevIconSml     xxx ctermfg=166 guifg=#e37933
		DevIconFsscript                        { fg="#519aba", }, -- DevIconFsscript xxx ctermfg=74 guifg=#519aba
		DevIconEjs                             { fg="#cbcb41", }, -- DevIconEjs     xxx ctermfg=185 guifg=#cbcb41
		DevIconDrools                          { fg="#ffafaf", }, -- DevIconDrools  xxx ctermfg=217 guifg=#ffafaf
		DevIconBin                             { fg="#9f0500", }, -- DevIconBin     xxx ctermfg=124 guifg=#9f0500
		DevIconVerilog                         { fg="#019833", }, -- DevIconVerilog xxx ctermfg=28 guifg=#019833
		DevIconFsharp                          { fg="#519aba", }, -- DevIconFsharp  xxx ctermfg=74 guifg=#519aba
		DevIconDocx                            { fg="#185abd", }, -- DevIconDocx    xxx ctermfg=26 guifg=#185abd
		DevIconSolidity                        { fg="#519aba", }, -- DevIconSolidity xxx ctermfg=74 guifg=#519aba
		DevIconRazorPage                       { fg="#512bd4", }, -- DevIconRazorPage xxx ctermfg=56 guifg=#512bd4
		DevIconTxz                             { fg="#eca517", }, -- DevIconTxz     xxx ctermfg=214 guifg=#eca517
		DevIconTrueTypeFont                    { fg="#ececec", }, -- DevIconTrueTypeFont xxx ctermfg=255 guifg=#ececec
		DevIconCxxm                            { fg="#519aba", }, -- DevIconCxxm    xxx ctermfg=74 guifg=#519aba
		DevIconCppm                            { fg="#519aba", }, -- DevIconCppm    xxx ctermfg=74 guifg=#519aba
		DevIconCPlusPlusModule                 { fg="#f34b7d", }, -- DevIconCPlusPlusModule xxx ctermfg=204 guifg=#f34b7d
		DevIconHpp                             { fg="#a074c4", }, -- DevIconHpp     xxx ctermfg=140 guifg=#a074c4
		DevIconHxx                             { fg="#a074c4", }, -- DevIconHxx     xxx ctermfg=140 guifg=#a074c4
		DevIconPyi                             { fg="#ffbc03", }, -- DevIconPyi     xxx ctermfg=214 guifg=#ffbc03
		DevIconHh                              { fg="#a074c4", }, -- DevIconHh      xxx ctermfg=140 guifg=#a074c4
		DevIconTorrent                         { fg="#44cda8", }, -- DevIconTorrent xxx ctermfg=43 guifg=#44cda8
		DevIconPyx                             { fg="#5aa7e4", }, -- DevIconPyx     xxx ctermfg=39 guifg=#5aa7e4
		DevIconxmonad                          { fg="#fd4d5d", }, -- DevIconxmonad  xxx ctermfg=203 guifg=#fd4d5d
		DevIconSway                            { fg="#68751c", }, -- DevIconSway    xxx ctermfg=64 guifg=#68751c
		DevIconPsScriptfile                    { fg="#4273ca", }, -- DevIconPsScriptfile xxx ctermfg=68 guifg=#4273ca
		DevIconPsScriptModulefile              { fg="#6975c4", }, -- DevIconPsScriptModulefile xxx ctermfg=68 guifg=#6975c4
		DevIconPsManifestfile                  { fg="#6975c4", }, -- DevIconPsManifestfile xxx ctermfg=68 guifg=#6975c4
		DevIconJWM                             { fg="#0078cd", }, -- DevIconJWM     xxx ctermfg=32 guifg=#0078cd
		DevIconi3                              { fg="#e8ebee", }, -- DevIconi3      xxx ctermfg=255 guifg=#e8ebee
		DevIconHyprland                        { fg="#00aaae", }, -- DevIconHyprland xxx ctermfg=37 guifg=#00aaae
		DevIconAi                              { fg="#cbcb41", }, -- DevIconAi      xxx ctermfg=185 guifg=#cbcb41
		DevIconFluxbox                         { fg="#555555", }, -- DevIconFluxbox xxx ctermfg=240 guifg=#555555
		DevIconEnlightenment                   { fg="#ffffff", }, -- DevIconEnlightenment xxx ctermfg=231 guifg=#ffffff
		DevIcondwm                             { fg="#1177aa", }, -- DevIcondwm     xxx ctermfg=31 guifg=#1177aa
		DevIconUI                              { fg="#0c306e", }, -- DevIconUI      xxx ctermfg=17 guifg=#0c306e
		DevIconawesome                         { fg="#535d6c", }, -- DevIconawesome xxx ctermfg=59 guifg=#535d6c
		DevIconXfce                            { fg="#00aadf", }, -- DevIconXfce    xxx ctermfg=74 guifg=#00aadf
		DevIconLhs                             { fg="#a074c4", }, -- DevIconLhs     xxx ctermfg=140 guifg=#a074c4
		DevIconKDEPlasma                       { fg="#1b89f4", }, -- DevIconKDEPlasma xxx ctermfg=33 guifg=#1b89f4
		DevIconMATE                            { fg="#9bda5c", }, -- DevIconMATE    xxx ctermfg=113 guifg=#9bda5c
		DevIconSignature                       { fg="#e37933", }, -- DevIconSignature xxx ctermfg=166 guifg=#e37933
		DevIconLXQt                            { fg="#0191d2", }, -- DevIconLXQt    xxx ctermfg=32 guifg=#0191d2
		DevIconLXDE                            { fg="#a4a4a4", }, -- DevIconLXDE    xxx ctermfg=248 guifg=#a4a4a4
		DevIconGNOME                           { fg="#ffffff", }, -- DevIconGNOME   xxx ctermfg=231 guifg=#ffffff
		DevIconCinnamon                        { fg="#dc682e", }, -- DevIconCinnamon xxx ctermfg=166 guifg=#dc682e
		DevIconConfiguration                   { fg="#6d8086", }, -- DevIconConfiguration xxx ctermfg=66 guifg=#6d8086
		DevIconMjs                             { fg="#f1e05a", }, -- DevIconMjs     xxx ctermfg=185 guifg=#f1e05a
		DevIconJs                              { fg="#cbcb41", }, -- DevIconJs      xxx ctermfg=185 guifg=#cbcb41
		DevIconCjs                             { fg="#cbcb41", }, -- DevIconCjs     xxx ctermfg=185 guifg=#cbcb41
		DevIconZorin                           { fg="#14a1e8", }, -- DevIconZorin   xxx ctermfg=39 guifg=#14a1e8
		DevIconStep                            { fg="#839463", }, -- DevIconStep    xxx ctermfg=101 guifg=#839463
		DevIconXeroLinux                       { fg="#888fe2", }, -- DevIconXeroLinux xxx ctermfg=104 guifg=#888fe2
		DevIconVanillaOS                       { fg="#fabd4d", }, -- DevIconVanillaOS xxx ctermfg=214 guifg=#fabd4d
		DevIconNotebook                        { fg="#51a0cf", }, -- DevIconNotebook xxx ctermfg=74 guifg=#51a0cf
		DevIconOut                             { fg="#9f0500", }, -- DevIconOut     xxx ctermfg=124 guifg=#9f0500
		DevIconCpp                             { fg="#519aba", }, -- DevIconCpp     xxx ctermfg=74 guifg=#519aba
		DevIconSsa                             { fg="#ffb713", }, -- DevIconSsa     xxx ctermfg=214 guifg=#ffb713
		DevIconTypeScriptDeclaration           { fg="#d59855", }, -- DevIconTypeScriptDeclaration xxx ctermfg=172 guifg=#d59855
		DevIconTrisquelGNULinux                { fg="#0f58b6", }, -- DevIconTrisquelGNULinux xxx ctermfg=25 guifg=#0f58b6
		DevIconJson5                           { fg="#cbcb41", }, -- DevIconJson5   xxx ctermfg=185 guifg=#cbcb41
		DevIconWebmanifest                     { fg="#f1e05a", }, -- DevIconWebmanifest xxx ctermfg=185 guifg=#f1e05a
		DevIconTails                           { fg="#56347c", }, -- DevIconTails   xxx ctermfg=54 guifg=#56347c
		DevIconSpecJs                          { fg="#cbcb41", }, -- DevIconSpecJs  xxx ctermfg=185 guifg=#cbcb41
		DevIconJpg                             { fg="#a074c4", }, -- DevIconJpg     xxx ctermfg=140 guifg=#a074c4
		DevIconSolus                           { fg="#4b5163", }, -- DevIconSolus   xxx ctermfg=239 guifg=#4b5163
		DevIconImportConfiguration             { fg="#ececec", }, -- DevIconImportConfiguration xxx ctermfg=255 guifg=#ececec
		DevIconPulseCodeModulation             { fg="#0075aa", }, -- DevIconPulseCodeModulation xxx ctermfg=24 guifg=#0075aa
		DevIconJpeg                            { fg="#a074c4", }, -- DevIconJpeg    xxx ctermfg=140 guifg=#a074c4
		DevIconSlackware                       { fg="#475fa9", }, -- DevIconSlackware xxx ctermfg=61 guifg=#475fa9
		DevIconCxx                             { fg="#519aba", }, -- DevIconCxx     xxx ctermfg=74 guifg=#519aba
		DevIconRproj                           { fg="#358a5b", }, -- DevIconRproj   xxx ctermfg=29 guifg=#358a5b
		DevIconQubesOS                         { fg="#3774d8", }, -- DevIconQubesOS xxx ctermfg=33 guifg=#3774d8
		DevIconSabayon                         { fg="#c6c6c6", }, -- DevIconSabayon xxx ctermfg=251 guifg=#c6c6c6
		DevIconRs                              { fg="#dea584", }, -- DevIconRs      xxx ctermfg=216 guifg=#dea584
		DevIconRake                            { fg="#701516", }, -- DevIconRake    xxx ctermfg=52 guifg=#701516
		DevIconGemspec                         { fg="#701516", }, -- DevIconGemspec xxx ctermfg=52 guifg=#701516
		DevIconRockyLinux                      { fg="#0fb37d", }, -- DevIconRockyLinux xxx ctermfg=36 guifg=#0fb37d
		DevIconBat                             { fg="#c1f12e", }, -- DevIconBat     xxx ctermfg=191 guifg=#c1f12e
		DevIconLess                            { fg="#563d7c", }, -- DevIconLess    xxx ctermfg=54 guifg=#563d7c
		DevIconCs                              { fg="#596706", }, -- DevIconCs      xxx ctermfg=58 guifg=#596706
		DevIconRedhat                          { fg="#ee0000", }, -- DevIconRedhat  xxx ctermfg=196 guifg=#ee0000
		DevIconHeex                            { fg="#a074c4", }, -- DevIconHeex    xxx ctermfg=140 guifg=#a074c4
		DevIconMaven                           { fg="#7a0d21", }, -- DevIconMaven   xxx ctermfg=52 guifg=#7a0d21
		DevIconNPMIgnore                       { fg="#e8274b", }, -- DevIconNPMIgnore xxx ctermfg=197 guifg=#e8274b
		DevIconRaspberryPiOS                   { fg="#be1848", }, -- DevIconRaspberryPiOS xxx ctermfg=161 guifg=#be1848
		DevIconConfigRu                        { fg="#701516", }, -- DevIconConfigRu xxx ctermfg=52 guifg=#701516
		DevIconRb                              { fg="#701516", }, -- DevIconRb      xxx ctermfg=52 guifg=#701516
		DevIconLibrecadFontFile                { fg="#ececec", }, -- DevIconLibrecadFontFile xxx ctermfg=255 guifg=#ececec
		DevIconPrettierConfig                  { fg="#4285f4", }, -- DevIconPrettierConfig xxx ctermfg=33 guifg=#4285f4
		DevIconParabolaGNULinuxLibre           { fg="#797dac", }, -- DevIconParabolaGNULinuxLibre xxx ctermfg=103 guifg=#797dac
		DevIconClojureDart                     { fg="#519aba", }, -- DevIconClojureDart xxx ctermfg=74 guifg=#519aba
		DevIconPuppyLinux                      { fg="#a2aeb9", }, -- DevIconPuppyLinux xxx ctermfg=145 guifg=#a2aeb9
		DevIconapk                             { fg="#34a853", }, -- DevIconapk     xxx ctermfg=35 guifg=#34a853
		DevIconopenSUSE                        { fg="#6fb424", }, -- DevIconopenSUSE xxx ctermfg=70 guifg=#6fb424
		DevIconLiquid                          { fg="#95bf47", }, -- DevIconLiquid  xxx ctermfg=106 guifg=#95bf47
		DevIconpostmarketOS                    { fg="#009900", }, -- DevIconpostmarketOS xxx ctermfg=28 guifg=#009900
		DevIconBlender                         { fg="#ea7600", }, -- DevIconBlender xxx ctermfg=208 guifg=#ea7600
		DevIconCMakeLists                      { fg="#6d8086", }, -- DevIconCMakeLists xxx ctermfg=66 guifg=#6d8086
		DevIconPop_OS                          { fg="#48b9c7", }, -- DevIconPop_OS  xxx ctermfg=73 guifg=#48b9c7
		DevIconGroovy                          { fg="#4a687c", }, -- DevIconGroovy  xxx ctermfg=24 guifg=#4a687c
		DevIconReScriptInterface               { fg="#f55385", }, -- DevIconReScriptInterface xxx ctermfg=204 guifg=#f55385
		DevIconGitIgnore                       { fg="#f54d27", }, -- DevIconGitIgnore xxx ctermfg=196 guifg=#f54d27
		DevIconReScript                        { fg="#cc3e44", }, -- DevIconReScript xxx ctermfg=167 guifg=#cc3e44
		DevIconBz3                             { fg="#eca517", }, -- DevIconBz3     xxx ctermfg=214 guifg=#eca517
		DevIconCrdownload                      { fg="#44cda8", }, -- DevIconCrdownload xxx ctermfg=43 guifg=#44cda8
		DevIconBz2                             { fg="#eca517", }, -- DevIconBz2     xxx ctermfg=214 guifg=#eca517
		DevIconKiCad                           { fg="#ffffff", }, -- DevIconKiCad   xxx ctermfg=231 guifg=#ffffff
		DevIconBz                              { fg="#eca517", }, -- DevIconBz      xxx ctermfg=214 guifg=#eca517
		DevIconBoundaryRepresentation          { fg="#839463", }, -- DevIconBoundaryRepresentation xxx ctermfg=101 guifg=#839463
		DevIconSRCINFO                         { fg="#0f94d2", }, -- DevIconSRCINFO xxx ctermfg=67 guifg=#0f94d2
		DevIconLock                            { fg="#bbbbbb", }, -- DevIconLock    xxx ctermfg=250 guifg=#bbbbbb
		DevIconIcal                            { fg="#2b2e83", }, -- DevIconIcal    xxx ctermfg=18 guifg=#2b2e83
		DevIconIxx                             { fg="#519aba", }, -- DevIconIxx     xxx ctermfg=74 guifg=#519aba
		DevIconNushell                         { fg="#3aa675", }, -- DevIconNushell xxx ctermfg=36 guifg=#3aa675
		DevIconNixOS                           { fg="#7ab1db", }, -- DevIconNixOS   xxx ctermfg=110 guifg=#7ab1db
		DevIconPls                             { fg="#ed95ae", }, -- DevIconPls     xxx ctermfg=211 guifg=#ed95ae
		DevIconMagnet                          { fg="#a51b16", }, -- DevIconMagnet  xxx ctermfg=124 guifg=#a51b16
		DevIconSha1                            { fg="#8c86af", }, -- DevIconSha1    xxx ctermfg=103 guifg=#8c86af
		DevIconCue                             { fg="#ed95ae", }, -- DevIconCue     xxx ctermfg=211 guifg=#ed95ae
		DevIconSha224                          { fg="#8c86af", }, -- DevIconSha224  xxx ctermfg=103 guifg=#8c86af
		DevIconM4V                             { fg="#fd971f", }, -- DevIconM4V     xxx ctermfg=208 guifg=#fd971f
		DevIconSystemVerilog                   { fg="#019833", }, -- DevIconSystemVerilog xxx ctermfg=28 guifg=#019833
		DevIconMPEG4                           { fg="#00afff", }, -- DevIconMPEG4   xxx ctermfg=39 guifg=#00afff
		DevIconSha512                          { fg="#8c86af", }, -- DevIconSha512  xxx ctermfg=103 guifg=#8c86af
		DevIconAlmalinux                       { fg="#ff4649", }, -- DevIconAlmalinux xxx ctermfg=203 guifg=#ff4649
		DevIconApple                           { fg="#a2aaad", }, -- DevIconApple   xxx ctermfg=248 guifg=#a2aaad
		DevIconPrusaSlicer                     { fg="#ec6b23", }, -- DevIconPrusaSlicer xxx ctermfg=202 guifg=#ec6b23
		DevIconLua                             { fg="#51a0cf", }, -- DevIconLua     xxx ctermfg=74 guifg=#51a0cf
		DevIconTSConfig                        { fg="#519aba", }, -- DevIconTSConfig xxx ctermfg=74 guifg=#519aba
		DevIconPdf                             { fg="#b30b00", }, -- DevIconPdf     xxx ctermfg=124 guifg=#b30b00
		DevIconGitConfig                       { fg="#f54d27", }, -- DevIconGitConfig xxx ctermfg=196 guifg=#f54d27
		DevIconAzureCli                        { fg="#0078d4", }, -- DevIconAzureCli xxx ctermfg=32 guifg=#0078d4
		DevIconFish                            { fg="#4d5a5e", }, -- DevIconFish    xxx ctermfg=240 guifg=#4d5a5e
		DevIconM3u8                            { fg="#ed95ae", }, -- DevIconM3u8    xxx ctermfg=211 guifg=#ed95ae
		DevIconM3u                             { fg="#ed95ae", }, -- DevIconM3u     xxx ctermfg=211 guifg=#ed95ae
		DevIconFennel                          { fg="#fff3d7", }, -- DevIconFennel  xxx ctermfg=230 guifg=#fff3d7
		DevIconBlade                           { fg="#f05340", }, -- DevIconBlade   xxx ctermfg=203 guifg=#f05340
		DevIconGitModules                      { fg="#f54d27", }, -- DevIconGitModules xxx ctermfg=196 guifg=#f54d27
		DevIconHexadecimal                     { fg="#2e63ff", }, -- DevIconHexadecimal xxx ctermfg=27 guifg=#2e63ff
		DevIconAsc                             { fg="#576d7f", }, -- DevIconAsc     xxx ctermfg=242 guifg=#576d7f
		DevIconGitCommit                       { fg="#f54d27", }, -- DevIconGitCommit xxx ctermfg=196 guifg=#f54d27
		DevIconDump                            { fg="#dad8d8", }, -- DevIconDump    xxx ctermfg=188 guifg=#dad8d8
		DevIconObjectiveC                      { fg="#599eff", }, -- DevIconObjectiveC xxx ctermfg=111 guifg=#599eff
		DevIconTypeScriptReactTest             { fg="#1354bf", }, -- DevIconTypeScriptReactTest xxx ctermfg=26 guifg=#1354bf
		DevIconDot                             { fg="#30638e", }, -- DevIconDot     xxx ctermfg=24 guifg=#30638e
		DevIconDoc                             { fg="#185abd", }, -- DevIconDoc     xxx ctermfg=26 guifg=#185abd
		DevIconTestTs                          { fg="#519aba", }, -- DevIconTestTs  xxx ctermfg=74 guifg=#519aba
		DevIconcudah                           { fg="#a074c4", }, -- DevIconcudah   xxx ctermfg=140 guifg=#a074c4
		DevIconJavaScriptReactTest             { fg="#20c2e3", }, -- DevIconJavaScriptReactTest xxx ctermfg=45 guifg=#20c2e3
		DevIconMotoko                          { fg="#9772fb", }, -- DevIconMotoko  xxx ctermfg=135 guifg=#9772fb
		DevIconTestJs                          { fg="#cbcb41", }, -- DevIconTestJs  xxx ctermfg=185 guifg=#cbcb41
		DevIconPp                              { fg="#ffa61a", }, -- DevIconPp      xxx ctermfg=214 guifg=#ffa61a
		DevIconMageia                          { fg="#2397d4", }, -- DevIconMageia  xxx ctermfg=67 guifg=#2397d4
		DevIconEbook                           { fg="#eab16d", }, -- DevIconEbook   xxx ctermfg=215 guifg=#eab16d
		DevIconKrita                           { fg="#f245fb", }, -- DevIconKrita   xxx ctermfg=201 guifg=#f245fb
		DevIconAutoCADDwg                      { fg="#839463", }, -- DevIconAutoCADDwg xxx ctermfg=101 guifg=#839463
		DevIconAudioInterchangeFileFormat      { fg="#00afff", }, -- DevIconAudioInterchangeFileFormat xxx ctermfg=39 guifg=#00afff
		DevIconAdvancedAudioCoding             { fg="#00afff", }, -- DevIconAdvancedAudioCoding xxx ctermfg=39 guifg=#00afff
		DevIconLinuxKernelObject               { fg="#dcddd6", }, -- DevIconLinuxKernelObject xxx ctermfg=253 guifg=#dcddd6
		DevIcon3gp                             { fg="#fd971f", }, -- DevIcon3gp     xxx ctermfg=208 guifg=#fd971f
		DevIconMakefile                        { fg="#6d8086", }, -- DevIconMakefile xxx ctermfg=66 guifg=#6d8086
		DevIconZigObjectNotation               { fg="#f69a1b", }, -- DevIconZigObjectNotation xxx ctermfg=172 guifg=#f69a1b
		DevIconXSettingsdConf                  { fg="#e54d18", }, -- DevIconXSettingsdConf xxx ctermfg=196 guifg=#e54d18
		DevIconDropbox                         { fg="#0061fe", }, -- DevIconDropbox xxx ctermfg=27 guifg=#0061fe
		DevIconWasm                            { fg="#5c4cdb", }, -- DevIconWasm    xxx ctermfg=62 guifg=#5c4cdb
		DevIconXls                             { fg="#207245", }, -- DevIconXls     xxx ctermfg=29 guifg=#207245
		DevIconKdenlive                        { fg="#83b8f2", }, -- DevIconKdenlive xxx ctermfg=110 guifg=#83b8f2
		DevIconWebpack                         { fg="#519aba", }, -- DevIconWebpack xxx ctermfg=74 guifg=#519aba
		DevIconDownload                        { fg="#44cda8", }, -- DevIconDownload xxx ctermfg=43 guifg=#44cda8
		DevIconWeston                          { fg="#ffbb01", }, -- DevIconWeston  xxx ctermfg=214 guifg=#ffbb01
		DevIconKdbx                            { fg="#529b34", }, -- DevIconKdbx    xxx ctermfg=71 guifg=#529b34
		DevIconParrot                          { fg="#54deff", }, -- DevIconParrot  xxx ctermfg=45 guifg=#54deff
		DevIconVLC                             { fg="#ee7a00", }, -- DevIconVLC     xxx ctermfg=208 guifg=#ee7a00
		DevIconKdenliverc                      { fg="#83b8f2", }, -- DevIconKdenliverc xxx ctermfg=110 guifg=#83b8f2
		DevIconKdb                             { fg="#529b34", }, -- DevIconKdb     xxx ctermfg=71 guifg=#529b34
		DevIconFortran                         { fg="#734f96", }, -- DevIconFortran xxx ctermfg=97 guifg=#734f96
		DevIconSte                             { fg="#839463", }, -- DevIconSte     xxx ctermfg=101 guifg=#839463
		DevIconBudgie                          { fg="#4e5361", }, -- DevIconBudgie  xxx ctermfg=240 guifg=#4e5361
		DevIconHtm                             { fg="#e34c26", }, -- DevIconHtm     xxx ctermfg=196 guifg=#e34c26
		DevIconQtile                           { fg="#ffffff", }, -- DevIconQtile   xxx ctermfg=231 guifg=#ffffff
		DevIconJpegXl                          { fg="#a074c4", }, -- DevIconJpegXl  xxx ctermfg=140 guifg=#a074c4
		DevIconTailwindConfig                  { fg="#20c2e3", }, -- DevIconTailwindConfig xxx ctermfg=45 guifg=#20c2e3
		DevIconElm                             { fg="#519aba", }, -- DevIconElm     xxx ctermfg=74 guifg=#519aba
		DevIconTypeScriptReactSpec             { fg="#1354bf", }, -- DevIconTypeScriptReactSpec xxx ctermfg=26 guifg=#1354bf
		DevIconSpecTs                          { fg="#519aba", }, -- DevIconSpecTs  xxx ctermfg=74 guifg=#519aba
		DevIconKiCadSymbolTable                { fg="#ffffff", }, -- DevIconKiCadSymbolTable xxx ctermfg=231 guifg=#ffffff
		DevIconEex                             { fg="#a074c4", }, -- DevIconEex     xxx ctermfg=140 guifg=#a074c4
		DevIconSvelteConfig                    { fg="#ff3e00", }, -- DevIconSvelteConfig xxx ctermfg=196 guifg=#ff3e00
		DevIconHbs                             { fg="#f0772b", }, -- DevIconHbs     xxx ctermfg=202 guifg=#f0772b
		DevIconRakefile                        { fg="#701516", }, -- DevIconRakefile xxx ctermfg=52 guifg=#701516
		DevIconXsession                        { fg="#e54d18", }, -- DevIconXsession xxx ctermfg=196 guifg=#e54d18
		sym"DevIconPy.typed"                   { fg="#ffbc03", }, -- DevIconPy.typed xxx ctermfg=214 guifg=#ffbc03
		DevIconIso                             { fg="#d0bec8", }, -- DevIconIso     xxx ctermfg=181 guifg=#d0bec8
		DevIconEdn                             { fg="#519aba", }, -- DevIconEdn     xxx ctermfg=74 guifg=#519aba
		DevIconSolveSpace                      { fg="#839463", }, -- DevIconSolveSpace xxx ctermfg=101 guifg=#839463
		DevIconDb                              { fg="#dad8d8", }, -- DevIconDb      xxx ctermfg=188 guifg=#dad8d8
		DevIconClojureJS                       { fg="#519aba", }, -- DevIconClojureJS xxx ctermfg=74 guifg=#519aba
		DevIconClojureC                        { fg="#8dc149", }, -- DevIconClojureC xxx ctermfg=113 guifg=#8dc149
		DevIconClojure                         { fg="#8dc149", }, -- DevIconClojure xxx ctermfg=113 guifg=#8dc149
		DevIconSolidWorksPrt                   { fg="#839463", }, -- DevIconSolidWorksPrt xxx ctermfg=101 guifg=#839463
		DevIconSolidWorksAsm                   { fg="#839463", }, -- DevIconSolidWorksAsm xxx ctermfg=101 guifg=#839463
		DevIconSketchUp                        { fg="#839463", }, -- DevIconSketchUp xxx ctermfg=101 guifg=#839463
		DevIconIgs                             { fg="#839463", }, -- DevIconIgs     xxx ctermfg=101 guifg=#839463
		DevIconBazelWorkspace                  { fg="#89e051", }, -- DevIconBazelWorkspace xxx ctermfg=113 guifg=#89e051
		DevIconIges                            { fg="#839463", }, -- DevIconIges    xxx ctermfg=101 guifg=#839463
		DevIconLib                             { fg="#4d2c0b", }, -- DevIconLib     xxx ctermfg=52 guifg=#4d2c0b
		DevIconPackageLockJson                 { fg="#7a0d21", }, -- DevIconPackageLockJson xxx ctermfg=52 guifg=#7a0d21
		DevIconSha384                          { fg="#8c86af", }, -- DevIconSha384  xxx ctermfg=103 guifg=#8c86af
		DevIconD                               { fg="#427819", }, -- DevIconD       xxx ctermfg=28 guifg=#427819
		DevIconIfb                             { fg="#2b2e83", }, -- DevIconIfb     xxx ctermfg=18 guifg=#2b2e83
		DevIconVHDL                            { fg="#019833", }, -- DevIconVHDL    xxx ctermfg=28 guifg=#019833
		DevIconPxd                             { fg="#5aa7e4", }, -- DevIconPxd     xxx ctermfg=39 guifg=#5aa7e4
		DevIconIcs                             { fg="#2b2e83", }, -- DevIconIcs     xxx ctermfg=18 guifg=#2b2e83
		DevIconDart                            { fg="#03589c", }, -- DevIconDart    xxx ctermfg=25 guifg=#03589c
		DevIconIcalendar                       { fg="#2b2e83", }, -- DevIconIcalendar xxx ctermfg=18 guifg=#2b2e83
		DevIconCsv                             { fg="#89e051", }, -- DevIconCsv     xxx ctermfg=113 guifg=#89e051
		DevIconLXQtConfigFile                  { fg="#0192d3", }, -- DevIconLXQtConfigFile xxx ctermfg=32 guifg=#0192d3
		DevIconCache                           { fg="#ffffff", }, -- DevIconCache   xxx ctermfg=231 guifg=#ffffff
		DevIconStyl                            { fg="#8dc149", }, -- DevIconStyl    xxx ctermfg=113 guifg=#8dc149
		DevIconLXDEConfigFile                  { fg="#909090", }, -- DevIconLXDEConfigFile xxx ctermfg=246 guifg=#909090
		DevIconPackageJson                     { fg="#e8274b", }, -- DevIconPackageJson xxx ctermfg=197 guifg=#e8274b
		DevIconFs                              { fg="#519aba", }, -- DevIconFs      xxx ctermfg=74 guifg=#519aba
		DevIconKritarc                         { fg="#f245fb", }, -- DevIconKritarc xxx ctermfg=201 guifg=#f245fb
		DevIconVlang                           { fg="#5d87bf", }, -- DevIconVlang   xxx ctermfg=67 guifg=#5d87bf
		DevIconKritadisplayrc                  { fg="#f245fb", }, -- DevIconKritadisplayrc xxx ctermfg=201 guifg=#f245fb
		DevIconEslintrc                        { fg="#4b32c3", }, -- DevIconEslintrc xxx ctermfg=56 guifg=#4b32c3
		DevIconHuff                            { fg="#4242c7", }, -- DevIconHuff    xxx ctermfg=56 guifg=#4242c7
		DevIconZshenv                          { fg="#89e051", }, -- DevIconZshenv  xxx ctermfg=113 guifg=#89e051
		DevIconKdenliveLayoutsrc               { fg="#83b8f2", }, -- DevIconKdenliveLayoutsrc xxx ctermfg=110 guifg=#83b8f2
		DevIconBazel                           { fg="#89e051", }, -- DevIconBazel   xxx ctermfg=113 guifg=#89e051
		DevIconKDEglobals                      { fg="#1c99f3", }, -- DevIconKDEglobals xxx ctermfg=32 guifg=#1c99f3
		DevIconMts                             { fg="#519aba", }, -- DevIconMts     xxx ctermfg=74 guifg=#519aba
		DevIconTFVars                          { fg="#5f43e9", }, -- DevIconTFVars  xxx ctermfg=93 guifg=#5f43e9
		DevIconBicep                           { fg="#519aba", }, -- DevIconBicep   xxx ctermfg=74 guifg=#519aba
		DevIconKalgebrarc                      { fg="#1c99f3", }, -- DevIconKalgebrarc xxx ctermfg=32 guifg=#1c99f3
		DevIconBlueprint                       { fg="#5796e2", }, -- DevIconBlueprint xxx ctermfg=68 guifg=#5796e2
		DevIconCantorrc                        { fg="#1c99f3", }, -- DevIconCantorrc xxx ctermfg=32 guifg=#1c99f3
		DevIconTsx                             { fg="#1354bf", }, -- DevIconTsx     xxx ctermfg=26 guifg=#1354bf
		DevIconScheme                          { fg="#eeeeee", }, -- DevIconScheme  xxx ctermfg=255 guifg=#eeeeee
		DevIconTor                             { fg="#519aba", }, -- DevIconTor     xxx ctermfg=74 guifg=#519aba
		DevIconBicepParameters                 { fg="#9f74b3", }, -- DevIconBicepParameters xxx ctermfg=133 guifg=#9f74b3
		DevIconGodotTextResource               { fg="#6d8086", }, -- DevIconGodotTextResource xxx ctermfg=66 guifg=#6d8086
		DevIconTgz                             { fg="#eca517", }, -- DevIconTgz     xxx ctermfg=214 guifg=#eca517
		DevIconSwift                           { fg="#e37933", }, -- DevIconSwift   xxx ctermfg=166 guifg=#e37933
		DevIconSvelte                          { fg="#ff3e00", }, -- DevIconSvelte  xxx ctermfg=196 guifg=#ff3e00
		DevIconC                               { fg="#599eff", }, -- DevIconC       xxx ctermfg=111 guifg=#599eff
		DevIconSuo                             { fg="#854cc7", }, -- DevIconSuo     xxx ctermfg=98 guifg=#854cc7
		DevIconGz                              { fg="#eca517", }, -- DevIconGz      xxx ctermfg=214 guifg=#eca517
		DevIconTypoScriptConfig                { fg="#ff8700", }, -- DevIconTypoScriptConfig xxx ctermfg=208 guifg=#ff8700
		DevIconStp                             { fg="#839463", }, -- DevIconStp     xxx ctermfg=101 guifg=#839463
		DevIconXcPlayground                    { fg="#e37933", }, -- DevIconXcPlayground xxx ctermfg=166 guifg=#e37933
		DevIconSh                              { fg="#4d5a5e", }, -- DevIconSh      xxx ctermfg=240 guifg=#4d5a5e
		DevIconJavaScriptReactSpec             { fg="#20c2e3", }, -- DevIconJavaScriptReactSpec xxx ctermfg=45 guifg=#20c2e3
		DevIconConfig                          { fg="#6d8086", }, -- DevIconConfig  xxx ctermfg=66 guifg=#6d8086
		DevIconWaveformAudioFile               { fg="#00afff", }, -- DevIconWaveformAudioFile xxx ctermfg=39 guifg=#00afff
		DevIconKbx                             { fg="#737672", }, -- DevIconKbx     xxx ctermfg=243 guifg=#737672
		DevIconNodeModules                     { fg="#e8274b", }, -- DevIconNodeModules xxx ctermfg=197 guifg=#e8274b
		DevIconHaml                            { fg="#eaeae1", }, -- DevIconHaml    xxx ctermfg=255 guifg=#eaeae1
		DevIconLrc                             { fg="#ffb713", }, -- DevIconLrc     xxx ctermfg=214 guifg=#ffb713
		DevIconAndroid                         { fg="#34a853", }, -- DevIconAndroid xxx ctermfg=35 guifg=#34a853
		DevIconSha256                          { fg="#8c86af", }, -- DevIconSha256  xxx ctermfg=103 guifg=#8c86af
		DevIconGCode                           { fg="#1471ad", }, -- DevIconGCode   xxx ctermfg=32 guifg=#1471ad
		DevIconPy                              { fg="#ffbc03", }, -- DevIconPy      xxx ctermfg=214 guifg=#ffbc03
		DevIconFreeCAD                         { fg="#cb0d0d", }, -- DevIconFreeCAD xxx ctermfg=160 guifg=#cb0d0d
		DevIconArch                            { fg="#0f94d2", }, -- DevIconArch    xxx ctermfg=67 guifg=#0f94d2
		DevIconOpenSCAD                        { fg="#f9d72c", }, -- DevIconOpenSCAD xxx ctermfg=220 guifg=#f9d72c
		DevIconBashProfile                     { fg="#89e051", }, -- DevIconBashProfile xxx ctermfg=113 guifg=#89e051
		DevIconCson                            { fg="#cbcb41", }, -- DevIconCson    xxx ctermfg=185 guifg=#cbcb41
		DevIconXlsx                            { fg="#207245", }, -- DevIconXlsx    xxx ctermfg=29 guifg=#207245
		DevIconPatch                           { fg="#41535b", }, -- DevIconPatch   xxx ctermfg=239 guifg=#41535b
		DevIconFIGletFontFormat                { fg="#ececec", }, -- DevIconFIGletFontFormat xxx ctermfg=255 guifg=#ececec
		DevIconZst                             { fg="#eca517", }, -- DevIconZst     xxx ctermfg=214 guifg=#eca517
		DevIconFIGletFontControl               { fg="#ececec", }, -- DevIconFIGletFontControl xxx ctermfg=255 guifg=#ececec
		DevIconCheckhealth                     { fg="#75b4fb", }, -- DevIconCheckhealth xxx ctermfg=75 guifg=#75b4fb
		DevIconFreeLosslessAudioCodec          { fg="#0075aa", }, -- DevIconFreeLosslessAudioCodec xxx ctermfg=24 guifg=#0075aa
		DevIconDconf                           { fg="#ffffff", }, -- DevIconDconf   xxx ctermfg=231 guifg=#ffffff
		DevIconFdmdownload                     { fg="#44cda8", }, -- DevIconFdmdownload xxx ctermfg=43 guifg=#44cda8
		DevIconZig                             { fg="#f69a1b", }, -- DevIconZig     xxx ctermfg=172 guifg=#f69a1b
		DevIconPlatformio                      { fg="#f6822b", }, -- DevIconPlatformio xxx ctermfg=208 guifg=#f6822b
		DevIconIfc                             { fg="#839463", }, -- DevIconIfc     xxx ctermfg=101 guifg=#839463
		DevIconGitLogo                         { fg="#f14c28", }, -- DevIconGitLogo xxx ctermfg=196 guifg=#f14c28
		DevIconDsStore                         { fg="#41535b", }, -- DevIconDsStore xxx ctermfg=239 guifg=#41535b
		DevIconIge                             { fg="#839463", }, -- DevIconIge     xxx ctermfg=101 guifg=#839463
		DevIconImg                             { fg="#d0bec8", }, -- DevIconImg     xxx ctermfg=181 guifg=#d0bec8
		DevIconFusion360                       { fg="#839463", }, -- DevIconFusion360 xxx ctermfg=101 guifg=#839463
		DevIconNim                             { fg="#f3d400", }, -- DevIconNim     xxx ctermfg=220 guifg=#f3d400
		DevIconSlim                            { fg="#e34c26", }, -- DevIconSlim    xxx ctermfg=196 guifg=#e34c26
		DevIconExe                             { fg="#9f0500", }, -- DevIconExe     xxx ctermfg=124 guifg=#9f0500
		DevIconMli                             { fg="#e37933", }, -- DevIconMli     xxx ctermfg=166 guifg=#e37933
		DevIconMonkeysAudio                    { fg="#00afff", }, -- DevIconMonkeysAudio xxx ctermfg=39 guifg=#00afff
		DevIconObjectFile                      { fg="#9f0500", }, -- DevIconObjectFile xxx ctermfg=124 guifg=#9f0500
		DevIconEpub                            { fg="#eab16d", }, -- DevIconEpub    xxx ctermfg=215 guifg=#eab16d
		DevIconMustache                        { fg="#e37933", }, -- DevIconMustache xxx ctermfg=166 guifg=#e37933
		DevIconApp                             { fg="#9f0500", }, -- DevIconApp     xxx ctermfg=124 guifg=#9f0500
		DevIconEmbeddedOpenTypeFont            { fg="#ececec", }, -- DevIconEmbeddedOpenTypeFont xxx ctermfg=255 guifg=#ececec
		DevIconYml                             { fg="#6d8086", }, -- DevIconYml     xxx ctermfg=66 guifg=#6d8086
		DevIconMailmap                         { fg="#41535b", }, -- DevIconMailmap xxx ctermfg=239 guifg=#41535b
		DevIconZshprofile                      { fg="#89e051", }, -- DevIconZshprofile xxx ctermfg=113 guifg=#89e051
		DevIconUbuntu                          { fg="#dd4814", }, -- DevIconUbuntu  xxx ctermfg=196 guifg=#dd4814
		DevIconCrystal                         { fg="#c8c8c8", }, -- DevIconCrystal xxx ctermfg=251 guifg=#c8c8c8
		DevIconCentos                          { fg="#a2518d", }, -- DevIconCentos  xxx ctermfg=132 guifg=#a2518d
		DevIconcuda                            { fg="#89e051", }, -- DevIconcuda    xxx ctermfg=113 guifg=#89e051
		DevIconHrl                             { fg="#b83998", }, -- DevIconHrl     xxx ctermfg=163 guifg=#b83998
		DevIconArduino                         { fg="#56b6c2", }, -- DevIconArduino xxx ctermfg=73 guifg=#56b6c2
		DevIconMl                              { fg="#e37933", }, -- DevIconMl      xxx ctermfg=166 guifg=#e37933
		DevIconGif                             { fg="#a074c4", }, -- DevIconGif     xxx ctermfg=140 guifg=#a074c4
		DevIconXul                             { fg="#e37933", }, -- DevIconXul     xxx ctermfg=166 guifg=#e37933
		DevIconPub                             { fg="#e3c58e", }, -- DevIconPub     xxx ctermfg=222 guifg=#e3c58e
		ModesCopy                              { bg="#f5c359", }, -- ModesCopy      xxx guibg=#f5c359
		ModesDelete                            { bg="#c75c6a", }, -- ModesDelete    xxx guibg=#c75c6a
		ModesInsert                            { bg="#78ccc5", }, -- ModesInsert    xxx guibg=#78ccc5
		ModesVisual                            { bg="#9745be", }, -- ModesVisual    xxx guibg=#9745be
		ModesCopyCursorLine                    { bg="#251d0d", }, -- ModesCopyCursorLine xxx guibg=#251d0d
		ModesCopyCursorLineNr                  { bg="#251d0d", }, -- ModesCopyCursorLineNr xxx guibg=#251d0d
		ModesCopyCursorLineSign                { bg="#251d0d", }, -- ModesCopyCursorLineSign xxx guibg=#251d0d
		ModesCopyCursorLineFold                { bg="#251d0d", }, -- ModesCopyCursorLineFold xxx guibg=#251d0d
		ModesDeleteCursorLine                  { bg="#1e0e10", }, -- ModesDeleteCursorLine xxx guibg=#1e0e10
		ModesDeleteCursorLineNr                { bg="#1e0e10", }, -- ModesDeleteCursorLineNr xxx guibg=#1e0e10
		ModesDeleteCursorLineSign              { bg="#1e0e10", }, -- ModesDeleteCursorLineSign xxx guibg=#1e0e10
		ModesDeleteCursorLineFold              { bg="#1e0e10", }, -- ModesDeleteCursorLineFold xxx guibg=#1e0e10
		ModesInsertCursorLine                  { bg="#121f1e", }, -- ModesInsertCursorLine xxx guibg=#121f1e
		ModesInsertCursorLineNr                { bg="#121f1e", }, -- ModesInsertCursorLineNr xxx guibg=#121f1e
		ModesInsertCursorLineSign              { bg="#121f1e", }, -- ModesInsertCursorLineSign xxx guibg=#121f1e
		ModesInsertCursorLineFold              { bg="#121f1e", }, -- ModesInsertCursorLineFold xxx guibg=#121f1e
		ModesVisualCursorLine                  { bg="#170a1d", }, -- ModesVisualCursorLine xxx guibg=#170a1d
		ModesVisualCursorLineNr                { bg="#170a1d", }, -- ModesVisualCursorLineNr xxx guibg=#170a1d
		ModesVisualCursorLineSign              { bg="#170a1d", }, -- ModesVisualCursorLineSign xxx guibg=#170a1d
		ModesVisualCursorLineFold              { bg="#170a1d", }, -- ModesVisualCursorLineFold xxx guibg=#170a1d
		ModesInsertModeMsg                     { fg="#78ccc5", }, -- ModesInsertModeMsg xxx guifg=#78ccc5
		ModesVisualModeMsg                     { fg="#9745be", }, -- ModesVisualModeMsg xxx guifg=#9745be
		ModesVisualVisual                      { bg="#170a1d", }, -- ModesVisualVisual xxx guibg=#170a1d
		TitleString                            { fg="#add7ff", }, -- TitleString    xxx guifg=#add7ff
		LeapBackground                         { bg="#303340", }, -- LeapBackground xxx guibg=#303340
		LeapLabelSelected                      { bg="#fffac2", fg="#1b1e28", }, -- LeapLabelSelected xxx guifg=#1b1e28 guibg=#fffac2
		LeapLabelSecondary                     { bg="#89ddff", fg="#1b1e28", }, -- LeapLabelSecondary xxx guifg=#1b1e28 guibg=#89ddff
		LeapLabelPrimary                       { bg="#5de4c7", fg="#1b1e28", }, -- LeapLabelPrimary xxx guifg=#1b1e28 guibg=#5de4c7
		LeapMatch                              { bg="#fcc5e9", fg="#1b1e28", }, -- LeapMatch      xxx guifg=#1b1e28 guibg=#fcc5e9
		HopNextKey2                            { fg="#5fb3a1", }, -- HopNextKey2    xxx guifg=#5fb3a1
		HopNextKey1                            { fg="#5de4c7", }, -- HopNextKey1    xxx guifg=#5de4c7
		HopNextKey                             { fg="#89ddff", }, -- HopNextKey     xxx guifg=#89ddff
		PounceAcceptBest                       { bg="#e4f0fb", fg="#e4f0fb", }, -- PounceAcceptBest xxx guifg=#e4f0fb guibg=#e4f0fb
		PounceAccept                           { bg="#e4f0fb", fg="#d0679d", }, -- PounceAccept   xxx guifg=#d0679d guibg=#e4f0fb
		WhichKey                               { fg="#e4f0fb", }, -- WhichKey       xxx guifg=#e4f0fb
		WhichKeyFloat                          { bg="#171922", }, -- WhichKeyFloat  xxx guibg=#171922
		WhichKeyDesc                           { fg="#e4f0fb", }, -- WhichKeyDesc   xxx guifg=#e4f0fb
		WhichKeyGroup                          { fg="#e4f0fb", }, -- WhichKeyGroup  xxx guifg=#e4f0fb
		NvimTreeWindowPicker                   { bg="#a6accd", }, -- NvimTreeWindowPicker xxx guibg=#a6accd
		NvimTreeNormal                         { fg="#e4f0fb", }, -- NvimTreeNormal xxx guifg=#e4f0fb
		NvimTreeSpecialFile                    { NvimTreeNormal }, -- NvimTreeSpecialFile xxx links to NvimTreeNormal
		NvimTreeRootFolder                     { fg="#5de4c7", }, -- NvimTreeRootFolder xxx guifg=#5de4c7
		NvimTreeFolderName                     { fg="#91b4d5", }, -- NvimTreeFolderName xxx guifg=#91b4d5
		NvimTreeOpenedFolderName               { NvimTreeFolderName }, -- NvimTreeOpenedFolderName xxx links to NvimTreeFolderName
		NvimTreeOpenedFile                     { bg="#303340", fg="#e4f0fb", }, -- NvimTreeOpenedFile xxx guifg=#e4f0fb guibg=#303340
		NvimTreeImageFile                      { fg="#e4f0fb", }, -- NvimTreeImageFile xxx guifg=#e4f0fb
		NvimTreeGitStaged                      { fg="#89ddff", }, -- NvimTreeGitStaged xxx guifg=#89ddff
		NvimTreeGitRenamed                     { fg="#42675a", }, -- NvimTreeGitRenamed xxx guifg=#42675a
		NvimTreeGitNew                         { fg="#5de4c7", }, -- NvimTreeGitNew xxx guifg=#5de4c7
		NvimTreeGitMerge                       { fg="#add7ff", }, -- NvimTreeGitMerge xxx guifg=#add7ff
		NvimTreeGitDirty                       { fg="#7390aa", }, -- NvimTreeGitDirty xxx guifg=#7390aa
		NvimTreeGitDeleted                     { fg="#d0679d", }, -- NvimTreeGitDeleted xxx guifg=#d0679d
		NvimTreeFolderIcon                     { fg="#91b4d5", }, -- NvimTreeFolderIcon xxx guifg=#91b4d5
		NvimTreeFileStaged                     { fg="#89ddff", }, -- NvimTreeFileStaged xxx guifg=#89ddff
		NvimTreeFileRenamed                    { fg="#506477", }, -- NvimTreeFileRenamed xxx guifg=#506477
		NvimTreeFileNew                        { fg="#5de4c7", }, -- NvimTreeFileNew xxx guifg=#5de4c7
		NvimTreeFileMerge                      { fg="#add7ff", }, -- NvimTreeFileMerge xxx guifg=#add7ff
		NvimTreeFileDirty                      { fg="#7390aa", }, -- NvimTreeFileDirty xxx guifg=#7390aa
		NvimTreeFileDeleted                    { fg="#d0679d", }, -- NvimTreeFileDeleted xxx guifg=#d0679d
		NvimTreeEmptyFolderName                { fg="#506477", }, -- NvimTreeEmptyFolderName xxx guifg=#506477
		BufferVisibleTarget                    { fg="#fffac2", }, -- BufferVisibleTarget xxx guifg=#fffac2
		BufferVisibleMod                       { fg="#5de4c7", }, -- BufferVisibleMod xxx guifg=#5de4c7
		BufferVisibleIndex                     { fg="#a6accd", }, -- BufferVisibleIndex xxx guifg=#a6accd
		BufferInactiveTarget                   { fg="#fffac2", }, -- BufferInactiveTarget xxx guifg=#fffac2
		BufferInactiveSign                     { fg="#767c9d", }, -- BufferInactiveSign xxx guifg=#767c9d
		BufferInactiveMod                      { fg="#5de4c7", }, -- BufferInactiveMod xxx guifg=#5de4c7
		BufferInactiveIndex                    { fg="#a6accd", }, -- BufferInactiveIndex xxx guifg=#a6accd
		BufferInactive                         { fg="#a6accd", }, -- BufferInactive xxx guifg=#a6accd
		BufferCurrentTarget                    { bg="#1b1e28", fg="#fffac2", }, -- BufferCurrentTarget xxx guifg=#fffac2 guibg=#1b1e28
		BufferCurrentSign                      { bg="#1b1e28", fg="#a6accd", }, -- BufferCurrentSign xxx guifg=#a6accd guibg=#1b1e28
		BufferCurrentMod                       { bg="#1b1e28", fg="#5de4c7", }, -- BufferCurrentMod xxx guifg=#5de4c7 guibg=#1b1e28
		BufferCurrentIndex                     { bg="#1b1e28", fg="#e4f0fb", }, -- BufferCurrentIndex xxx guifg=#e4f0fb guibg=#1b1e28
		BufferCurrent                          { bg="#1b1e28", fg="#e4f0fb", }, -- BufferCurrent  xxx guifg=#e4f0fb guibg=#1b1e28
		rainbowcol6                            { fg="#d0679d", }, -- rainbowcol6    xxx guifg=#d0679d
		rainbowcol5                            { fg="#5fb3a1", }, -- rainbowcol5    xxx guifg=#5fb3a1
		rainbowcol4                            { fg="#add7ff", }, -- rainbowcol4    xxx guifg=#add7ff
		typescriptVariable                     { fg="#add7ff", }, -- typescriptVariable xxx guifg=#add7ff
		DarkenedPanel                          { bg="#171922", }, -- DarkenedPanel  xxx guibg=#171922
		TSURI                                  { fg="#91b4d5", }, -- TSURI          xxx guifg=#91b4d5
		TSInclude                              { fg="#add7ff", }, -- TSInclude      xxx guifg=#add7ff
		DiagnosticStatusLineWarn               { bg="#171922", fg="#fffac2", }, -- DiagnosticStatusLineWarn xxx guifg=#fffac2 guibg=#171922
		DiagnosticStatusLineInfo               { bg="#171922", fg="#91b4d5", }, -- DiagnosticStatusLineInfo xxx guifg=#91b4d5 guibg=#171922
		DiagnosticStatusLineHint               { bg="#171922", fg="#89ddff", }, -- DiagnosticStatusLineHint xxx guifg=#89ddff guibg=#171922
		DiagnosticDefaultWarn                  { fg="#fffac2", }, -- DiagnosticDefaultWarn xxx guifg=#fffac2
		DiagnosticDefaultInfo                  { fg="#91b4d5", }, -- DiagnosticDefaultInfo xxx guifg=#91b4d5
		DiagnosticDefaultHint                  { fg="#89ddff", }, -- DiagnosticDefaultHint xxx guifg=#89ddff
		DiagnosticDefaultError                 { fg="#d0679d", }, -- DiagnosticDefaultError xxx guifg=#d0679d
		debugBreakpoint                        { bg="#1b1e28", fg="#d0679d", }, -- debugBreakpoint xxx guifg=#d0679d guibg=#1b1e28
		markdownLinkText                       { gui="underline", fg="#89ddff", }, -- markdownLinkText xxx gui=underline guifg=#89ddff
		markdownH4                             { gui="bold", fg="#add7ff", }, -- markdownH4     xxx gui=bold guifg=#add7ff
		markdownH3                             { gui="bold", fg="#add7ff", }, -- markdownH3     xxx gui=bold guifg=#add7ff
		markdownH2                             { gui="bold", fg="#add7ff", }, -- markdownH2     xxx gui=bold guifg=#add7ff
		markdownH1                             { gui="bold", fg="#add7ff", }, -- markdownH1     xxx gui=bold guifg=#add7ff
		markdownCodeBlock                      { fg="#5fb3a1", }, -- markdownCodeBlock xxx guifg=#5fb3a1
		markdownHeadingDelimiter               { gui="bold", fg="#7390aa", }, -- markdownHeadingDelimiter xxx gui=bold guifg=#7390aa
		mkdLink                                { gui="underline", fg="#89ddff", }, -- mkdLink        xxx gui=underline guifg=#89ddff
		mkdCodeEnd                             { gui="bold", fg="#5fb3a1", }, -- mkdCodeEnd     xxx gui=bold guifg=#5fb3a1
		mkdCodeStart                           { gui="bold", fg="#5fb3a1", }, -- mkdCodeStart   xxx gui=bold guifg=#5fb3a1
		htmlH2                                 { gui="bold", fg="#5de4c7", }, -- htmlH2         xxx gui=bold guifg=#5de4c7
		htmlH1                                 { gui="bold", fg="#5de4c7", }, -- htmlH1         xxx gui=bold guifg=#5de4c7
		Italic                                 { gui="italic", }, -- Italic         xxx gui=italic
		SagaNormal                             { bg="#1b1e28", }, -- SagaNormal     xxx guibg=#1b1e28
		FinderNormal                           { SagaNormal }, -- FinderNormal   xxx links to SagaNormal
		TerminalNormal                         { SagaNormal }, -- TerminalNormal xxx links to SagaNormal
		OutlinePreviewBorder                   { SagaNormal }, -- OutlinePreviewBorder xxx links to SagaNormal
		CallHierarchyNormal                    { SagaNormal }, -- CallHierarchyNormal xxx links to SagaNormal
		DiagnosticNormal                       { SagaNormal }, -- DiagnosticNormal xxx links to SagaNormal
		HoverNormal                            { SagaNormal }, -- HoverNormal    xxx links to SagaNormal
		DefinitionNormal                       { SagaNormal }, -- DefinitionNormal xxx links to SagaNormal
		CodeActionNormal                       { SagaNormal }, -- CodeActionNormal xxx links to SagaNormal
		ActionPreviewNormal                    { SagaNormal }, -- ActionPreviewNormal xxx links to SagaNormal
		ActionPreviewTitle                     { bg="#1b1e28", fg="#767c9d", }, -- ActionPreviewTitle xxx guifg=#767c9d guibg=#1b1e28
		TitleIcon                              { fg="#add7ff", }, -- TitleIcon      xxx guifg=#add7ff
		HopCursor                              { fg="#91b4d5", }, -- HopCursor      xxx guifg=#91b4d5
		HopUnmatched                           { fg="#506477", }, -- HopUnmatched   xxx guifg=#506477
		IndentBlanklineContextStart            { fg="#fffac2", }, -- IndentBlanklineContextStart xxx guifg=#fffac2
		IndentBlanklineContextChar             { fg="#fffac2", }, -- IndentBlanklineContextChar xxx guifg=#fffac2
		IndentBlanklineChar                    { fg="#303340", }, -- IndentBlanklineChar xxx guifg=#303340
		WhichKeyValue                          { fg="#e4f0fb", }, -- WhichKeyValue  xxx guifg=#e4f0fb
		WhichKeySeparator                      { fg="#e4f0fb", }, -- WhichKeySeparator xxx guifg=#e4f0fb
		BufferVisibleSign                      { fg="#767c9d", }, -- BufferVisibleSign xxx guifg=#767c9d
		BufferVisible                          { fg="#a6accd", }, -- BufferVisible  xxx guifg=#a6accd
		BufferTabpageFill                      { bg="#1b1e28", fg="#1b1e28", }, -- BufferTabpageFill xxx guifg=#1b1e28 guibg=#1b1e28
		rainbowcol7                            { fg="#91b4d5", }, -- rainbowcol7    xxx guifg=#91b4d5
		rainbowcol3                            { fg="#fffac2", }, -- rainbowcol3    xxx guifg=#fffac2
		rainbowcol2                            { fg="#5de4c7", }, -- rainbowcol2    xxx guifg=#5de4c7
		rainbowcol1                            { fg="#89ddff", }, -- rainbowcol1    xxx guifg=#89ddff
		cssClassName                           { gui="italic", fg="#5fb3a1", }, -- cssClassName   xxx gui=italic guifg=#5fb3a1
		cssTSError                             { cssClassName }, -- cssTSError     xxx links to cssClassName
		cssDefinition                          { fg="#add7ff", }, -- cssDefinition  xxx guifg=#add7ff
		cssPseudoClass                         { gui="italic", fg="#91b4d5", }, -- cssPseudoClass xxx gui=italic guifg=#91b4d5
		cssTSKeyword                           { fg="#a6accd", }, -- cssTSKeyword   xxx guifg=#a6accd
		cssTSType                              { fg="#5de4c7", }, -- cssTSType      xxx guifg=#5de4c7
		cssTSProperty                          { fg="#add7ff", }, -- cssTSProperty  xxx guifg=#add7ff
		cssTSFunction                          { fg="#a6accd", }, -- cssTSFunction  xxx guifg=#a6accd
		luaTSConstructor                       { fg="#a6accd", }, -- luaTSConstructor xxx guifg=#a6accd
		typescriptObjectType                   { fg="#a6accd", }, -- typescriptObjectType xxx guifg=#a6accd
		typescriptParenExp                     { fg="#767c9d", }, -- typescriptParenExp xxx guifg=#767c9d
		typescriptTypeCast                     { fg="#767c9d", }, -- typescriptTypeCast xxx guifg=#767c9d
		typescriptEnum                         { fg="#7390aa", }, -- typescriptEnum xxx guifg=#7390aa
		typescriptCastKeyword                  { fg="#767c9d", }, -- typescriptCastKeyword xxx guifg=#767c9d
		typescriptTSInclude                    { fg="#5de4c7", }, -- typescriptTSInclude xxx guifg=#5de4c7
		typescriptIdentifierName               { fg="#767c9d", }, -- typescriptIdentifierName xxx guifg=#767c9d
		typescriptBlock                        { fg="#e4f0fb", }, -- typescriptBlock xxx guifg=#e4f0fb
		typescriptConstraint                   { fg="#5de4c7", }, -- typescriptConstraint xxx guifg=#5de4c7
		typescriptDefault                      { fg="#5de4c7", }, -- typescriptDefault xxx guifg=#5de4c7
		typescriptExport                       { fg="#5de4c7", }, -- typescriptExport xxx guifg=#5de4c7
		DiagnosticStatusLineError              { bg="#171922", fg="#d0679d", }, -- DiagnosticStatusLineError xxx guifg=#d0679d guibg=#171922
		markdownCode                           { fg="#a6accd", }, -- markdownCode   xxx guifg=#a6accd
		mkdCodeDelimiter                       { bg="#171922", fg="#e4f0fb", }, -- mkdCodeDelimiter xxx guifg=#e4f0fb guibg=#171922
		qfFileName                             { fg="#767c9d", }, -- qfFileName     xxx guifg=#767c9d
		qfLineNr                               { fg="#506477", }, -- qfLineNr       xxx guifg=#506477
		Bold                                   { gui="bold", }, -- Bold           xxx gui=bold
		DarkenedStatusline                     { bg="#171922", }, -- DarkenedStatusline xxx guibg=#171922
		SagaBorder                             { bg="#1b1e28", fg="#767c9d", }, -- SagaBorder     xxx guifg=#767c9d guibg=#1b1e28
		TerminalBorder                         { SagaBorder }, -- TerminalBorder xxx links to SagaBorder
		OutlinePreviewNormal                   { SagaBorder }, -- OutlinePreviewNormal xxx links to SagaBorder
		CallHierarchyBorder                    { SagaBorder }, -- CallHierarchyBorder xxx links to SagaBorder
		DiagnosticBorder                       { SagaBorder }, -- DiagnosticBorder xxx links to SagaBorder
		RenameBorder                           { SagaBorder }, -- RenameBorder   xxx links to SagaBorder
		HoverBorder                            { SagaBorder }, -- HoverBorder    xxx links to SagaBorder
		DefinitionBorder                       { SagaBorder }, -- DefinitionBorder xxx links to SagaBorder
		FinderPreviewBorder                    { SagaBorder }, -- FinderPreviewBorder xxx links to SagaBorder
		FinderBorder                           { SagaBorder }, -- FinderBorder   xxx links to SagaBorder
		CodeActionBorder                       { SagaBorder }, -- CodeActionBorder xxx links to SagaBorder
		ActionPreviewBorder                    { SagaBorder }, -- ActionPreviewBorder xxx links to SagaBorder
		OutlineIndent                          { fg="#add7ff", }, -- OutlineIndent  xxx guifg=#add7ff
		SagaShadow                             { bg="#171922", }, -- SagaShadow     xxx guibg=#171922
		CallHierarchyTitle                     { fg="#fcc5e9", }, -- CallHierarchyTitle xxx guifg=#fcc5e9
		CallHierarchyIcon                      { fg="#fcc5e9", }, -- CallHierarchyIcon xxx guifg=#fcc5e9
		DiagnosticWord                         { fg="#ffffff", }, -- DiagnosticWord xxx guifg=#ffffff
		DiagnosticPos                          { fg="#767c9d", }, -- DiagnosticPos  xxx guifg=#767c9d
		field                                  { fg="#e4f0fb", }, -- field          xxx guifg=#e4f0fb
		DiagnosticSource                       { fg="#767c9d", }, -- DiagnosticSource xxx guifg=#767c9d
		RenameNormal                           { fg="#ffffff", }, -- RenameNormal   xxx guifg=#ffffff
		FinderVirtText                         { fg="#89ddff", }, -- FinderVirtText xxx guifg=#89ddff
		FinderSpinner                          { fg="#d0679d", }, -- FinderSpinner  xxx guifg=#d0679d
		FinderSpinnerTitle                     { fg="#d0679d", }, -- FinderSpinnerTitle xxx guifg=#d0679d
		FinderType                             { fg="#5de4c7", }, -- FinderType     xxx guifg=#5de4c7
		FinderIcon                             { fg="#fffac2", }, -- FinderIcon     xxx guifg=#fffac2
		FinderFileName                         { fg="#ffffff", }, -- FinderFileName xxx guifg=#ffffff
		FinderSelection                        { fg="#767c9d", }, -- FinderSelection xxx guifg=#767c9d
		CodeActionNumber                       { fg="#91b4d5", }, -- CodeActionNumber xxx guifg=#91b4d5
		CodeActionText                         { fg="#fffac2", }, -- CodeActionText xxx guifg=#fffac2
		SagaBeacon                             { bg="#fffac2", }, -- SagaBeacon     xxx guibg=#fffac2
		SagaCollapse                           { fg="#5fb3a1", }, -- SagaCollapse   xxx guifg=#5fb3a1
		SagaExpand                             { fg="#5fb3a1", }, -- SagaExpand     xxx guifg=#5fb3a1
		NoiceFormatProgressDone                { bg="#506477", fg="#ffffff", }, -- NoiceFormatProgressDone xxx guifg=#ffffff guibg=#506477
		NoiceHiddenCursor                      { blend=100, gui="nocombine", }, -- NoiceHiddenCursor xxx cterm=nocombine gui=nocombine blend=100
		BufferLineDevIconLuaSelected           { bg="#1b1e28", fg="#51a0cf", }, -- BufferLineDevIconLuaSelected xxx ctermfg=74 guifg=#51a0cf guibg=#1b1e28
		NotifyINFOTitle3                       { fg="#5de4c7", }, -- NotifyINFOTitle3 xxx guifg=#5de4c7
		NotifyINFOBorder3                      { fg="#5de4c7", }, -- NotifyINFOBorder3 xxx guifg=#5de4c7
		NotifyINFOBody3                        { bg="#1b1e28", fg="#e4f0fb", }, -- NotifyINFOBody3 xxx guifg=#e4f0fb guibg=#1b1e28
		NotifyINFOIcon3                        { fg="#5de4c7", }, -- NotifyINFOIcon3 xxx guifg=#5de4c7
		NotifyWARNTitle53                      { fg="#fffac2", }, -- NotifyWARNTitle53 xxx guifg=#fffac2
		NotifyWARNBorder53                     { fg="#fffac2", }, -- NotifyWARNBorder53 xxx guifg=#fffac2
		NotifyWARNBody53                       { bg="#1b1e28", fg="#e4f0fb", }, -- NotifyWARNBody53 xxx guifg=#e4f0fb guibg=#1b1e28
		NotifyWARNIcon53                       { fg="#fffac2", }, -- NotifyWARNIcon53 xxx guifg=#fffac2
		NotifyWARNTitle54                      { fg="#fffac2", }, -- NotifyWARNTitle54 xxx guifg=#fffac2
		NotifyWARNBorder54                     { fg="#fffac2", }, -- NotifyWARNBorder54 xxx guifg=#fffac2
		NotifyWARNBody54                       { bg="#1b1e28", fg="#e4f0fb", }, -- NotifyWARNBody54 xxx guifg=#e4f0fb guibg=#1b1e28
		NotifyWARNIcon54                       { fg="#fffac2", }, -- NotifyWARNIcon54 xxx guifg=#fffac2
		NotifyINFOTitle86                      { fg="#5de4c7", }, -- NotifyINFOTitle86 xxx guifg=#5de4c7
		NotifyINFOBorder86                     { fg="#5de4c7", }, -- NotifyINFOBorder86 xxx guifg=#5de4c7
		NotifyINFOBody86                       { bg="#1b1e28", fg="#e4f0fb", }, -- NotifyINFOBody86 xxx guifg=#e4f0fb guibg=#1b1e28
		NotifyINFOIcon86                       { fg="#5de4c7", }, -- NotifyINFOIcon86 xxx guifg=#5de4c7
		NoiceAttr606                           { gui="bold", fg="#d0679d", }, -- NoiceAttr606   xxx cterm=bold gui=bold guifg=#d0679d
	}
end)
