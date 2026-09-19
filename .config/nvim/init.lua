vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.tabstop = 4 -- the tab key
vim.opt.shiftwidth = 4 -- <> operations
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('$HOME/.undodir')
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.listchars= 'tab:> ,trail:·,nbsp:+'
vim.opt.list = true
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.fixendofline = true
vim.opt.endofline = true
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.cmd.packadd('nvim.undotree')

vim.pack.add({
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/tpope/vim-surround',
    'https://github.com/tpope/vim-repeat',
    'https://github.com/tpope/vim-vinegar',
    'https://github.com/dmtrKovalenko/fff',
})

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'fff.nvim' and (kind == 'install' or kind == 'update') then
            if not ev.data.active then vim.cmd.packadd('fff.nvim') end
            require('fff.download').download_or_build_binary()
        end
    end,
})

vim.g.fff = {
    lazy_sync = true,
}

require('fff').setup({
    prompt = '> ',
    hl = {
        normal = "Normal",
        border = "Normal",
      },
})

-- Not really using this since fff
function UseFd(cmdarg, cmdcomplete)
    local files = vim.fn.systemlist('fd --type f --hidden -E .git --full-path')

    if cmdarg == nil or cmdarg == "" then
        return files
    end

    local matches = vim.fn.matchfuzzy(files, cmdarg or '')
    return matches
end
vim.opt.findfunc = "v:lua.UseFd"

local map = vim.keymap.set
map('n', '<Space>', '<Nop>')
map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')
map('n', '<C-n>', '<cmd>cnext<cr>')
map('n', '<C-p>', '<cmd>cprev<cr>')
map('n', '<leader>q', '<cmd>copen<cr>')
map('n', '<leader>Q', '<cmd>cclose<cr>')
map('n', '<leader>u', '<cmd>Undotree<cr>')
map('i', '<C-s>', 'std::', { noremap = true, silent = true })
map('n', '<leader>f', require('fff').find_files)
map('n', '<leader>g', require('fff').live_grep)
map('n', '<leader>m', ':make ')

map('n', '<leader>ts', function()
  local timestamp = os.date('%Y-%m-%dT%H:%M:%S%z')
  vim.api.nvim_put({ timestamp }, 'c', true, true)
end, { desc = 'Insert timestamp' })
