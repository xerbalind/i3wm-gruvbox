local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	vim.notify("alpha not found!!")
	return
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
	[[           _nnnn_                      ]],
	[[          dGGGGMMb     ,"""""""""""""".]],
	[[         @p~qp~~qMb    | Neovim btw! |]],
	[[         M|@||@) M|   _;..............']],
	[[         @,----.JM| -'                 ]],
	[[        JS^\__/  qKL                   ]],
	[[       dZP        qKRb                 ]],
	[[      dZP          qKKb                ]],
	[[     fZP            SMMb               ]],
	[[     HZM            MMMM               ]],
	[[     FqM            MMMM               ]],
	[[   __| ".        |\dS"qML              ]],
	[[   |    `.       | `' \Zq              ]],
	[[  _)      \.___.,|     .'              ]],
	[[  \____   )MMMMMM|   .'                ]],
	[[       `-'       `--' hjm              ]],
}

alpha.setup(dashboard.config)
