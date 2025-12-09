return {
	"chrisgrieser/nvim-spider",
	keys = {
		{
			"<leader>w",
			"<cmd>lua require('spider').motion('w')<CR>",
			mode = { "n", "o", "x" },
		},
		{
			"<leader>b",
			"<cmd>lua require('spider').motion('b')<CR>",
			mode = { "n", "o", "x" },
		},
		{
			"<leader>e",
			"<cmd>lua require('spider').motion('e')<CR>",
			mode = { "n", "o", "x" },
		},
	},
    skipInsignificantPunctuation = false,
    config = function()
        vim.keymap.set("n", "c<leader>w", "c<cmd>lua require('spider').motion('e')<CR>");
    end,
    event = { "BufReadPre", "BufNewFile" },
}
