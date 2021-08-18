" mgazzola | nvim/init.vim

set shell=/usr/bin/zsh
set encoding=utf-8

call plug#begin("~/.config/nvim/plugged")
  Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Intellisense engine

  Plug 'itchyny/lightline.vim'                        " Light + configurable statusline/tabline
  Plug 'bling/vim-bufferline'                         " Buffer list in command line
  Plug 'Yggdroot/indentLine'                          " Demarcate indents

  Plug 'scrooloose/nerdtree'                          " File explorer
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'      " Syntax highlighting for NERDTree
  Plug 'ryanoasis/vim-devicons'                       " Devicon support for NERDTree

  Plug 'scrooloose/nerdcommenter'                     " Better support for comments
  Plug 'ntpeters/vim-better-whitespace'               " Better support for whitespace
  Plug 'Raimondi/delimitMate'                         " Better support for delimiters

  Plug 'benmills/vimux'                               " Better support for tmux
  Plug 'christoomey/vim-tmux-navigator'               " Tmux navigator in vim

  Plug 'ctrlpvim/ctrlp.vim'                           " Fuzzy search for files with <C-p>
  Plug 'osyo-manga/vim-over'                          " incsearch for :s

  Plug 'tpope/vim-sensible'                           " Sensible remappings for vim
  Plug 'tpope/vim-obsession'                          " Session management

  Plug 'rust-lang/rust.vim'                           " Rust support
  Plug 'tpope/vim-markdown'                           " Markdown support
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }  " Golang support
  Plug 'reedes/vim-pencil'                            " Prose support

  Plug 'jackguo380/vim-lsp-cxx-highlight'             " Cpp semantic highlighting
  Plug 'rhysd/vim-clang-format'                       " Clang format

  Plug 'flazz/vim-colorschemes'                       " Lots of colorschemes
  Plug 'chriskempson/base16-vim'

  Plug 'airblade/vim-gitgutter'                       " Git diffs on the left sidebar
  Plug 'jez/vim-superman'                             " Open man files with vim
call plug#end()

colorscheme monokai-phoenix

let mapleader=','

set noshowmode                    " Don't show the current mode--lightline handles this.
set title                         " Show the filename in the window titlebar
set showcmd                       " Show the (partial) command as it’s being typed

set number                        " Show current line number
set relativenumber                " Other line numbers are relative to current line

set ignorecase                    " Ignore case for searches
set wildignore+=*/.git/*          " Don't expand wildcards to include .git/*
set wildignore+=*/node_modules/*  " Don't expand wildcards to include .node_moudles/*

set expandtab                     " Use spaces instead of tabs
set softtabstop=2                 " Number of spaces per tab
set shiftwidth=2                  " Number of spaces per autoindent

set cursorline                    " Highlight the cursor's row
set cursorcolumn                  " Highlight the cursor's column
set nostartofline                 " Don’t reset cursor to start of line when moving around.

set scrolloff=3                   " Scroll file when 3 lines from bottom

set foldmethod=syntax             " Fold based on syntax
set foldnestmax=10                " Fold max 10 levels.
set foldlevel=6                   " Start autofolding after 6 levels.

set gdefault                      " :s[ubstitute] is global by default.

set modeline                      " Respect modeline in files

set lcs=tab:▸\ ,trail:·,nbsp:_    " Make invisible characters visible
set list                          " Displays unprintable chars

set shortmess=a                   " a = filmnrwx, usual messages
set shortmess+=I                  " Don’t show the intro message on startup
set shortmess+=c                  " Disallow vim's completion menu messages (prefer coc.nvim)

set hidden                        " Allow for unsaved buffers to be hidden on a buffer change

set nobackup                      " Disallow all backup files
set nowritebackup

set updatetime=300                " Write to swap files more often

set signcolumn=yes                " Leave signcolumn always on (for consistency)

if executable('ag')
  " Prefer ag over grep for searches if available
  set grepprg=ag\ --vimgrep\ $*
endif

" Line limit of 100 characters (no autoformatting enforced)
set colorcolumn=100
hi OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%101v.\+/

" Set %% to mean 'same dir as current buffer'.
cabbr <expr> %% expand('%:p:h')

" Custom mappings
nnoremap Y y$
nnoremap <Right> <C-w>>
nnoremap <Left> <C-w><
nnoremap <Up> <C-w>+
nnoremap <Down> <C-w>-
inoremap <C-c> <ESC>

" Custom file autocmds
autocmd BufWritePost *.tex silent! execute "!xelatex % >/dev/null 2>&1" | redraw!
autocmd FileType c ClangFormatAutoEnable

" Plugin configurations

" CtrlP
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|.git\|build'

" NERDTree
nnoremap <Leader>nt :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline = 0

" obsession
let g:session_autosave_periodic = 15

" Lightline
let g:lightline = {
    \ 'colorscheme': 'Tomorrow_Night_Eighties',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status'
    \ },
\ }
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" C++ semantic highlighting
let g:lsp_cxx_hl_use_text_props = 1

" coc.nvim

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

