-- return {
-- 	"lilydjwg/fcitx.vim",
-- 	event = "InsertEnter",
-- }
return {
	-- 配置为 Lua 模块返回一个表格
	"Leiyi548/vim-im-select",
	event = "InsertEnter",
	setup = function()
		-- 设置 ttimeoutlen 为 0
		vim.o.ttimeoutlen = 0

		-- 检查是否在 WSL 环境下运行
		local is_wsl = vim.fn.system('uname -r'):match('microsoft')

		if is_wsl then
			-- 定义 im-select 的路径和默认状态
			local im_path = "im-select.exe"
			local im_status = "1033" -- 默认输入法为英文

			-- 离开插入模式时切换输入法到英文
			local function Im_ILeave()
				-- 获取当前输入法状态，并去除换行符
				im_status = vim.fn.systemlist(im_path)[1] or "1033"
				-- 切换到英文输入法
				vim.fn.system(im_path .. " 1033")
			end

			-- 进入插入模式时恢复原输入法状态
			local function Im_IEnter()
				-- 恢复之前保存的输入法状态
				vim.fn.system(im_path .. " " .. im_status)
			end

			-- 注册自动命令
			vim.api.nvim_create_autocmd("InsertLeave", {
				pattern = "*",
				callback = Im_ILeave,
			})

			vim.api.nvim_create_autocmd("InsertEnter", {
				pattern = "*",
				callback = Im_IEnter,
			})

			-- 启动时将输入法切换为英文
			vim.api.nvim_create_autocmd("VimEnter", {
				pattern = "*",
				callback = function()
					vim.fn.system(im_path .. " 1033")
				end,
			})
		end
	end
}
