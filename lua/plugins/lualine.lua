return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- 現在行でのカーソル位置（文字数）を返すカスタム関数
    local function cursor_chars()
      -- カーソルの column 番号（バイトではなく表示上の列）
      local col = vim.fn.col(".")
      return "chars:" .. col
    end

    -- 既存 sections に追加
    opts.sections.lualine_c = opts.sections.lualine_c or {}
    table.insert(opts.sections.lualine_c, cursor_chars)
  end,
}
