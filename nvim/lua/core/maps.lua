local map = require('utils.map')

-- Change word under the cursor
-- move to next/prev instance by using n/N
-- replace next/prev instance by using .
map.set('n', '<LEADER>x', '*``cgn')

-- Toggle spell checking
map.set('n', '<F2>', ':set spell!<CR>')
map.set('i', '<F2>', ':set spell!<CR>')

-- Inc/Dec number under cursor
map.set('n', '+', '<C-a>')
map.set('n', '-', '<C-x>')

-- Window splits
map.set('n', '<C-v>', ':vsplit<CR>')
map.set('n', '<C-s>', ':split<CR>')

-- Moving between splits
map.set('n', '<C-w>', '<C-w>w')
map.set('n', '<C-h>', '<C-w>h')
map.set('n', '<C-l>', '<C-w>l')
map.set('n', '<C-j>', '<C-w>j')
map.set('n', '<C-k>', '<C-w>k')

-- Rotating splits
map.set('n', '<C-R>', '<C-w>R')
map.set('n', '<C-r>', '<C-w>r')

-- Resizing splits
map.set('n', '<C-S-l>', ':vertical resize +5<CR>')
map.set('n', '<C-S-h>', ':vertical resize -5<CR>')
map.set('n', '<C-S-j>', ':resize +5<CR>')
map.set('n', '<C-S-k>', ':resize -5<CR>')

map.set("v", "<", "<gv", { desc = "Indent lines out" })
map.set("v", ">", ">gv", { desc = "Indent lines in" })

-- Moving lines
map.set('n', 'J', ':m+1<CR>')
map.set('n', 'K', ':m-2<CR>')
map.set("v", "J", ":m'>+<CR>gv")
map.set('v', 'K', ':m-2<CR>gv')

-- Switching Buffers
map.set('n', '<Tab>', ':bn<CR>')
map.set('n', '<S-Tab>', ':bp<CR>')

-- Select entire file
map.set('n', '<C-a>', 'ggVG')
map.set('i', '<C-a>', '<Esc>ggVG')

map.set("n", "d", '"_d') -- Dont't save to clipboard on d
map.set("n", "c", '"_c') -- Dont' save to clipboard on c
map.set("x", "p", '\"_dP') -- Dont't copy when pasting over something 
map.set("n", "X", "dd") -- Cut line on Shift+x

map.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

map.set('n', "<C-d>", '<C-d>zz')
map.set('n', "<C-u>", '<C-u>zz')

-- map('n', 's', '<Plug>Lightspeed_omni_s')
-- map('n', 'gs', '<Plug>Lightspeed_omni_gs')
