-- Purpose: This plugin adds indentation guides to Neovim.
-- Link: https://github.com/lukas-reineke/indent-blankline.nvim

return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
        indent = {
            char = '▏',
        },
        scope = {
            show_start = false,
            show_end = false,
            show_exact_scope = false,
        },
        exclude = {
            filetypes = {
                'help',
                'startify',
                'dashboard',
                'packer',
                'neogitstatus',
                'NvimTree',
                'Trouble',
            },
        },
    },
}
