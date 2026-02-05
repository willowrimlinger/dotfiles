return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
        autopairs = require("nvim-autopairs");
        autopairs.setup({
            fast_wrap = {}
        });
        autopairs.get_rules("'")[1].not_filetypes = { "scheme", "lisp", "racket" };
    end
}
