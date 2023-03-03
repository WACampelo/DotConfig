local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
  return
end

mason.setup()

mason_lspconfig.setup({
  ensure_installed = {
    "angularls",
    "bashls",
    "cmake",
    "cssls",
    "cssmodules_ls",
    "html",
    "jsonls",
    "quick_lint_js",
    "tsserver",
    "vtsls",
    "lua_ls",
    "jedi_language_server",
    "pyre",
    "pyright",
    "sourcery",
    "pylsp",
    "rust_analyzer",
    "sqlls",
    "tailwindcss",
    "emmet_ls",
  },
  -- auto-install
  automatic_installation = true,
})

mason_null_ls.setup({
  ensure_installed = {
    "prettier",
    "stylua",
    "eslint_d",
  },
  -- auto-install 
  automatic_installation = true,
})
