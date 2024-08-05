local compile = function()
	vim.cmd("write")
	local filetype = vim.bo.filetype
	if filetype == "cpp" or filetype == "c" then
		os.execute("gcc " .. vim.fn.expand("%") .. " -g -o " .. vim.fn.expand("%<"))
	end
end
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"ravenxrz/DAPInstall.nvim",
				config = function()
					local dap_install = require("dap-install")
					dap_install.setup({
						installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
					})
				end
			},
			"theHamsta/nvim-dap-virtual-text",
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"nvim-neotest/nvim-nio",
				},
			},
			"nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()
			require("nvim-dap-virtual-text").setup()

			-- dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			-- dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			-- dap.listeners.before.event_exited["dapui_config"] = dapui.close

			local m = { noremap = true }
			vim.keymap.set("n", "<leader>'t", dap.toggle_breakpoint, m)
			vim.keymap.set("n", "<leader>'v", require('dap.ui.widgets').hover, m)
			vim.keymap.set("n", "<leader>'n", function()
				compile()
				dap.continue()
			end, m)
			vim.keymap.set("n", "<leader>'s", dap.step_over, m)
			local widgets = require('dap.ui.widgets')
			vim.keymap.set("n", "<leader>'q", dap.terminate, m)
			vim.keymap.set("n", "<leader>'u", dapui.toggle, m)

			vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
			vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
			vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#ffffff', bg = '#FE3C25' })

			vim.fn.sign_define('DapBreakpoint',
				{ text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
			vim.fn.sign_define('DapBreakpointCondition',
				{ text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
			vim.fn.sign_define('DapBreakpointRejected',
				{ text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
			vim.fn.sign_define('DapLogPoint', {
				text = '',
				texthl = 'DapLogPoint',
				linehl = 'DapLogPoint',
				numhl = 'DapLogPoint'
			})
			vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

			dap.adapters.codelldb = {
				type = 'server',
				port = "${port}",
				executable = {
					command = vim.g.codelldb_path,
					args = { "--port", "${port}" },
				}
			}
			dap.adapters.python = {
				type = 'executable',
				command = 'python',
				args = { '-m', 'debugpy.adapter' },
			}
			dap.configurations.python = {
				{
					type = 'python',
					request = 'launch',
					name = 'Launch file',
					program = '${file}',
				},
			}
			dap.adapters.cpp = {
				type = 'executable',
				name = 'cppdbg',
				command = 'lldb-vscode',
				args = {},
				attach = {
					pidProperty = 'processId',
					pidSelect = 'ask',
				},
			}
			--typescript
			dap.configurations.typescript = {
				{
					type = "node2",
					name = "node attach",
					request = "attach",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
				},
				{
					type = "chrome",
					name = "Debug with Chrome",
					request = "attach",
					program = "${file}",
					-- cwd = "${workspaceFolder}",
					-- protocol = "inspector",
					port = 9222,
					webRoot = "${workspaceFolder}",
					-- sourceMaps = true,
					sourceMapPathOverrides = {
						-- Sourcemap override for nextjs
						["webpack://_N_E/./*"] = "${webRoot}/*",
						["webpack:///./*"] = "${webRoot}/*",
					},
				},
				{
					name = "Debug with Firefox",
					type = "firefox",
					request = "launch",
					reAttach = true,
					sourceMaps = true,
					url = "http://localhost:6969",
					webRoot = "${workspaceFolder}",
					firefoxExecutable = firefoxExecutable,
				},
				{
					name = "Launch",
					type = "pwa-node",
					request = "launch",
					program = "${file}",
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
					protocol = "inspector",
					console = "integratedTerminal",
				},
				{
					name = "Attach to node process",
					type = "pwa-node",
					request = "attach",
					rootPath = "${workspaceFolder}",
					processId = require("dap.utils").pick_process,
				},
				{
					name = "Debug Main Process (Electron)",
					type = "pwa-node",
					request = "launch",
					program = "${workspaceFolder}/node_modules/.bin/electron",
					args = {
						"${workspaceFolder}/dist/index.js",
					},
					outFiles = {
						"${workspaceFolder}/dist/*.js",
					},
					resolveSourceMapLocations = {
						"${workspaceFolder}/dist/**/*.js",
						"${workspaceFolder}/dist/*.js",
					},
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
					protocol = "inspector",
					console = "integratedTerminal",
				},
				{
					name = "Compile & Debug Main Process (Electron)",
					type = custom_adapter,
					request = "launch",
					preLaunchTask = "npm run build-ts",
					program = "${workspaceFolder}/node_modules/.bin/electron",
					args = {
						"${workspaceFolder}/dist/index.js",
					},
					outFiles = {
						"${workspaceFolder}/dist/*.js",
					},
					resolveSourceMapLocations = {
						"${workspaceFolder}/dist/**/*.js",
						"${workspaceFolder}/dist/*.js",
					},
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
					protocol = "inspector",
					console = "integratedTerminal",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Debug Jest Tests",
					-- trace = true, -- include debugger info
					runtimeExecutable = "node",
					runtimeArgs = {
						"./node_modules/jest/bin/jest.js",
						"--runInBand",
					},
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
				},
			}

			dap.configurations.typescriptreact = dap.configurations.typescript
			dap.configurations.javascript = dap.configurations.typescript
			dap.configurations.javascriptreact = dap.configurations.typescript
			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						local exe = vim.g.c_debug_program or vim.fn.expand("%:r")
						return vim.fn.getcwd() .. '/' .. exe
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
				},
			}
			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp

			local dap_install = require("dap-install")
			dap_install.config("codelldb", {})
		end
	}
}
