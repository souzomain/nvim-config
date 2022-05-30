lua << EOF
-- Add additional capabilities supported by nvim-cmp
local lspconfig = require('lspconfig')
local lsputil = require('lspconfig.util')
local cmp = require('cmp')

local on_attach = function(client,bufnr)
    opts = { noremap = true, silent = true }
    local function set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    set_keymap('n', '<C-k>','<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    set_keymap('i', '<C-k>','<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--    nset_keymap('')
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
        vim.api.nvim_command [[augroup END]]
    end
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_command [[augroup highlight]]
        vim.api.nvim_command [[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]

        vim.api.nvim_command [[autocmd CursorHold <buffer> lua vim.diagnostic.open_float()]]
        vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.diagnostic.open_float()]]

        vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
        vim.api.nvim_command [[autocmd CursorMovedI <buffer> lua vim.lsp.buf.clear_references()]]
        vim.api.nvim_command [[augroup END]]
    end
end

local root_files = {
    'compile_flags.txt',
    '.ccls',
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = { 'ccls', 'pyright', 'bashls' }
for _, server in ipairs(servers) do
    if server == 'ccls' then
        lspconfig[server].setup{
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = function(fname)
                return lsputil.root_pattern(unpack(root_files))(fname) or vim.fn.getcwd()
            end
        }
    else
        lspconfig[server].setup{
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = function(fname)
                return vim.fn.getcwd()
            end
       }
   end

end

cmp.setup {
    snippet = {
        expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm{
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    }),
}

require 'nvim-autopairs'.setup()
require 'nvim-treesitter.configs'.setup{
    highlight = {
        enable = true,
    }
}
EOF
