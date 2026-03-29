return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>gd", false },
      { "<leader>gD", false },
    },
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>gd",
        function()
          require("neogit").open({ kind = "split" })
        end,
        desc = "Git UI",
      },
      {
        "<leader>gD",
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
        diffview = false,
      },
    },
  },
}
