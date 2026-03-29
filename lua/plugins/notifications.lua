return {
  {
    "snacks.nvim",
    opts = function(_, opts)
      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.notifications = vim.tbl_deep_extend("force", opts.picker.sources.notifications or {}, {
        actions = {
          copy_message = function(picker, item)
            item = item or picker:current()
            if not item then
              return
            end

            local text = item.text or item.message or ""
            vim.fn.setreg("+", text)
            vim.notify("Copied notification")
          end,
        },
        win = {
          input = {
            keys = {
              ["y"] = { "copy_message", mode = { "n", "i" } },
            },
          },
        },
      })
    end,
  },
}
