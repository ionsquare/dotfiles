"===== Vundle plugin manager =====================
so ~/.vim/plugins.vim

"===== NERDTree ==================================
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <leader>f :NERDTreeFind<cr>
map <C-N> :NERDTreeToggle<CR>
let NERDTreeHijackNetrw = 0
" delete buffer without quitting
nnoremap <leader>q :bp<cr>:bd #<cr>

"===== CtrlP Mappings ============================
nmap <C-P> :CtrlP<cr>
"nmap <C-S-P> :CtrlPMRUFiles<cr>
"nmap <C-S-P> :CtrlPBuffer<cr>
"let g:ctrlp_custom_ignore = 'git'

"===== Ack.vim Searching =========================
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"===== Markdown Preview ==========================
let vim_markdown_preview_temp_file=1
let vim_markdown_preview_hotkey='<leader>p'
"let vim_markdown_preview_browser='firefox'
let vim_markdown_preview_github=1
let vim_markdown_preview_use_xdg_open=1

"===== Snippets and Completion ===================
" Fix directory
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

" Better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"===== Colour scheme stuff =======================
syntax on
try
  let g:jellybeans_overrides = {
  \    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
  \    'search': { 'guibg': '00ff00', 'guifg': '000000', 'attr': 'bold' },
  \}
  colo jellybeans
catch /^Vim\%((\a\+)\)\=:E185/
  colo koehler
endtry

"===== General settings ==========================
set nosmartindent cindent cinkeys-=0#
set number hlsearch incsearch lbr
set ts=2 shiftwidth=2 expandtab
set mouse=cin
set foldmethod=indent foldlevelstart=99
set nojoinspaces        " Don't add 2 spaces after . when joining
set diffopt+=iwhite     " Ignore whitespace mismatch in diff
set wildmenu            " Show some autocomplete options in status bar
set backspace=2         " Make backspace key work properly
set hidden              " Don't discard undo history when changing buffers
" Load filetype-specific plugins if exists
filetype plugin indent on

"===== Powerline =================================
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2
set t_Co=256

"===== Leader hotkeys ============================
" Turn hlsearch off
nmap <leader><space> :noh<cr>
nmap <leader>ev :tabedit ~/.vimrc<cr>
nmap <leader>ep :e ~/.vim/plugins.vim<cr>
nmap <leader>ea :e ~/.config/awesome/rc.lua<cr>
nmap <leader>ez :e ~/.zshrc<cr>
nmap <leader>ex :tabnew ~/.Xdefaults<cr>

"===== Laravel Mappings ==========================
nmap <Leader>lr :e routes/web.php<cr>
nmap <Leader>le :e .env<cr>
nmap <Leader>lm :!php artisan make:
nmap <Leader>lfc :e app/Http/Controllers/<cr>
nmap <Leader>lfm :e app/<cr>
nmap <Leader>lfv :e resources/views<cr>
nmap <Leader>lft :e tests<cr>

"===== Bookmarks (signs) =========================
hi default BookmarkCol ctermbg=17 cterm=bold guifg=DarkBlue guibg=#d0d0ff gui=bold
sign define MyBookmark linehl=BookmarkCol text=>>
map <leader>bb :exe 'sign place 1000 name=MyBookmark line='.line(".").' buffer='.winbufnr(0)<CR>
map <leader>bd :sign unplace 1000 <cr>
map <leader>bl :sign list<cr>

"===== Force save with sudo escalation ===========
cmap w!! w !sudo tee > /dev/null %

"===== Aliases for commonly mistyped commands ====
command! -nargs=? -complete=file W w <args>
command! -nargs=? -complete=file Tabnew tabnew <args>

"===== Key Mappings ==============================

" Scrolling
map  <c-up>        <c-y>
imap <c-up>   <c-o><c-y>
map  <c-down>      <c-e>
imap <c-down> <c-o><c-e>

" Home/end keys
map  <home>      g0
imap <home> <c-o>g0
map  <end>       g$
imap <end>  <c-o>g$

" Word jumping
map  <c-right>        w
imap <c-right>   <c-o>w
map  <c-s-right>      W
imap <c-s-right> <c-o>W
map  <c-left>         b
imap <c-left>    <c-o>b
map  <c-s-left>       B
imap <c-s-left>  <c-o>B

" Tab switching
map  <c-pageup>        gT
imap <c-pageup>   <c-o>gT
map  <c-pagedown>      gt
imap <c-pagedown> <c-o>gt

" Window switching
map  <c-s-left>       <c-w><left>
imap <c-s-left>  <c-o><c-w><left>
map  <c-s-right>      <c-w><right>
imap <c-s-right> <c-o><c-w><right>
map  <c-s-up>         <c-w><up>
imap <c-s-up>    <c-o><c-w><up>
map  <c-s-down>       <c-w><down>
imap <c-s-down>  <c-o><c-w><down>

" Window resizing
map <M-S-Left> :vertical resize -10<cr>
map <M-S-Right> :vertical resize +10<cr>
map <M-S-Up> :resize -10<cr>
map <M-S-Down> :resize +10<cr>

" ctrl+del
imap <c-delete> <c-o>dw

"===== Auto Commands =============================
augroup autosourcing
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
  autocmd BufWritePost ~/.vim/plugins.vim source ~/.vim/plugins.vim
  autocmd BufWritePost .Xdefaults,Xresources silent exec "!xrdb %"
augroup END

"===== Helper Functions ==========================
" Diff current buffer with saved copy
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Diff current buffer with what's in git
function! s:DiffWithGITCheckedOut()
  let filetype=&ft
  diffthis
  vnew | exe "%!git diff " . expand("#:p:h") . "| patch -p 1 -Rs -o /dev/stdout"
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  diffthis
endfunction
com! DiffGIT call s:DiffWithGITCheckedOut()
