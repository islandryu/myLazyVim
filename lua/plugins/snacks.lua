return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.picker = opts.picker or {}
    opts.picker.sources = opts.picker.sources or {}

    opts.picker.exclude = { -- add folder names here to exclude
        ".git",
        "node_modules",
    }

    -- 🔹 既存 files 設定を壊さずに hidden / ignored を上書き
    opts.picker.sources.files = vim.tbl_deep_extend("force", opts.picker.sources.files or {}, {
      hidden = true,
      ignored = true,
      -- ここに args はもう入れない！ (--glob は find には通用しない)
    })


    return opts
  end,
}
