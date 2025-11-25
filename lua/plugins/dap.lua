return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "jay-babu/mason-nvim-dap.nvim",
      "nvim-neotest/nvim-nio", -- ← これを追加！
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- macOS の LLDB アダプタ
      dap.adapters.lldb = {
        type = "executable",
        command = "/Applications/Xcode.app/Contents/Developer/usr/bin/lldb-dap",
        name = "lldb",
      }


      local cwd = vim.fn.getcwd()
      local launch_path = cwd .. "/.vscode/launch.json"

      print("[DAP] Loading launch.json from: " .. launch_path)

      require("dap.ext.vscode").load(launch_path, {
        lldb = { "c", "cpp", "rust" },
      })
    end,
  },
}
