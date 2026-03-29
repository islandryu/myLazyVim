return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.explorer = vim.tbl_deep_extend("force", opts.picker.sources.explorer or {}, {
        hidden = true,
        ignored = true,
      })

      return opts
    end,
    config = function(_, opts)
      require("snacks").setup(opts)

      local original_notify = vim.notify

      vim.notify = function(msg, level, notify_opts)
        notify_opts = notify_opts or {}

        notify_opts.timeout = 20000

        return original_notify(msg, level, notify_opts)
      end
    end,
  },
}
