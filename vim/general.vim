" general.vim
"
" @package myutilitybelt
" @subpackage vim
" @author schrodervictor <schrodervictor@gmail.com>

" === VI COMPATIBLE MODE ===
" nocompatible is needed to some cool vim stuff
set nocompatible

" === MODELINE ===
" disable modeline, security reasons
" see: http://lists.alioth.debian.org/pipermail/pkg-vim-maintainers/2007-June/004020.html
set nomodeline

" === BACKUP SETTINGS ===
" turn backup OFF
" Normally we would want to have it turned on. See bug and workaround below.
" OBS: It's a known-bug that backupdir is not supporting
" the correct double slash filename expansion
" see: https://code.google.com/p/vim/issues/detail?id=179
set nobackup

" set a centralized backup directory
set backupdir=~/.vim/backup//

" This is the workaround for the backup filename expansion problem.
autocmd BufWritePre * :call SaveBackups()

function! SaveBackups()
  if expand('%:p') =~ &backupskip | return | endif
  if !filereadable(@%) | return | endif

  for l:backupdir in split(&backupdir, ',')
    :call SaveBackup(l:backupdir)
  endfor
endfunction

function! SaveBackup(backupdir)
  let l:filename = expand('%:p')
  if a:backupdir =~ '//$'
    let l:backup = escape(substitute(l:filename, '/', '%', 'g')  . &backupext, '%')
  else
    let l:backup = escape(expand('%') . &backupext, '%')
  endif

  let l:backup_path = a:backupdir . l:backup
  :silent! execute '!cp ' . resolve(l:filename) . ' ' . l:backup_path
endfunction

" === SWAP FILES ===
" turn swap files ON
set swapfile
" set a centralized swap directory
" the double // prevents filename collisions
" the last slash will expand to the full path
" with the slashes replaced by %
set directory=~/.vim/swap//

" === UNDO FILES ===
" turn undofiles ON
set undofile
" set a centralized undo directory (forever UNDO steps!)
" the double // prevents filename collisions
" the last slash will expand to the full path
" with the slashes replaced by %
set undodir=~/.vim/undo//

" === TIMEOUT ===
" The combination of timeout=off and ttimeout=on means that timeouts will
" be applied only to key codes (<Esc> prefixed keys).
set notimeout
set ttimeout
" Set the ttimeoutlen to a small value, but greater than zero.
" Because we are using notimeout, this ttimeoutlen will be applied only
" for key codes, but not for mappings. Mappings would follow the timeoutlen
" but because we use notimeout, mappings never timeout.
set ttimeoutlen=100

" === CHARACTER ENCODING ===
set encoding=utf-8

" === VIRTUAL EDIT ===
" allows virtual edit on visual mode
" useful for selecting a rectangle, even where a character doesn't exist
set virtualedit=block

" === BACKSPACE ===
" allows backspace over autoindent, line breaks and the start of an insert
set backspace=indent,eol,start

" === HIDDEN BUFFERS ===
" disables hidden buffers
set nohidden

" === NETRW HISTORY ===
" disables netrw history
let g:netrw_dirhistmax = 0
" disables banner
let g:netrw_banner = 0
" tree style
let g:netrw_liststyle = 3

" === FILE FINDER ===
" this little setting allow some nice fuzzy find recursively
set path+=**,.modman/**

" === AUTOCOMMANDS ===
" I never use modula2 files, but a lot of markdown with .md extension
autocmd BufRead,BufNewFile *.md set filetype=markdown
