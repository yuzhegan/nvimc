return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "vimwiki", "html" },
    build = "cd app && yarn install",
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_filetypes = { 'markdown', 'vimwiki', 'html' }
      vim.g.mkdp_theme = 'dark'

      -- 添加浏览器设置
      vim.cmd([[
        function! OpenMarkdownPreview(url)
          execute "silent ! edge --new-window " . a:url
        endfunction
        let g:mkdp_browserfunc = 'OpenMarkdownPreview'
      ]])
    end,
  },
}

