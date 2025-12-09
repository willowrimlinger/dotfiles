return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "debugloop/telescope-undo.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_to_qflist,
          },
          n = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-c>"] = actions.close,
            ["q"] = actions.close,
          },
        },
        cache_picker = {
          num_pickers = 25,
        },
      },
      extensions = {
        undo = {
          -- telescope-undo.nvim config, see https://github.com/debugloop/telescope-undo.nvim
        },
        -- other extensions:
        -- file_browser = { ... }
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("undo")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Files" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "String" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "String under cursor" })
    keymap.set("n", "<leader>fp", "<cmd>Telescope resume<cr>", { desc = "Prev Telescope session" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope pickers<cr>", { desc = "Telescope history" })
    keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "Undo Tree" })
  end,
}
