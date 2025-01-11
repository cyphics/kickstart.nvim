-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
return {
  {
    'tpope/vim-fugitive',
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<C-a>', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '<C-1>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<C-2>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<C-3>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<C-4>', function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-S-P>', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<C-S-N>', function()
        harpoon:list():next()
      end)
    end,
  },
  {
    'nocksock/do.nvim',
    opts = {
      winbar = true,
      kaomoji_mode = 1,
      store = {
        auto_create_file = true,
        file_name = '.do_tasks',
      },
    },
  },

  -- { -- This plugin
  -- 	"Zeioth/compiler.nvim",
  -- 	cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
  -- 	dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
  -- 	opts = {},
  -- 	keys = { { "<M-m>", "<cmd>CompilerOpen<cr>", desc = "Open compiler" } },
  -- 	-- config = function()
  -- 	-- 	vim.api.nvim_set_keymap("n", "<M-m>", "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })
  -- 	-- end,
  -- },
  { -- The task runner we use
    'stevearc/overseer.nvim',
    -- cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      -- task_list = {
      -- 	direction = "bottom",
      -- 	min_height = 25,
      -- 	max_height = 25,
      -- 	default_detail = 1,
      -- },
    },
  },
  -- {
  -- 	"mfussenegger/nvim-dap",
  -- 	config = function()
  -- 		local dap = require("dap")
  -- 		dap.adapters.gdb = {
  -- 			type = "executable",
  -- 			command = "gdb",
  -- 			args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
  -- 		}
  -- 		dap.configurations.cpp = {
  -- 			{
  -- 				name = "Launch",
  -- 				type = "gdb",
  -- 				request = "launch",
  -- 				program = function()
  -- 					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  -- 				end,
  -- 				cwd = "${workspaceFolder}",
  -- 				stopAtBeginningOfMainSubprogram = false,
  -- 			},
  -- 			{
  -- 				name = "Select and attach to process",
  -- 				type = "gdb",
  -- 				request = "attach",
  -- 				program = function()
  -- 					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  -- 				end,
  -- 				pid = function()
  -- 					local name = vim.fn.input("Executable name (filter): ")
  -- 					return require("dap.utils").pick_process({ filter = name })
  -- 				end,
  -- 				cwd = "${workspaceFolder}",
  -- 			},
  -- 			{
  -- 				name = "Attach to gdbserver :1234",
  -- 				type = "gdb",
  -- 				request = "attach",
  -- 				target = "localhost:1234",
  -- 				program = function()
  -- 					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  -- 				end,
  -- 				cwd = "${workspaceFolder}",
  -- 			},
  -- 		}
  -- 		-- dap.configurations.cpp = {
  -- 		-- 	{
  -- 		-- 		type = "gdb",
  -- 		-- 		request = "launch",
  -- 		-- 		name = "Launch file",
  -- 		-- 		program = "${file}",
  -- 		-- 	},
  -- 		-- }
  -- 		vim.keymap.set("n", "<F5>", function()
  -- 			require("dap").continue()
  -- 		end)
  -- 		vim.keymap.set("n", "<F10>", function()
  -- 			require("dap").step_over()
  -- 		end)
  -- 		vim.keymap.set("n", "<F11>", function()
  -- 			require("dap").step_into()
  -- 		end)
  -- 		vim.keymap.set("n", "<F12>", function()
  -- 			require("dap").step_out()
  -- 		end)
  -- 		vim.keymap.set("n", "<Leader>b", function()
  -- 			require("dap").toggle_breakpoint()
  -- 		end)
  -- 		vim.keymap.set("n", "<Leader>B", function()
  -- 			require("dap").set_breakpoint()
  -- 		end)
  -- 		vim.keymap.set("n", "<Leader>lp", function()
  -- 			require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
  -- 		end)
  -- 		vim.keymap.set("n", "<Leader>dr", function()
  -- 			require("dap").repl.open()
  -- 		end)
  -- 		vim.keymap.set("n", "<Leader>dl", function()
  -- 			require("dap").run_last()
  -- 		end)
  -- 		vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
  -- 			require("dap.ui.widgets").hover()
  -- 		end)
  -- 		vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
  -- 			require("dap.ui.widgets").preview()
  -- 		end)
  -- 		vim.keymap.set("n", "<Leader>df", function()
  -- 			local widgets = require("dap.ui.widgets")
  -- 			widgets.centered_float(widgets.frames)
  -- 		end)
  -- 		vim.keymap.set("n", "<Leader>ds", function()
  -- 			local widgets = require("dap.ui.widgets")
  -- 			widgets.centered_float(widgets.scopes)
  -- 		end)
  -- 	end,
  -- },
  -- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
}
