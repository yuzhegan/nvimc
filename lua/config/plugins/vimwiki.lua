return {
	'vimwiki/vimwiki',
	init = function()
		vim.g.vimwiki_list = {
			{ path = '/mnt/e/notes/',   syntax = 'markdown', ext = '.md' },
			{ path = '/mnt/e/vimwiki/', syntax = 'markdown', ext = '.md' },
			{ path = '~/notes/',   syntax = 'markdown', ext = '.md' },
			{ path = '~/vimwiki/', syntax = 'markdown', ext = '.md' },
		}

		vim.g.vimwiki_hl_headers = 1
		vim.g.vimwiki_hl_cb_checked = 2
		vim.g.vimwiki_listsyms = ' ○◐●✓'
		vim.g.vimwiki_listsym_rejected = '✗'
	end,
	config = function() end,
	ft = { 'markdown', 'wiki', 'vimwiki' },
}
