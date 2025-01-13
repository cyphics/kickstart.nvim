-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
return {
  {
    'ThePrimeagen/vim-be-good',
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
      doing_prefix = 'Current task: ',
      store = {
        auto_create_file = true,
        file_name = '.do_tasks',
      },
    },
  },
  -- {
  --   'Civitasv/cmake-tools.nvim',
  --   -- keys = { 'n', 'M-m', '<cmd>CMakeRun<cr>' },
  --   config = function()
  --     vim.api.nvim_set_keymap('n', '<M-m>', '<cmd>CMakeRun<cr>', { noremap = true, silent = true })
  --     local osys = require 'cmake-tools.osys'
  --     require('cmake-tools').setup {
  --       cmake_command = 'cmake', -- this is used to specify cmake command path
  --       ctest_command = 'ctest', -- this is used to specify ctest command path
  --       cmake_use_preset = true,
  --       cmake_regenerate_on_save = false, -- auto generate when save CMakeLists.txt
  --       cmake_generate_options = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=1' }, -- this will be passed when invoke `CMakeGenerate`
  --       cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
  --       -- support macro expansion:
  --       --       ${kit}
  --       --       ${kitGenerator}
  --       --       ${variant:xx}
  --       cmake_build_directory = function()
  --         if osys.iswin32 then
  --           return 'out\\${variant:buildType}'
  --         end
  --         return 'out/${variant:buildType}'
  --       end, -- this is used to specify generate directory for cmake, allows macro expansion, can be a string or a function returning the string, relative to cwd.
  --       cmake_soft_link_compile_commands = true, -- this will automatically make a soft link from compile commands file to project root dir
  --       cmake_compile_commands_from_lsp = false, -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
  --       cmake_kits_path = nil, -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
  --       cmake_variants_message = {
  --         short = { show = true }, -- whether to show short message
  --         long = { show = true, max_length = 40 }, -- whether to show long message
  --       },
  --       cmake_dap_configuration = { -- debug settings for cmake
  --         name = 'cpp',
  --         type = 'codelldb',
  --         request = 'launch',
  --         stopOnEntry = false,
  --         runInTerminal = true,
  --         console = 'integratedTerminal',
  --       },
  --       cmake_executor = { -- executor to use
  --         name = 'quickfix', -- name of the executor
  --         opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
  --         default_opts = { -- a list of default and possible values for executors
  --           quickfix = {
  --             show = 'always', -- "always", "only_on_error"
  --             position = 'belowright', -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
  --             size = 10,
  --             encoding = 'utf-8', -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
  --             auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
  --           },
  --           toggleterm = {
  --             direction = 'float', -- 'vertical' | 'horizontal' | 'tab' | 'float'
  --             close_on_exit = false, -- whether close the terminal when exit
  --             auto_scroll = true, -- whether auto scroll to the bottom
  --             singleton = true, -- single instance, autocloses the opened one, if present
  --           },
  --           overseer = {
  --             new_task_opts = {
  --               strategy = {
  --                 'toggleterm',
  --                 direction = 'horizontal',
  --                 autos_croll = true,
  --                 quit_on_exit = 'success',
  --               },
  --             }, -- options to pass into the `overseer.new_task` command
  --             on_new_task = function(task)
  --               require('overseer').open { enter = false, direction = 'right' }
  --             end, -- a function that gets overseer.Task when it is created, before calling `task:start`
  --           },
  --           terminal = {
  --             name = 'Main Terminal',
  --             prefix_name = '[CMakeTools]: ', -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
  --             split_direction = 'horizontal', -- "horizontal", "vertical"
  --             split_size = 11,
  --
  --             -- Window handling
  --             single_terminal_per_instance = true, -- Single viewport, multiple windows
  --             single_terminal_per_tab = true, -- Single viewport per tab
  --             keep_terminal_static_location = true, -- Static location of the viewport if avialable
  --             auto_resize = true, -- Resize the terminal if it already exists
  --
  --             -- Running Tasks
  --             start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
  --             focus = false, -- Focus on terminal when cmake task is launched.
  --             do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
  --           }, -- terminal executor uses the values in cmake_terminal
  --         },
  --       },
  --       cmake_runner = { -- runner to use
  --         name = 'terminal', -- name of the runner
  --         opts = {}, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
  --         default_opts = { -- a list of default and possible values for runners
  --           quickfix = {
  --             show = 'always', -- "always", "only_on_error"
  --             position = 'belowright', -- "bottom", "top"
  --             size = 10,
  --             encoding = 'utf-8',
  --             auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
  --           },
  --           toggleterm = {
  --             direction = 'float', -- 'vertical' | 'horizontal' | 'tab' | 'float'
  --             close_on_exit = false, -- whether close the terminal when exit
  --             auto_scroll = true, -- whether auto scroll to the bottom
  --             singleton = true, -- single instance, autocloses the opened one, if present
  --           },
  --           overseer = {
  --             new_task_opts = {
  --               strategy = {
  --                 'toggleterm',
  --                 direction = 'horizontal',
  --                 autos_croll = true,
  --                 quit_on_exit = 'success',
  --               },
  --             }, -- options to pass into the `overseer.new_task` command
  --             on_new_task = function(task) end, -- a function that gets overseer.Task when it is created, before calling `task:start`
  --           },
  --           terminal = {
  --             name = 'Main Terminal',
  --             prefix_name = '[CMakeTools]: ', -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
  --             split_direction = 'horizontal', -- "horizontal", "vertical"
  --             split_size = 11,
  --
  --             -- Window handling
  --             single_terminal_per_instance = true, -- Single viewport, multiple windows
  --             single_terminal_per_tab = true, -- Single viewport per tab
  --             keep_terminal_static_location = true, -- Static location of the viewport if avialable
  --             auto_resize = true, -- Resize the terminal if it already exists
  --
  --             -- Running Tasks
  --             start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
  --             focus = false, -- Focus on terminal when cmake task is launched.
  --             do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
  --           },
  --         },
  --       },
  --       cmake_notifications = {
  --         runner = { enabled = true },
  --         executor = { enabled = true },
  --         spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }, -- icons used for progress display
  --         refresh_rate_ms = 100, -- how often to iterate icons
  --       },
  --       cmake_virtual_text_support = true, -- Show the target related to current file using virtual text (at right corner)
  --     }
  --   end,
  -- },
  { -- This plugin
    'Zeioth/compiler.nvim',
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    dependencies = { 'stevearc/overseer.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {},
    --keys = { { '<M-m>', '<cmd>CompilerOpen<cr>', desc = 'Open compiler' } },
    config = function()
      vim.api.nvim_set_keymap('n', '<M-m>', '<cmd>CompilerOpen<cr>', { noremap = true, silent = true })
    end,
  },
  { -- The task runner we use
    'stevearc/overseer.nvim',
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    opts = {
      task_list = {
        direction = 'bottom',
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
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
