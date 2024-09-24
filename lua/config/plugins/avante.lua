return {
	{
		"yuzhegan/avante.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
				-- keys = {
				-- 	{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
				-- }

				keys = {
					{
						"<leader>ip",
						function()
							return vim.bo.filetype == "AvanteInput" and require("avante.clipboard").paste_image()
									or require("img-clip").paste_image()
						end,
						desc = "clip: paste image",
					},
				}

			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},






		hints = { enabled = true },
		windows = {
			---@type "right" | "left" | "top" | "bottom"
			position = 'right', -- the position of the sidebar
			wrap = true,     -- similar to vim.o.wrap
			width = 30,      -- default % based on available width
			sidebar_header = {
				align = 'center', -- left, center, right for title
				rounded = true,
			},
		},
		highlights = {
			---@type AvanteConflictHighlights
			diff = {
				current = 'DiffText',
				incoming = 'DiffAdd',
			},
		},
		--- @class AvanteConflictUserConfig
		diff = {
			autojump = true,
			---@type string | fun(): any
			list_opener = 'copen',
		},

		-- width
		event = "VeryLazy",
		build = "make",
		opts = {
			-- provider = "copilot",
			provider = "claude",
			copilot = {
				endpoint = "https://api.githubcopilot.com",
				model = "gpt-4o-2024-05-13",
				proxy = nil,        -- [protocol://]host[:port] Use this proxy
				allow_insecure = false, -- Allow insecure server connections
				timeout = 30000,    -- Timeout in milliseconds
				temperature = 0,
				max_tokens = 4096,
			},
			openai = {
				endpoint = "https://api.gpt.ge/v1",
				model = "gpt-4o",
				-- model = "o1-preview",
				proxy = nil,        -- [protocol://]host[:port] Use this proxy
				allow_insecure = false, -- Allow insecure server connections
				timeout = 30000,    -- Timeout in milliseconds
				temperature = 0,
				max_tokens = 4096,
			},

			claude = {
				endpoint = "https://api.gpt.ge/v1",
				model = "claude-3-5-sonnet-20240620",
				-- model = "gpt-4o",
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
