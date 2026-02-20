require("settings.constants")
-- Keeping keymaps at the top so I can override
-- default keymaps with plugin specific ones
-- defined inside plugin specs.
require("lazy-plugins")
require("settings.general")
require("settings.keymaps")
require("settings.lsp")
require("settings.winbar")
