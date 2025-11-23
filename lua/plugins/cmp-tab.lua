-- ~/.config/nvim/lua/plugins/cmp-tab.lua
return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")

    -- 既存の mapping に上書きマージする
    opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
      -- 補完メニューが見えているときだけ Tab / S-Tab で移動
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback() -- 何もなければ普通に Tab 挿入
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" }),

      -- Enter で確定
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    })
  end,
}
