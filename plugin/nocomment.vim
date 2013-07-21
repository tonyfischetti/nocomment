""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILE:     plugin/nocomment.vim {{{
" AUTHOR:   Tony Fischetti <tony.fischetti@gmail.com>
" WEBSITE:  https://github.com/tonyfischetti/nocomment
" VERSION:  0.0.1
" LICENSE:
" nocomment - Vim plugin to easily and nicely comment and uncomment visual
"             blocks
" Copyright (C) 2013-__YEAR__ Tony Fischetti
"
" MIT License
" 
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
" 
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
" 
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""

if !has('python')
    echo "Compiling vim with python support is required to use the plugin"
    finish
endif


function! CommentVisualSelection()

python << EOF

import vim
import re

first_line = vim.current.buffer.mark('<')[0] - 1
last_line = vim.current.buffer.mark('>')[0]
for index in range(first_line, last_line):
    current_line = vim.current.buffer[index]
    if not re.match(current_line, "^\s*$"):
        vim.current.buffer[index] = "# " + current_line

EOF

endfunction

