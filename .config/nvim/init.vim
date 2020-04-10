call plug#begin('~/.local/share/nvim/plugged')

Plug 'w0rp/ale'
Plug 'Raimondi/delimitMate'
Plug 'mattn/emmet-vim'
Plug 'davidhalter/jedi-vim'
Plug 'Valloric/MatchTagAlways'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'nvie/vim-flake8'
Plug 'fatih/vim-go'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'justinj/vim-react-snippets'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'lepture/vim-jinja'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'nanotech/jellybeans.vim'

call plug#end()

" Use space instead of tabs 4 chars
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround

" Some files get two spaces
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType puppet setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType htmldjango setlocal ts=2 sts=2 sw=2 expandtab

" text wrapping
set nowrap  " dont auto wrap on load
set fo-=t   " dont wrap when typing

" Enable auto indenting
filetype plugin indent on

" Identing options.
set autoindent

" Dark background
set background=dark

" Syntax highlighting of course.
syntax enable

" Enable 256 colours
set t_Co=256

" Colorscheme
colorscheme jellybeans

" Add column at 80 char
set colorcolumn=80
highlight ColorColumn ctermbg=232

" line numbers on
set number

" mouse mode
set mouse=a

" Highlight matching parenthesis
set showmatch

" show autocompletion menu when opening files
set wildmenu

" fix backspace
set bs=2

" easier indenting of code blocks
vnoremap < <gv
vnoremap > >gv

" Automatically resize splits
autocmd VimResized * wincmd =

" Global replace by default
set gdefault

" If i search in uppercase, it's case sensitive. If I search in lowercase,
" it isn't.
set smartcase
" Search as I type
set incsearch

" Scroll sideways a character at a time, rather than a screen at a time
set sidescroll=1

" Allow tab completion in command bar
set wildmenu
set wildmode=full

" make status bar 2 lines
set laststatus=2

" show hidden characters
nnoremap <silent><F6> :set list!<CR>

" Stops the cursor reaching the bottom of the screen
set scrolloff=3

" tap F3 to toggle line numbers
nnoremap <silent><F3> :set number!<CR>

" Tap leader g to toggle gitgutter
nmap <Leader>g :GitGutterToggle<CR>

" show spelling mistakes by pressing F10. Move over a word and press tap z=
" (not in insert mode) to get a list of suggestions
noremap <silent><F10> :set spell!<CR>

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Map Nerdtree
map <Leader>n :NERDTreeToggle<CR>

" Start Nerdtree if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Disable gitgutter by default
let g:gitgutter_enabled = 0

" Golang highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" vim-go mappings
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>gs <Plug>(go-implements)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <Leader>gr <Plug>(go-rename)

" Enable goimports
let g:go_fmt_command = "goimports"

" Map leader W to save without sudo
noremap <Leader>w :w !sudo tee % > /dev/null

" Format JSON files to be readable
nnoremap <Leader>f :%!python -m json.tool<CR>

" Create undo dir to save undo after closing files
set undofile
set undodir=~/.vim/undodir

" Enable neocomplete
let g:neocomplete#enable_at_startup = 1

" use neocomplete for python using jedi-vim
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures = 2
" Disable autopopup of docstring
autocmd FileType python setlocal completeopt-=preview
" jedi-vim keyboard shortcuts
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>a"
let g:jedi#goto_definitions_command = "<leader>s"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>u"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" Add pdb debug call to line with leader-p
map <Leader>p :call InsertLine("import pdb; pdb.set_trace")<CR>

function! InsertLine(command)
  let trace = expand(a:command)
  execute "normal o".trace
endfunction

" Settings for ALE linter
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_linter_aliases = {'javascript.jsx': 'javascript', 'jsx': 'javascript'}
highlight clear ALEErrorSign
highlight clear ALEWarningSign
" Lint jsx files
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

" airline config
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1

" if hidden is not set, TextEdit might fail.
set hidden

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
