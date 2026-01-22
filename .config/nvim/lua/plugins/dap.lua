return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go",
		{
			"mxsdev/nvim-dap-vscode-js",
			dependencies = {
				{
					"microsoft/vscode-js-debug",
					build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
				},
			},
		},
	},
	keys = {
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
		{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
		{ "<leader>dc", function() require("dap").continue() end, desc = "Continue/Start" },
		{ "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
		{ "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
		{ "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
		{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
		{ "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
		{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- DAP UI setup
		dapui.setup()

		-- Virtual text setup
		require("nvim-dap-virtual-text").setup()

		-- Auto open/close DAP UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Go (delve)
		require("dap-go").setup()

		-- TypeScript/JavaScript
		require("dap-vscode-js").setup({
			debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		})

		for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to process",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch Chrome",
					url = "http://localhost:3000",
					webRoot = "${workspaceFolder}",
				},
			}
		end

		-- Rust (codelldb via Mason)
		local mason_registry = require("mason-registry")
		local codelldb_path = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/adapter/codelldb"
		local liblldb_path = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/lldb/lib/liblldb.dylib"

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = codelldb_path,
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.rust = {
			{
				name = "Launch",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		-- Signs
		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })
	end,
}
