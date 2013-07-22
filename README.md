# Introduction

NoComment--misleading name notwithstanding--is a Vim plugin to easily and nicely comment and uncomment 
visual blocks. I just started it and it's at version 0.0.1 so there's
more 'readme' coming soon!

Installation
------------


[pathogen.vim](https://github.com/tpope/vim-pathogen) is the best way to
install packages in Vim. After pathogen is installed, navigate to your
vim bundle folder,

    cd ~/.vim/bundle

and run the following command

    git clone https://github.com/tonyfischetti/nocomment.git


Usage
------------
To select a block of code to comment/uncomment, use `Shift-V` and use either
the arrow keys, or better, `j` and `k`, to move up or down. After you're 
satisfied, press `Control-C` to comment the block, or `Control-X` to
uncomment it. 
