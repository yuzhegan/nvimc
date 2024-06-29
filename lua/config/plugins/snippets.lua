return {
	{
		{
			"SirVer/ultisnips",
			dependencies = {
				"yuzhegan/vim-snippets",
				-- branch = "master", -- 指定分支为 master

			},
			config = function()
				vim.opt.rtp:append({ vim.fn.stdpath("data") .. "~/.local/share/nvim/lazy/vim-snippets" })
				-- vim.g.UltiSnipsExpandTrigger = "<c-o>"
				vim.g.UltiSnipsJumpForwardTrigger = "<c-n>"
				vim.g.UltiSnipsJumpBackwardTrigger = "<c-i>"
				-- vim.g.UltiSnipsListSnippets = "<Plug>(utlisnips_list_snippets)"
				-- vim.g.UltiSnipsRemoveSelectModeMappings = 0
				vim.g.UltiSnipsListSnippets = "<c-x><c-x>"
				vim.g.UltiSnipsRemoveSelectModeMappings = 0
			end,
		},
	}



	-- return {
	-- 	{
	-- 		"SirVer/ultisnips",
	-- 		dependencies = {
	-- 			"honza/vim-snippets",
	-- 		},
	-- 		config = function()
	-- 			vim.g.UltiSnipsSnippetDirectories = { "~/.config/nvim/Ultisnips" }
	-- 			-- vim.g.UltiSnipsExpandTrigger = ""
	-- 			-- vim.g.UltiSnipsJumpForwardTrigger = ""
	-- 			-- vim.g.UltiSnipsJumpBackwardTrigger = ""
	-- 		end
	-- 	},
	-- {
	-- 	"L3MON4D3/LuaSnip",
	-- 	version = "1.*",
	-- 	build = "make install_jsregexp",
	-- 	config = function()
	-- 		require("luasnip.loaders.from_vscode").load({
	-- 			paths = {
	-- 				"./luasnip_snippets"
	-- 			}
	-- 		})
	-- 		local ls = require('luasnip')
	-- 		ls.config.setup({})
	-- 		vim.keymap.set("i", "<C-e>", ls.expand_or_jump, { silent = true })
	-- 		vim.keymap.set("s", "<C-e>", function() ls.jump(1) end, { silent = true })
	-- 		vim.keymap.set("s", "<C-n>", function() ls.jump(-1) end, { silent = true })
	--
	-- 		ls.filetype_extend("dart", { "flutter" })
	--
	-- 		-- Bullet Journal styled dates in the future
	-- 		local snip = ls.snippet
	-- 		local node = ls.snippet_node
	-- 		local text = ls.text_node
	-- 		local insert = ls.insert_node
	-- 		local func = ls.function_node
	-- 		local choice = ls.choice_node
	-- 		local dynamicn = ls.dynamic_node
	--
	-- 		local date = function() return { os.date('%Y-%m-%d') } end
	-- 		local time = function() return { os.date('%H:%M') } end
	-- 		local datetime = function() return { os.date('%Y-%m-%d %H:%M') } end
	--
	-- 		ls.add_snippets(nil, {
	-- 			all = {
	-- 				snip({
	-- 					trig = "date",
	-- 					namr = "Date",
	-- 					dscr = "Date in the form of YYYY-MM-DD",
	-- 				}, { func(date, {}), }),
	-- 			},
	-- 		})
	-- 		ls.add_snippets(nil, {
	-- 			all = {
	-- 				snip({
	-- 					trig = "time",
	-- 					namr = "Time",
	-- 					dscr = "Time in the form of HH:MM",
	-- 				}, { func(time, {}), }),
	-- 			},
	-- 		})
	-- 		ls.add_snippets(nil, {
	-- 			all = {
	-- 				snip({
	-- 					trig = "datetime",
	-- 					namr = "Date and Time",
	-- 					dscr = "Date and Time in the form of YYYY-MM-DD HH:MM",
	-- 				}, { func(datetime, {}), }),
	-- 			},
	-- 		})
	-- 	end
	-- }
}
