local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "ubd.lsp.lsp-installer"
require("ubd.lsp.handlers").setup()
require "ubd.lsp.null-ls"
