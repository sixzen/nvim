return {
	{ "nvim-tree/nvim-web-devicons", event = "BufRead", opts = {
		override = {},
		default = true,
	} }, -- File icons
	{
		"tpope/vim-dispatch",
		cmd = { "Make", "Dispatch" },
	},
	{ "tpope/vim-surround", event = "BufRead" },
	{ "tpope/vim-repeat", event = "BufRead" },
	{ "tpope/vim-rhubarb", event = "BufRead" },
	{ "tpope/vim-dotenv", event = "BufRead" },
	{ "tpope/vim-eunuch", event = "BufRead" },
	{ "tpope/vim-sleuth", event = "BufRead" },
	{
		"axelvc/template-string.nvim",
		ft = { "typescript", "javascript", "typescriptreact", "javascriptreact", "python" },
		opts = {
			filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "python" }, -- filetypes where the plugin is active
			jsx_brackets = true, -- must add brackets to jsx attributes
			remove_template_string = false, -- remove backticks when there are no template string
			restore_quotes = {
				-- quotes used when "remove_template_string" option is enabled
				normal = [[']],
				jsx = [["]],
			},
		},
	},
	{ "folke/todo-comments.nvim", event = "BufRead", dependencies = "nvim-lua/plenary.nvim", config = true },
	{ "mg979/vim-visual-multi", event = "BufRead" },
	{
		"rmagatti/alternate-toggler",
		keys = "<leader>ta",
		config = function()
			vim.keymap.set("n", "<leader>ta", "<cmd>ToggleAlternate<cr>")
		end,
	},
	{
		"folke/neodev.nvim",
		event = "BufRead",
	},

	{ "SmiteshP/nvim-navic", lazy = true }, -- Breadcrumb
	{ "norcalli/nvim-colorizer.lua", event = "BufRead", opts = {
		"*",
	} },
}
