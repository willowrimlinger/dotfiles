return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
        local treesitter = require("nvim-treesitter")

        treesitter.setup({
            ensure_installed = {
                "c",
                "lua",
                "typescript",
                "tsx",
                "html",
                "python",
                "markdown",
                "markdown_inline",
            },
            sync_install = false,
            highlight = { enable = true },
        })
    end
 }
