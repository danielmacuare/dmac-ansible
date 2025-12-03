-- Purpose: Auto-formatting using conform.nvim
-- Link: https://github.com/stevearc/conform.nvim

return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_format', 'ruff_organize_imports' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        terraform = { 'terraform_fmt' },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
      formatters = {
        shfmt = {
          prepend_args = { '-i', '4' },
        },
        ruff_organize_imports = {
          command = 'ruff',
          args = { 'check', '--select', 'I', '--fix', '--stdin-filename', '$FILENAME', '-' },
        },
      },
    }

    -- Keymap for manual formatting
    vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = 'Format file or range (in visual mode)' })
  end,
}
