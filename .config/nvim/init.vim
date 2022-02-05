" Install Plugged on start
" ------------------------

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install Plugins
" ---------------

call plug#begin('~/.vim/plugged')
  Plug 'preservim/nerdtree'
  Plug 'kevinhwang91/rnvimr'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'sheerun/vim-polyglot'
  Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
  Plug 'alvan/vim-closetag'
  Plug 'jiangmiao/auto-pairs'
  Plug 'mattn/vim-fz'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'yazgoo/yank-history'
  Plug 'rakr/vim-one'
  Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'folke/todo-comments.nvim'
  Plug 'TimUntersberger/neogit'
  Plug 'wellle/context.vim'
  Plug 'Darazaki/indent-o-matic'
  Plug 'stephpy/vim-yaml' "Slimmed down YAML syntax for better performance
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } "Read More - https://github.com/glacambre/firenvim
call plug#end()

" Neovide GUI config
" ------------------

" Path to Ranger (not usually needed, but WSL doesn't resolve PATH correctly)
" TODO: Check Me
"let g:rnvimr_ranger_cmd = '~/.local/bin/ranger'

" Font
" TODO: Check Me
set guifont=CaskaydiaCove\ Nerd\ Font\ Mono:h12

" Remember previous window size
let neovide_remember_window_size = v:true

" Cursor animation
let g:neovide_cursor_vfx_mode = "sonicboom"

" Configure Plugins
" -----------------

" Path to NodeJS for Coc
" (only needed if using nvm, comment out if using system NodeJS)
" TODO: Check Me
"let g:coc_node_path = '~/.nvm/versions/node/v16.8.0/bin/node'

" Clipboard (y/p read/write from OS clipboard)
set clipboard=unnamedplus

" Context (breadcrumbs) disable by default (performance hog)
let g:context_enabled = 0
let g:context_add_autocmds = 0

" Close file tree when opening a file
let NERDTreeQuitOnOpen = 1

" Close Rnvimr when opening a file
let g:rnvimr_enable_picker = 1
" Clear buffers of files deleted by Rnvimr
let g:rnvimr_enable_bw = 1

" Highlight open file in file tree
let g:NERDTreeHighlightCursorline = 1

" Auto close tag filetypes
let g:closetag_filenames = '*.html,*.xhtml,*.js,*.jsx,javascript,*.ts,*.tsx,typescript'

" Lualine
lua << EOF
  require('lualine').setup({
    options = { theme = 'onedark' }
  })
EOF

" Comment tags
lua << EOF
  require("todo-comments").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      },
      merge_keywords = false, -- when true, custom keywords will be merged with the defaults
  }
EOF

" Theme
" -----

syntax on
colorscheme one
set background=dark
highlight ScrollView ctermbg=159 guibg=LightCyan " Scrollbar color

" Hotkeys
" -------

" Shift+Alt+b: Show/Hide context (breadcrumbs)
map <S-A-b> :ContextActivate<CR>:ContextUpdate<CR>:ContextToggle<CR>

" F2: Toggle Paste Mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Ctrl+n: Toggle File Tree
map <C-n> :NERDTreeToggle<CR>

" Ctrl+Shift+n: Toggle File Tree at current file
map <C-S-n> :NERDTreeToggle %:p:h<CR>

" Ctrl+o: Open Rnvimr file manager
nnoremap <C-o> :RnvimrToggle<CR>
tnoremap <M-o> <C-\><C-n>:RnvimrToggle<CR>

" Ctrl+f: Find text in files
map <C-f> :Telescope live_grep<CR>

" Ctrl+b: Buffer list
map <C-b> :Telescope buffers<CR>

" Ctrl+p: Find Files
map <C-p> :Telescope find_files<CR>

" Crtl+t: Show all TODOs
map <C-t> :TodoTelescope<CR>

" Ctrl+Shift+f: Fuzzy find text in files
map <C-S-f> :Ag<CR>

" Open Git tab (? for help)
map <C-g> :Neogit<CR>

" Alt+Shift+f: ESLint/Prettier on current file
map <A-S-f> :CocCommand eslint.executeAutofix<CR>:CocCommand prettier.formatFile<CR>

" Alt+Shift+t: Run Jest Tests
map <A-S-t> :CocCommand jest.projectTest<CR>

" Alt+e: Jump to next error
map <A-e> <Plug>(coc-diagnostic-next)

" Alt+Shift+e: Jump to previous error
map <A-S-e> <Plug>(coc-diagnostic-prev)

" Ctrl+Alt+e: Show list of warnings/errors
map <C-A-e> :CocList diagnostics<CR>

" Ctrl+s: Edit snippets for filetype
map <C-s> :CocCommand snippets.editSnippets<CR>

" Ctrl+l: Show snippets for filetype
map <C-l> :CocList snippets<CR>

" Ctrl+h: Show/Hide hidden characters
map <C-h> :set list!<CR>

" bo: Close all buffers except this one (releases some memory, use when changing projects)
function! CloseAllBuffersButCurrent()
  let curr = bufnr("%")
  let last = bufnr("$")
  if curr > 1 | silent! execute "1,".(curr-1)."bd" | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction
nnoremap bo :call CloseAllBuffersButCurrent()<CR>

" Tab to expand snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
let g:coc_snippet_next = '<tab>'
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Alt+Shift+p: Show history of yanks (vim copy/paste)
nmap <A-S-p> :YankHistoryRgPaste<CR>

" fl: Set current file to unix line endings
nnoremap fl :set ff=unix<CR>

" tn: New tab
nnoremap tn :tabnew<CR>

" tj: Jump to first tab
nnoremap tj :tabfirst<CR>

" tl: Jump to next tab
nnoremap tl :tabnext<CR>

" th: Jump to previous tab
nnoremap th :tabprev<CR>

" tk: Jump to last tab
nnoremap tk :tablast<CR>

" td: Close current tab
nnoremap td :tabclose<CR>

" to: Close all but current tab
nnoremap to :tabonly<CR>

" tm: Move tab (0-9) or (+/-0-9)
nnoremap tm :tabm<Space>

" fi: Set fold mode to indent
nnoremap fi :set fdm=indent<CR>

" fo: Set fold mode to off (expr)
nnoremap fo :set fdm=expr<CR>

" Editor Config
" -------------

" Always show status line
set laststatus=2

" Mode is shown in status line, don't show twice
set noshowmode

" Show line numbers
set number

" Convert tab to spaces
set expandtab

" Do NOT convert tab to spaces (uncomment to enable)
"set noexpandtab

" Do NOT fix or force ending newline (uncomment to enable)
"set nofixeol
"set noeol

" Auto-indent
set smartindent
set smarttab
filetype indent on

" Tab width in spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Filetype overrides
" These change the way certain filetypes are
" handled by Prettier/ESLint/etc
au BufNewFile,BufFilePre,BufRead *.mdx set filetype=markdown

" Hidden characters
set encoding=utf-8
scriptencoding utf-8
set listchars=tab:\|>,space:_,trail:_,nbsp:=,extends:>,precedes:<,eol:⏎

" Theme color handlers
" --------------------

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
else
  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
  if &term =~ '256color'
      " Disable Background Color Erase (BCE) so that color schemes
      " work properly when Vim is used inside tmux and GNU screen.
      set t_ut=
  endif
endif

" Speed up performance with large files by disabling
" syntax highlighting, folding, and Coc
" --------------------------------------------------
fu! s:ProcessCommandList(alist)
  for l:opt_set in a:alist
    exe l:opt_set
  endfor
endfu
let g:LargeFileSize = 1024 * 300 "300KB
let g:MediumFileSize = 1024 * 24 "24KB
let g:SmallFileActionsOpen=['set eventignore-=Filetype']
let g:SmallFileActionsEnter=[]
let g:MediumFileActionsOpen=['set eventignore-=Filetype']
let g:MediumFileActionsEnter=[]
let g:LargeFileActionsEnter=[]
let g:LargeFileActionsOpen=[
      \ 'setlocal syntax=OFF',
      \ 'setlocal nofoldenable',
      \ 'setlocal bufhidden=unload',
      \ 'set eventignore+=Filetype',
      \ 'let b:coc_enabled=0',
      \]
fu! s:LargeFileSupport(...)
  if len(a:000)
    let b:filesize=a:000[0]
    let l:event='Open'
  elseif exists('b:filesize')
    let l:event='Enter'
  else
    return
  endif
  let l:size = ((b:filesize > g:LargeFileSize
        \ || b:filesize == -2) ? 'Large' :
        \ (b:filesize > g:MediumFileSize ? 'Medium' : 'Small'))
  echo 'call s:ProcessCommandList(g:'.l:size.'FileActions'.l:event.')'
  exe 'call s:ProcessCommandList(g:'.l:size.'FileActions'.l:event.')'
endfu
augroup LargeFile 
  autocmd BufReadPre * silent call s:LargeFileSupport(getfsize(expand("<afile>")))
  autocmd BufWinEnter * silent call s:LargeFileSupport()
augroup END
