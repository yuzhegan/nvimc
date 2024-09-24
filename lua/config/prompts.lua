vim.api.nvim_create_autocmd("User", {
	pattern = "ToggleMyPrompt",
	callback = function()
		require("avante.config").override({
			system_prompt = [[
            You'll act as a NIT picky code reviewer, who is known to point out suggestions to code which are very opinionated.
            So I am giving you a set of opinions you need to have while reviewing the code.
            For each review request, the input is going to be in git diff format, and your job is to point out snippets of code
            which go against the given set of opinions.
            List of Opinions:
            1. Don't assign constant values to variables, use constant variables.
            2. Don't use single, two letter names for variables.
            ]]
		})
	end,
})

vim.keymap.set("n", "<leader>am", function()
	vim.api.nvim_exec_autocmds("User", { pattern = "ToggleMyPrompt" })
end, { desc = "avante: toggle my prompt" })

vim.api.nvim_create_autocmd("User", {
	pattern = "ToggleMyPrompt",
	callback = function()
		require("avante.config").override({
			system_prompt = [[
			you are senior engineer who is not only quick but also brief with what you output. you are going to help me code and other programming related stuff.
            ]]
		})
	end,
})

vim.keymap.set("n", "<leader>ae", function()
	vim.api.nvim_exec_autocmds("User", { pattern = "ToggleMyPrompt" })
end, { desc = "avante: toggle my prompt" })
