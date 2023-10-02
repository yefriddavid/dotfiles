" Install vim-plug if not present.
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
" Plug 'maksimr/vim-jsbeautify'
Plug 'chriskempson/base16-vim'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'rafaqz/ranger.vim'
Plug 'terryma/vim-expand-region'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'mhartington/formatter.nvim'

" Fzf.
" Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
" Snippets.
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'

" Status bar
Plug 'neovim/nvim-lspconfig'
Plug 'SmiteshP/nvim-navic'

" status bar
"Plug 'liuchengxu/vista.vim'
"next is good
"Plug 'liuchengxu/eleline.vim' 
"Plug 'vim-airline/vim-airline'
"Plug 'preservim/tagbar'
"Plug 'hushicai/tagbar-javascript.vim'

"Plug 'majutsushi/tagbar'
"Plug 'preservim/tagbar'



" OpenScad
Plug 'sirtaj/vim-openscad'
call plug#end()
filetype plugin indent on

" Leader.
let mapleader=' '
"set timeoutlen=0
"set timeoutlen=1000
set ttimeoutlen=0
set timeoutlen=3333

" Custom maps.
" Console.
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
" Normal.
nnoremap <Esc> :nohlsearch<CR><Esc>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-n> :tabnext<CR>
nnoremap <C-p> :tabprevious<CR>
nnoremap <Leader>a :Ag<Space>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>g :YcmCompleter GoTo<CR>
nnoremap <Leader>Gr :YcmCompleter RefactorRename<Space>
nnoremap <Leader>n :cnext<CR>
nnoremap <Leader>p :cprevious<CR>
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>q <C-w>q
nnoremap <Leader>r :RangerEdit<CR>
nnoremap <Leader>Ra :RangerAppend<CR>
nnoremap <Leader>Rc :set operatorfunc=RangerChangeOperator<cr>g@
nnoremap <Leader>Ri :RangerInsert<CR>
nnoremap <Leader>Rs :RangerSplit<CR>
nnoremap <Leader>Rt :RangerTab<CR>
nnoremap <Leader>Rv :RangerVSplit<CR>
nnoremap <Leader>s :wall<CR>
nnoremap <Leader>t :$tabnew<CR>
nnoremap <Leader>Tq :tabclose<CR>
"nnoremap <Leader>w :Windows<CR> "Original
nnoremap <Leader>W :Windows<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>y; :edit #<CR>
nnoremap <Leader>yf :ALEFix<CR>
nnoremap <Leader>yn :bnext<CR>
nnoremap <Leader>yp :bprevious<CR>
nnoremap <Leader>yr :edit!<CR>
nnoremap <Leader>yt :BTags<CR>
nnoremap <Leader>zh :History<CR>
nnoremap <Leader>zl :Lines<CR>
nnoremap <Leader>zm :Marks<CR>
nnoremap <Leader>zt :Tags<CR>
nnoremap <Leader>qa :qa<CR>
nnoremap <Leader>fq :q!<CR>
" Format
nnoremap <leader>f :Format<CR>
nnoremap <leader>F :FormatWrite<CR>
" Terminal.
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" Mark Current Line
nnoremap <Leader>ml ml:execute 'match Search /\%'.line('.').'l/'<CR> 
"nnoremap <silent> <Leader>m ml:execute 'match Search /\%'.line('.').'l/'<CR> 
"mark current line with color

"Enable mouse, sometimes it's useful.
set mouse=a

" Color scheme.
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
highlight IncSearch ctermbg=51 ctermfg=white
highlight QuickFixLine ctermbg=gray ctermfg=white
highlight Search ctermbg=45 ctermfg=white
highlight StatusLine ctermbg=white ctermfg=black
highlight StatusLineNC ctermbg=gray ctermfg=white
highlight TabLine ctermbg=gray ctermfg=black
highlight TabLineFill ctermbg=gray
highlight TabLineSel ctermbg=black ctermfg=white
highlight VertSplit ctermbg=gray ctermfg=gray
highlight Visual ctermbg=gray ctermfg=white
highlight WildMenu ctermbg=yellow ctermfg=white

" Misc.
set cmdheight=2
set number

" Searching.
set ignorecase
set smartcase
set inccommand=nosplit

" Open splits to right and bottom, which feels more natural.
set splitbelow
set splitright


" Plugins settings.

" Ale.
let g:ale_fixers = {
\ '*': ['prettier'],
\}

" vim-expand-region.
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Emmet.
let g:user_emmet_mode='i'

" vim-javascript.
let g:javascript_plugin_flow=1

" JSX.
let g:jsx_ext_required=0

" Make YouCompleteMe compatible with UltiSnips (using supertab).
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Better key bindings for UltiSnipsExpandTrigger.
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Fzf.
let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-s': 'split',
\ 'ctrl-v': 'vsplit'
\}

let @a = '0'


set nowrap


highlight dave ctermbg=green ctermfg=red
"highlight TabLine ctermbg=gray ctermfg=black
hi link EasyMotionTarget2First dave
hi link EasyMotionTarget2Second dave
"hi link EasyMotionTarget2third Visual


set termguicolors
colorscheme base16-default-dark " dia
"colorscheme base16-default-light "noche
"colorscheme base16-3024

set cursorline
"nmap <F8> :TagbarToggle<CR>
nmap <F6> :TagbarJumpPrev<CR>
nmap <F7> :TagbarToggle<CR>
nmap <F8> :TagbarJumpNext<CR>
nmap <F9> :TagbarJump<CR>

set laststatus=2
"let g:eleline_slim = 1
"map . :call getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW')) <CR> %%b

nnoremap <Leader>. <cmd>echo getline(search('^[[:alpha:]$_]', 'bcnW'))<CR>
"nnoremap <Leader>. :call getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))<CR> %%b


" Macros kicad projects
" /(pad.* th
nnoremap <Leader>mx /(pad.* th<CR>
let @x = "ftinp_\<Esc>n" "add np_prefix/

nnoremap <Leader>mc /ad.*np_thru<CR>
let @c = "zzj0wvf\"f\"lld\<Esc>n" "Remove net attribute/

"let @c = "jwvf\"f\"dd\<Esc>"
" pad.*np_.*\*.Cu.*\*.Mask
"let @z = "nf*rBf*RB\<Esc>" "works add B layers
nnoremap <Leader>mz /pad.*np_.*\*.Cu.*\*.Mask<CR>
let @z = "zzf*rBf*RB\<Esc>n" "Remove all layers and kepp just B

"Remove silkscreen
"ad.*np_thru.*F
nnoremap <Leader>mv /ad.*np_thru.*F<CR>
let @v = "zzfFhvf\"d\<Esc>n" "Remove silkscreen


"nnoremap <leader>h :execute 'match Search /\V'..escape(expand('<cword>'), '\/')..'/'<CR>

" no indent on comment
"set nosmartindent
"set cindent
"set cinkeys-=0#
"set indentkeys-=0#

"set listchars=tab:▷▷⋮,space:␣
set listchars=eol:⏎,tab:▷▷⋮,trail:~,extends:>,precedes:<,nbsp:⎵,space:␣
"set listchars=eol:⏎,tab:▷▷⋮,trail:␠,nbsp:⎵,space:␣
"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:␣
"set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
" set listchars+=space:␣
noremap <Leader><Tab><Tab> :set invlist<CR>
noremap <Leader><Tab><Tab><Tab> :set nolist<CR>


