-- Purpose: colorscheme for neovim
-- Link: https://github.com/catppuccin/nvim

return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        config = function()
            require('catppuccin').setup {
                flavour = 'mocha', -- Options: latte, frappe, macchiato, mocha
                -- https://github.com/catppuccin/nvim#integrations
                integrations = {
                    --cmp = true,
                    gitsigns = true,
                    --mason = true,
                    -- lualine = true, -- DIDN'T WORK FOR CATPUCCIN
                    neotree = true,
                    --treesitter = true,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = '',
                    },
                    telescope = {
                        enabled = true,
                        -- style = "nvchad"
                    },
                },
            }
            vim.cmd.colorscheme 'catppuccin'
        end,
    },
}
