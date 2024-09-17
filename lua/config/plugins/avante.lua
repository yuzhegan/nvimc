return {
	{
		"yetone/avante.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
		event = "VeryLazy",
		build = "make",
		opts = {
			provider = "copilot",
			copilot = {
				endpoint = "https://api.githubcopilot.com",
				model = "gpt-4o-2024-05-13",
				proxy = nil,        -- [protocol://]host[:port] Use this proxy
				allow_insecure = false, -- Allow insecure server connections
				timeout = 30000,    -- Timeout in milliseconds
				temperature = 0,
				max_tokens = 4096,
			},
			mappings = {
				ask = "<leader>aa",
				edit = "<leader>ae",
				refresh = "<leader>ar",
				diff = {
					ours = "co",
					theirs = "ct",
					both = "cb",
					next = "]x",
					prev = "[x",
				},
				jump = {
					next = "]]",
					prev = "[[",
				},
				submit = {
					normal = "<CR>",
					insert = "<C-s>",
				},
				toggle = {
					debug = "<leader>ad",
					hint = "<leader>ah",
				},
			},
		},
	},
}
