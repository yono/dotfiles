""""""""""""""""
" .vimrc
" utf-8
""""""""""""""""

" neobundle
filetype plugin indent off

" initialize

if has('vim_starting')
  set runtimepath+=$HOME/.bundle/neobundle.vim/
end

call neobundle#begin(expand('$HOME/.bundle/'))

" bundle
" その他
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \    },
    \ }
NeoBundle 'Railscasts-Theme-GUIand256color'

" ruby
NeoBundle 'taichouchou2/vim-endwise.git'
NeoBundle 'ruby-matchit'
NeoBundle 'vim-scripts/AnsiEsc.vim'

NeoBundle 'jtratner/vim-flavored-markdown'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'edkolev/tmuxline.vim'

NeoBundle 'tpope/vim-fugitive'

NeoBundle 'cakebaker/scss-syntax.vim'

NeoBundle 'kchmck/vim-coffee-script'

NeoBundle 'airblade/vim-gitgutter'

NeoBundle 'elzr/vim-json'

NeoBundle 'nathanaelkane/vim-indent-guides'

NeoBundle 'mxw/vim-jsx'

NeoBundle 'slim-template/vim-slim'

NeoBundle 'tpope/vim-haml'

NeoBundle 'Shougo/unite.vim'

NeoBundle 'ctrlpvim/ctrlp.vim'

NeoBundle 'kana/vim-tabpagecd'

NeoBundle 'szw/vim-tags'

NeoBundle 'posva/vim-vue'

call neobundle#end()

filetype plugin indent on

let mapleader = ','

"-----------------------
" カラー表示
"-----------------------
set term=ansi

"-----------------------
" 256 色を使用
"-----------------------
set t_Co=256

"-----------------------
" vi との互換モードOFF
"-----------------------
set nocompatible

"-----------------------
" 文字コード設定
"-----------------------
set enc=utf-8
set fencs=iso-2022-jp,utf-8,cp932,euc-jp

"-----------------------
" 行末の空白文字を可視化
"-----------------------
highlight WhitespaceEOL cterm=underline ctermbg=red guibg=#666666
au BufWinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')
au WinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')
set list
set listchars=tab:\ \ ,extends:<,trail:\
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

"-----------------------
" 全角スペースの表示
"-----------------------
highlight ZenkakuSpace cterm=underline ctermbg=red guibg=#666666
au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')

"-----------------------
" ディレクトリを自動生成
"-----------------------
augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir) && (a:force ||
            \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup END

set encoding=utf-8
"set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,sjis,cp932,utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,sjis,cp932
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

syntax on
colorscheme railscasts

"-----------------------
" 検索関連の設定
"-----------------------
set ignorecase " 検索時に大文字小文字を区別しない
set smartcase  " 検索文字列に大文字が含まれている場合は区別
set wrapscan   " 折り返し検索を有効にする
set incsearch  " インクリメンタル検索を行う
set hlsearch   " 検索結果をハイライト表示する

" ESC 連打でハイライト消去
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" 検索時に結果が中央に来るようにする
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

"-----------------------
" インデント関連の設定
"-----------------------
set autoindent    " 自動インデントモード
set cindent       " C言語スタイルのインデント機能
set tabstop=2     " タブ表示に割り当てる半角スペースの個数
set shiftwidth=2  " インデントで使われる際の半角スペースの個数
set expandtab     " タブ入力を半角スペースに置き換える
set softtabstop=2 " キーボードでタブ入力した際の半角スペースの個数

"-----------------------
" 表示関連の設定
"-----------------------
set number        " 行数表示
set noruler       " ルーラーを非表示
set nolist        " 隠し文字を非表示
set showmatch     " () や {} の対応を表示
set wrap          " 長い行を折り返して表示
set title         " タイトルバーを表示
set showcmd       " コマンドをステータス行に表示
set cmdheight=2   " コマンドラインの高さ
set laststatus=2  " 常にステータス業を表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}
set wildmenu      " コマンドライン補完が拡張モードで行われる

set backspace=2         " 改行後に BS を押すと上の行末の1文字消去
set scrolloff=5         " スクロール時の余白確保
set formatoptions+=mM   " 日本語行の連結時には空白を入力しない
set nobackup            " バックアップを取らない
set history=1000        " 履歴を1000残す
set visualbell          " ビジュアルベルを使用

"-----------------------
" 全角スペースを視覚化
"-----------------------
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

"-----------------------
" キーバインド変更
"-----------------------
" ; でコマンド入力( ;と:を入れ替え)
noremap ; :
noremap : ;

"-----------------------
" カレントディレクトリを自動的に切り替える
"-----------------------
if has('autochdir')
    set autochdir
endif

"-----------------------
" ローマ字のまま日本語をインクリメンタル検索
"-----------------------
if has('migemo')
    set migemo
endif

"-----------------------
" kaoriya パッチが含まれている場合有効化
"-----------------------
if has('kaoriya')
    set iminsert=0
    set imsearch=0
endif


"-----------------------
" プラグイン有効化
"-----------------------
filetype plugin indent on

"------------------------------------------------
"
" 以下、プラグインの設定
"
"------------------------------------------------

"-----------------------
" ファイルエクスプローラ
"-----------------------
let loaded_explorer=1

"-----------------------
" Ruby, Rails の設定
"-----------------------
autocmd FileType ruby set tabstop=2 tw=0 sw=2 expandtab
autocmd FileType eruby set tabstop=2 tw=0 sw=2 expandtab
autocmd BufNewFile,BufRead app/*/*.rhtml set ft=mason fenc=utf-8
autocmd BufNewFile,BufRead app/**/*.rb set ft=ruby fenc=utf-8
autocmd BufNewFile,BufRead app/**/*.yml set ft=ruby fenc=utf-8
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim

" endwise.vim
let g:endwise_no_mappings=1

let g:tmuxline_powerline_separators = 0

" enable with vim-markdown **not vim-flavored-markdown**
let g:markdown_fenced_languages = ['ruby', 'sh']

" vim-flavored-markdown
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc 新しいタブを一番右に作る
nnoremap tc :tabnew<CR>
" tx タブを閉じる
nnoremap tx :tabclose<CR>
" tn 次のタブ
nnoremap tn :tabnext<CR>
" tp 前のタブ
nnoremap tp :tabprevious<CR>

" vim-indent-guides
" 起動時に自動的にON
let g:indent_guides_enable_on_vim_startup=1
" 色を自分で指定する
let g:indent_guides_auto_colors=0
" ガイドをスタートするインデントの量
let g:indent_guides_start_level=2
" 色指定
hi IndentGuidesOdd  ctermbg=darkgrey
hi IndentGuidesEven ctermbg=black
" ガイドの幅
let g:indent_guides_guide_size=1

set backupskip=/tmp/*,/private/tmp/*

" http://blog.ruedap.com/2011/01/10/vim-unite-plugin
noremap <silent> ,ug :<C-u>Unite grep/git:.<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cwd' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cwd' : 'CurrentDirectory',
      \ },
      \ }

function! CurrentDirectory()
    return fnamemodify(getcwd(), ':t')
endfunction
