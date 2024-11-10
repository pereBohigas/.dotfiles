" Share runtime files and packages located in '~/.vim' with Vim
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath=&runtimepath

" Absolute path to Neovim's directory
" from: https://stackoverflow.com/a/18734557/13170523
let s:neovim_path = expand('<sfile>:p:h')

" Source Vim configuration
execute 'source ' . s:neovim_path . '/vimrc'

" Set path to store swap files
execute 'set directory=' . s:neovim_path . '/swap'

" SPELL CHECKER

" Enable spell checking
set spell

" Set language for the spell checking (other used languages 'ca','de_de','en_us','es_es')
set spelllang=en_us

" Switch spell check language
nnoremap <silent> <leader>dd :setlocal spelllang=de_de<CR>
nnoremap <silent> <leader>ee :setlocal spelllang=en_us<CR>

" Enable dictionary auto-completion in Markdown files and Git Commit Messages
autocmd FileType markdown setlocal complete+=kspell
autocmd FileType gitcommit setlocal complete+=kspell

" TODO: Adapt me
" Highlight yanked text
augroup highlight_yank
	autocmd!
	au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=150}
augroup END

" Regenerate spell files (.spl) whenever the corresponding .add file has been updated
" from: https://vi.stackexchange.com/a/5052/32500
for d in glob(s:neovim_path . '/spell/*.add', 1, 1)
	if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
		exec 'mkspell! ' . fnameescape(d)
	endif
endfor

" VIM-PLUG => https://github.com/junegunn/vim-plug

" Auto installation script
" based on: https://github.com/junegunn/vim-plug/wiki/tips
let s:vim_plug_data = s:neovim_path . '/autoload/plug.vim'
if empty(glob(s:vim_plug_data))
	silent execute '!curl -fLo ' . s:vim_plug_data . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Replace Plug with Packer -> https://github.com/wbthomason/packer.nvim

" Load plugins
call plug#begin(s:neovim_path . '/plugged')

" VIM-AIRLINE - Status line mod with powerline icons => https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'

" FERN - General purpose asynchronous tree viewer written in Pure Vim script => https://github.com/lambdalisue/fern.vim
Plug 'lambdalisue/fern.vim'

" FERN GIT STATUS - Add Git status badge integration => https://github.com/lambdalisue/fern-git-status.vim
Plug 'lambdalisue/fern-git-status.vim'

" VIM-GITGUTTER - Show git diff in the sign column => https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'

" VIM-FUGITIVE - Git integration => https://github.com/tpope/vim-fugitive
" Plug 'tpope/vim-fugitive'

" LAZYGIT => Plugin for calling lazygit from within Neovim.
Plug 'kdheepak/lazygit.nvim'

" CONFLICT MARKER - Highlight git conflicts => https://github.com/rhysd/conflict-marker.vim
Plug 'rhysd/conflict-marker.vim'

" FUZZY FINDER => https://github.com/junegunn/fzf
"Plug 'junegunn/fzf'
" uses fzf installed with Homebrew
Plug '/usr/local/opt/fzf'

" FUZZY FINDER Vim integration => https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf.vim'

" VIM-POLYGLOT - Collection of language packs for syntax highlight => https://github.com/sheerun/vim-polyglot
Plug 'sheerun/vim-polyglot'

" NVIM-LSPCONFIG - common configurations for Neovim's built-in language server client => https://github.com/neovim/nvim-lspconfig
"Plug 'neovim/nvim-lspconfig'

" VIM-LSP - Async Language Server Protocol plugin for vim8 and neovim => https://github.com/prabirshrestha/vim-lsp
"Plug 'prabirshrestha/vim-lsp'

" VIM LANGUAGE SERVER CLIENT - Adds language-aware tooling to vim => https://github.com/Yggdroot/indentLine
"Plug 'natebosch/vim-lsc'

" ALE - Asynchronous Lint Engine => https://github.com/dense-analysis/ale
"Plug 'dense-analysis/ale'

" VIM COMPLETES ME - tab-completion plugin => https://github.com/ackyshake/VimCompletesMe
" Plug 'ackyshake/VimCompletesMe'

" VIM-SURROUND - Simplify edition of surrounding elements (like quotes, parenthesis, ...) => https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'

" TARGETS - Vim plugin that provides additional text objects => https://github.com/wellle/targets.vim
"Plug 'wellle/targets.vim'

" VIM-HIGHLIGHTURL - URL highlighting everywhere => https://github.com/itchyny/vim-highlighturl
Plug 'itchyny/vim-highlighturl'

" VIM-COMMENTARY - Comment stuff out => https://github.com/tpope/vim-commentary
Plug 'tpope/vim-commentary'

" VIM-EXECUTIONER - Execute files in terminal or separate buffer => https://github.com/EvanQuan/vim-executioner
Plug 'EvanQuan/vim-executioner'

" INDENT LINE - A vim plugin to display the indention levels with thin vertical lines => https://github.com/Yggdroot/indentLine
"Plug 'Yggdroot/indentLine'

" VIM MARKDOWN - Markdown Vim Mode => https://github.com/preservim/vim-markdown


" VIM-MARKDOWN-TOC - Table of content generator for markdown files => https://github.com/ajorgensen/vim-markdown-toc
Plug 'ajorgensen/vim-markdown-toc'

" VIM-TABLE-MODE - Markdown table creator and formatter => https://github.com/dhruvasagar/vim-table-mode
Plug 'dhruvasagar/vim-table-mode'

" VIM MARKDOWN PREVIEW => https://github.com/iamcco/markdown-preview.nvim
" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" VIMTEX - LaTeX file type and syntax => https://github.com/lervag/vimtex
Plug 'lervag/vimtex'

" VIM LATEX LIVE PREVIEW - A Vim Plugin for Lively Previewing LaTeX PDF Output => https://github.com/xuhdev/vim-latex-live-preview
" Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" VIM-SWIFT - Swift file type and syntax => https://github.com/lilyball/vim-swift-extra
Plug 'lilyball/vim-swift-extra'

" Plug 'keith/swift.vim'

" SWIFT VIM PLUGIN - Apple's Swift Vim plugin => https://github.com/marcusglowe/vim-swift
"Plug 'marcusglowe/vim-swift'

" NERDFONT.VIM - A plugin to handle Nerd Fonts from Vim => https://github.com/lambdalisue/nerdfont.vim
Plug 'lambdalisue/nerdfont.vim'

" FERN RENDERER NERDFONT.VIM - A plugin which add file type icon through nerdfont.vim => https://github.com/lambdalisue/fern-renderer-nerdfont.vim
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

" AFTERGLOW - Color scheme => https://github.com/danilo-augusto/vim-afterglow
"Plug 'danilo-augusto/vim-afterglow'

" GRUVBOX - Color scheme => https://github.com/gruvbox-community/gruvbox
Plug 'gruvbox-community/gruvbox'

" ALDUIN - Color scheme => https://github.com/AlessandroYorba/Alduin
Plug 'AlessandroYorba/Alduin'

" ONE - Color scheme => https://github.com/rakr/vim-one
Plug 'rakr/vim-one'

" MOONFLY - Color scheme => https://github.com/bluz71/vim-moonfly-colors
Plug 'bluz71/vim-moonfly-colors'

" VIM COLORS XCODE - Xcode color scheme => https://github.com/arzg/vim-colors-xcode
Plug 'arzg/vim-colors-xcode'

" NEOVIM LSP CONFIGURATIONS => https://github.com/neovim/nvim-lspconfig
Plug 'neovim/nvim-lspconfig'

" LSP autocomplete => https://github.com/hrsh7th/nvim-cmp
Plug 'hrsh7th/nvim-cmp'

" GLOW MARKDOWN PREVIEW => https://github.com/ellisonleao/glow.nvim
Plug 'ellisonleao/glow.nvim'

call plug#end()
" to install plugins run ':PlugInstall' direct on Neovim

" Run PlugInstall if there are missing plugins
" from: https://github.com/junegunn/vim-plug/wiki/extra
" TODO: Fix auto installation of plugins for Raspberry Pi
" if has('mac')
" 	autocmd VimEnter *
" 	\  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
" 	\|   PlugInstall --sync | q
" 	\| endif
" endif

" AFTERGLOW configuration
" Enables italic for comments
let g:afterglow_italic_comments = 1
" Inherit terminal's background
let g:afterglow_inherit_background = 1

" GRUVBOX configuration
" Set colorscheme contrast
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
" Enables italic text
let g:gruvbox_italic = 1
" Enables italic for strings
let g:gruvbox_italicize_strings = 1
" Enables italic for comments
let g:gruvbox_italicize_comments = 1

" ONE configuration
" Enables italic text
let g:one_allow_italics = 1

" AIRLINE configuration
" Use powerline fonts
let g:airline_powerline_fonts = 1

" FERN configuration
" Disable netrw.
"let g:loaded_netrw  = 1
"let g:loaded_netrwPlugin = 1
"let g:loaded_netrwSettings = 1
"let g:loaded_netrwFileHandlers = 1
" Set Nerd Fonts to be used for file type
let g:fern#renderer = "nerdfont"
" Custom settings and mappings.
let g:fern#default_hidden = 1
let g:fern#drawer_width = 30
let g:fern#disable_drawer_auto_quit   = 1
let g:fern#disable_viewer_hide_cursor = 1

noremap <silent> <Leader>f :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=

function! s:init_fern() abort
	nmap <buffer><expr>
		\ <Plug>(fern-my-open-expand-collapse)
		\ fern#smart#leaf(
		\   "\<Plug>(fern-action-open:select)",
		\   "\<Plug>(fern-action-expand)",
		\   "\<Plug>(fern-action-collapse)",
		\ )

	nmap <buffer> H <Plug>(fern-action-open:split)
	nmap <buffer> V <Plug>(fern-action-open:vsplit)
	nmap <buffer> W <Plug>(fern-action-open:select)
	nmap <buffer> w <Plug>(fern-action-open:vsplit)
	nmap <buffer> r <Plug>(fern-action-rename)
	nmap <buffer> m <Plug>(fern-action-move)
	nmap <buffer> c <Plug>(fern-action-new-copy)
	nmap <buffer> n <Plug>(fern-action-new-path)
	nmap <buffer> d <Plug>(fern-action-new-dir)
	nmap <buffer> dd <Plug>(fern-action-remove)
	nmap <buffer> <leader> <Plug>(fern-action-mark)
endfunction

augroup FernGroup
	autocmd! *
	autocmd FileType fern call s:init_fern()
augroup END

" Start Fern when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * ++nested Fern -drawer %:h | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" GITGUTTER configuration
" Update sign column every x miliseconds
set updatetime=240

" VIM LSP
" if executable('sourcekit-lsp')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'sourcekit-lsp',
"         \ 'cmd': {server_info->['sourcekit-lsp']},
"         \ 'whitelist': ['swift'],
"         \ })
" endif

" VIM LATEX LIVE PREVIEW configuration
" let g:livepreview_previewer = 'open -a Preview'

" FUZZY FINDER configuration
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :GFiles<CR>
nnoremap <silent> <C-o> :Buffers<CR>
nnoremap <silent> <C-f> :Rg!
"" This is the default extra key bindings
let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-x': 'split',
\ 'ctrl-v': 'vsplit'
\ }
"" - down / up / left / right
let g:fzf_layout = { 'down': '30%' }
"" Customize fzf colors to match your color scheme
"" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors = {
\ 'fg':      ['fg', 'Normal'],
\ 'bg':      ['bg', 'Normal'],
\ 'hl':      ['fg', 'Comment'],
\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':     ['fg', 'Statement'],
\ 'info':    ['fg', 'PreProc'],
\ 'border':  ['fg', 'Ignore'],
\ 'prompt':  ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker':  ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header':  ['fg', 'Comment']
\ }

" MARKDOWN PREVIEW
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 1,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = '/Users/perebohigas/Documents/Seafile/jamitlabs_documents/I_love_my_terminal/github-markdown-dark.css'

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'dark'

" VIMTEX configuration
" Silent compiler messages
"let g:vimtex_compiler_silent = 1
" Save compilation files in a diferent directory
" let g:vimtex_compiler_latexmk = {
"       \ 'build_dir' : 'build',
"       \}
" Use Skim as PDF viewer
filetype plugin indent on
let g:vimtex_view_method = 'skim'

" SWIFT-VIM configuration
" Fix indentation of .swift files
"autocmd BufEnter *.swift set tabstop=2 shiftwidth=2 softtabstop=2

nnoremap <silent> <leader>s :SwiftRun<Return>

" let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
":nnoremap <leader>sb :!swift build<cr>
":nnoremap <leader>sr :!swift run<cr>

" VIM EXECUTIONER configuration
nnoremap <silent> <leader>r :ExecutionerHorizontalBuffer<Return>

"let g:executioner#extensions['swift'] = 'swiftc %'

" CARBON configuration
let g:carbon_now_sh_browser = 'google-chrome'

" VIM-TABLE-MODE
let g:table_mode_delete_column_map = '<Leader>tdc'

" SET SOURCEKIT LANGUAGE SEVER
" SourceKit only available for macOS
if has('mac')
lua << EOF
-- connect to server
require'lspconfig'.sourcekit.setup{
	on_attach = function()
		vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
		vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
		vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
		print("SourceKit attached")
	end,
}
EOF
endif

" Fix for .tex files with names starting with 'jam' (which will be then be
" recognize as Jam files)
"au BufReadPost *.tex set syntax=tex

" SET COLOR SCHEME AND STYLE (background)
" Set current terminal
"set shell=zsh\ -i

"Get the output of a shell function which provides the current terminal's color scheme and style (background) in form of "colorScheme_style", removing last byte (new line)
"let s:terminal_color_scheme_and_style = split(system('get_color_scheme')[:-2], "_")

"echon 'Color scheme set to '
"if len(s:terminal_color_scheme_and_style) >= 1 && index(getcompletion('', 'color'), s:terminal_color_scheme_and_style[0]) >= 0
"" Terminal color scheme exists in Vim
"execute 'colorscheme ' . s:terminal_color_scheme_and_style[0]
""echohl ModeMsg | echon g:colors_name | echohl None
"else
"" Terminal color scheme not exists in Vim, set default one
colorscheme gruvbox
""echon "default (gruvbox)"
"endif
"
""echon ' with the style '
"if len(s:terminal_color_scheme_and_style) >= 2 && index(['dark', 'light'], s:terminal_color_scheme_and_style[1]) >= 0
"" Style (background) is defined
"execute 'set background=' . s:terminal_color_scheme_and_style[1]
""echohl ModeMsg | echon &background | echohl None
"else
"" Style (background) is not defined or valid, default value is 'dark'
""echon "default (dark)"
"endif


" Define commands to easy change between color modes
" (with operator fix for Gruvbox)
"command Light set background=light
"| highlight! link Operator GruvboxFg1
"command Dark set background=dark
"| highlight! link Operator GruvboxFg1

" Fix operator highlight in cursor line (after setting gruvbox as colorscheme)
"highlight! link Operator GruvboxFg1

