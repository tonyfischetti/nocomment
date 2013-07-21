""""""""""""""""""""""""""""""""""""""""""""""""""""
""                                                ""
""              nocommment.vim                    ""
""                                                ""
""    Author: Tony Fischetti                      ""
""    Email: tony.fischetti@gmail.com             ""
""                                                ""
""    Comment and un-comment visual selections    ""
""    in Vim nicely                               ""
""                                                ""
""    Version: 0.0.1                              ""
""                                                ""
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

