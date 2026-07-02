-- lua/plugins/debug/dap.lua
-- Small addition on top of the `dap.core` extra: automatically open the
-- debug UI when a session starts, and close it when it ends. Everything
-- else (adapters, breakpoints, keymaps) comes from the extras — see
-- README.md in this folder.

local function find_project_script()
  local pyproject = vim.fs.find("pyproject.toml", { upward = true, path = vim.fn.getcwd() })[1]
  if not pyproject then
    return nil
  end
  local in_scripts_section = false
  for line in io.lines(pyproject) do
    if line:match("^%[project%.scripts%]") then
      in_scripts_section = true
    elseif line:match("^%[") then
      in_scripts_section = false
    elseif in_scripts_section then
      local name = line:match("^([%w_%-]+)%s*=")
      if name then
        return name
      end
    end
  end
  return nil
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
  },
  keys = {
    {
      "<leader>dv",
      function()
        require("dapui").float_element("scopes", { width = 100, height = 40, enter = true })
      end,
      desc = "Float variables (Scopes)",
    },
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
    local project_config = { }
    local script = find_project_script()
    if script then
            table.insert(project_config, {
        type = "python",
        request = "launch",
        name = "Debug project (" .. script .. ")",
        program = "${workspaceFolder}/.venv/bin/" .. script,
        args = function()
          return vim.split(vim.fn.input("Args (e.g. dev): "), " ")
        end,
        console = "integratedTerminal",
      })
    end

    dap.configurations.python = vim.list_extend({
      {
        type = "python",
        request = "launch",
        name = "Launch current file",
        program = "${file}",
        console = "integratedTerminal",
      },
      {
        type = "python",
        request = "launch",
        name = "Launch current file (with args)",
        program = "${file}",
        args = function()
          return vim.split(vim.fn.input("Args: "), " ")
        end,
        console = "integratedTerminal",
      },
      {
        type = "python",
        request = "launch",
        name = "Launch project (main.py)",
        program = "${workspaceFolder}/main.py",
        console = "integratedTerminal",
      },
      {
        type = "python",
        request = "launch",
        name = "Run pytest on current file",
        module = "pytest",
        args = { "${file}", "-v" },
        console = "integratedTerminal",
      },
    }, project_config)
  end,
}
