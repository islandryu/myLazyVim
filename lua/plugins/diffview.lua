return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>gd", false },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git Diff View" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Git Diff Close" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_horizontal",
          winbar_info = true,
        },
        file_history = {
          layout = "diff2_horizontal",
          winbar_info = true,
        },
      },
      file_panel = {
        listing_style = "tree",
        win_config = {
          position = "left",
          width = 42,
        },
      },
    },
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    keys = {
      {
        "<leader>gg",
        function()
          require("neogit").open({ kind = "split" })
        end,
        desc = "Git UI",
      },
      {
        "<leader>gG",
        "<cmd>Neogit kind=split cwd=%:p:h<cr>",
        desc = "Git UI (Current File Repo)",
      },
    },
    opts = {
      kind = "split",
      commit_editor = {
        kind = "split",
        staged_diff_split_kind = "vsplit",
      },
      commit_select_view = {
        kind = "split",
      },
      commit_view = {
        kind = "vsplit",
      },
      log_view = {
        kind = "split",
      },
      rebase_editor = {
        kind = "split",
      },
      reflog_view = {
        kind = "split",
      },
      merge_editor = {
        kind = "split",
      },
      preview_buffer = {
        kind = "split",
      },
      popup = {
        kind = "split",
      },
      stash = {
        kind = "split",
      },
      refs_view = {
        kind = "split",
      },
      integrations = {
        diffview = true,
      },
    },
  },
}
