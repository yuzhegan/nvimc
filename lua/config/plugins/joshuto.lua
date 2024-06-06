-- return {
-- 	"theniceboy/joshuto.nvim",
-- 	lazy = true,
-- 	cmd = "Joshuto",
-- 	config = function()
-- 		-- let g:joshuto_floating_window_winblend = 0
-- 		-- let g:joshuto_floating_window_scaling_factor = 1.0
-- 		-- let g:joshuto_use_neovim_remote = 1 " for neovim-remote support
-- 		vim.g.joshuto_floating_window_scaling_factor = 1.0
-- 		vim.g.joshuto_use_neovim_remote = 1
-- 		vim.g.joshuto_floating_window_winblend = 0
-- 	end
-- }
return {
	{
		"DreamMaoMao/yazi.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},

		-- keys = {
		--   { "<leader>gy", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
		-- },
	}

}
