""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILE:     plugin/nocomment.vim {{{
" AUTHOR:   Tony Fischetti <tony.fischetti@gmail.com>
" WEBSITE:  https://github.com/tonyfischetti/nocomment
" VERSION:  0.1.0
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

" check if vim has python support
if !has('python')
    echo "Compiling vim with python support is required to use the plugin"
    finish
endif

" check to see it it's already loaded
if exists("loaded_nocomment_plugin")
    finish
endif

let loaded_nocomment_plugin = 1


" Mappings
vnoremap <silent> <C-C> :<C-U>call NCCommentSelection()<CR>
" vnoremap <silent> <C-X> :call NCUnCommentSelection()<CR>



"""
""" comment selection function
"""
function! NCCommentSelection()

python << EOF

import vim
import sys
import re

# dictionary holding the start and end comment characters
# (in a tuple) as a key to lists that contains the vim
# filetypes that use those comment characters
com_chars= {("#", ""): ["python", "perl", "ruby"],
            ("//", ""): ["java", "c", "cpp"],
            ('"', ""): ["vim"]}

# get filetype of current buffer
v_file_type = vim.eval("&ft")

# declare the start and end characters that
# we will be using on the text in the buffer
start_com, end_com = (None, None)

# find the appropriate comment chars
for key in com_chars:
    if v_file_type in com_chars[key]:
        print key
        start_com, end_com = key

# if we can find them, break out
if not start_com:
    print "Filetype not supported by this plugin"
    sys.exit(1)

# get the line numbers flanking the selection
first_line = vim.current.buffer.mark('<')[0] - 1
last_line = vim.current.buffer.mark('>')[0]

# find line with least amount of whitespace
min_ws = " "*1000
for index in range(first_line, last_line):
    current_line = vim.current.buffer[index]
    if not re.match(current_line, "^\s*$"):
        leading_ws = re.match("(\s*)\w", current_line).group(1)
        if len(leading_ws) < len(min_ws):
            min_ws = leading_ws

for index in range(first_line, last_line):
    current_line = vim.current.buffer[index]
    if not re.match(current_line, "^\s*$"):
        if end_com:
            end_com = " " + end_com
        new_line = min_ws + start_com + " "
        new_line += current_line.replace(min_ws, "", 1) + end_com
        vim.current.buffer[index] = new_line

EOF

endfunction

