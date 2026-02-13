return {
    'stevearc/conform.nvim',
    opts = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                markdown = { "mdslw" },
                python = { "black" }
            },
            formatters = {
                mdslw = { prepend_args = { "--stdin-filepath", "$FILENAME" } },
            },
        })
        
        vim.keymap.set("n", "<leader>gq", function() 
            conform.format() 
            vim.cmd [[w]]
        end, {desc="Format entire buffer"})
    end,
    event = { "BufReadPre", "BufNewFile" },
}
