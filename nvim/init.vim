" Defer full Lua migration. Source the shared vimrc for now.
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
