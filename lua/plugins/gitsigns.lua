return {
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      {
        "<leader>hp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview Hunk",
      },
      {
        "<leader>hr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset Hunk",
      },
      {
        "<leader>hr",
        function()
          require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        mode = "x",
        desc = "Reset Hunk",
      },
    },
  },
}
