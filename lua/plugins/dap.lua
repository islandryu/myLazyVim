local function make_repeatable(action)
  return function()
    _G.dap_repeat = _G.dap_repeat or {}
    _G.dap_repeat.repeat_action = function()
      action()
      if vim.fn.exists("*repeat#set") == 1 then
        local repeat_action =
          vim.api.nvim_replace_termcodes(string.format("<cmd>call %s()<cr>", vim.go.operatorfunc), true, true, true)
        vim.fn["repeat#set"](repeat_action, -1)
      end
    end

    vim.go.operatorfunc = "v:lua.dap_repeat.repeat_action"
    vim.cmd("normal! g@l")
  end
end

return {
  { import = "lazyvim.plugins.extras.dap.core" },
  { "tpope/vim-repeat", event = "VeryLazy" },
  {
    "mfussenegger/nvim-dap",
    init = function()
      vim.keymap.set(
        "n",
        "<Plug>(dap-step-into)",
        make_repeatable(function()
          require("dap").step_into()
        end),
        { desc = "DAP Step Into" }
      )
      vim.keymap.set(
        "n",
        "<Plug>(dap-step-out)",
        make_repeatable(function()
          require("dap").step_out()
        end),
        { desc = "DAP Step Out" }
      )
      vim.keymap.set(
        "n",
        "<Plug>(dap-step-over)",
        make_repeatable(function()
          require("dap").step_over()
        end),
        { desc = "DAP Step Over" }
      )
    end,
    keys = {
      {
        "<leader>di",
        "<Plug>(dap-step-into)",
        remap = true,
        desc = "Step Into",
      },
      {
        "<leader>do",
        "<Plug>(dap-step-out)",
        remap = true,
        desc = "Step Out",
      },
      {
        "<leader>dO",
        "<Plug>(dap-step-over)",
        remap = true,
        desc = "Step Over",
      },
    },
    opts = function()
      local dap = require("dap")
      local lldb_dap = vim.fn.exepath("lldb-dap")
      if lldb_dap == "" then
        local path = vim.fn.system({ "xcrun", "--find", "lldb-dap" })
        if vim.v.shell_error == 0 then
          lldb_dap = vim.trim(path)
        end
      end

      dap.adapters.lldb = {
        type = "executable",
        command = lldb_dap,
        name = "lldb",
      }

      local function workspace()
        return vim.loop.cwd()
      end

      local jsc_config = {}

      for _, language in ipairs({ "cpp", "c", "objc", "javascript", "typescript" }) do
        dap.configurations[language] = jsc_config
      end
    end,
  },
}
