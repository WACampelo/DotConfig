local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	-- packer itself
	use("wbthomason/packer.nvim")

	-- common lua functions
	use("nvim-lua/plenary.nvim")

	-- colorscheme
	use("bluz71/vim-nightfly-guicolors")

	-- window navigation
	use("szw/vim-maximizer") -- <leader>wm
	use("christoomey/vim-tmux-navigator") -- <C-hjkl> move around on windows

	-- edition plugins
	use("vim-scripts/ReplaceWithRegister")
	use("tpope/vim-surround") -- ys<motion><char-to-surround> - ds<surround-char> - cs<cur-char><new-char>
	use("numToStr/Comment.nvim") -- gc<number><motion>

	-- file explorer
	use("nvim-tree/nvim-tree.lua")
	use("kyazdani42/nvim-web-devicons")

	-- statusbar
	use("nvim-lualine/lualine.nvim")

	-- telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

	-- autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- LSP server
	use("williamboman/mason.nvim") -- server install
	use("williamboman/mason-lspconfig.nvim") -- bridge between mason and lspconfig
	use("neovim/nvim-lspconfig") -- server config

	use("hrsh7th/cmp-nvim-lsp")
	use({ "glepnir/lspsaga.nvim", branch = "main" })
	use("jose-elias-alvarez/typescript.nvim")
	use("onsails/lspkind.nvim")

	-- linting & formating
	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	-- git integration
	use("lewis6991/gitsigns.nvim")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
