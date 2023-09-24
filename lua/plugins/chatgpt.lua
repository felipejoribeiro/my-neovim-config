return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  },
  config = function()
    require("chatgpt").setup({
      question_sign = "👀",
      answer_sign = "🤖",
      popup_input = {
        submit = "<C-s>",
      },
    })
  end,
}
