V = vim
DATA_PATH = V.fn.stdpath('data')
CACHE_PATH = V.fn.stdpath('cache')
CONFIG_PATH = V.fn.stdpath('config')
VSCODE = V.api.nvim_eval('exists("g:vscode")')
-- Pick between lsp or CoC
-- CoC o LSP
COC = true

-- Needed in order to enable CoC or LSP
HAS_NODE = true
