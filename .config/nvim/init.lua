-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable spell check by default
vim.opt.spell = true

-- Set the language for spell checking (e.g., "en_us")
vim.opt.spelllang = { "en_us" }

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true
vim.opt.smartindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 2000

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- tab for 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

--Consealer
vim.opt.conceallevel = 0
vim.opt.concealcursor = "nc"

-- added by tkdhss111 and set vim.g.NERDTreeChDirMode = 1
vim.opt.autochdir = true

-- Disable swap file system added by tkdhss111
vim.opt.swapfile = false

-- added by tkdhss111
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = "utf-8,sjis"

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- added by tkdhss111 to suppress checkhealth warnings
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-c>", ":NERDTreeFind<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<F4>", ":Make<CR>", { noremap = true, silent = true })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<S-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<S-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<S-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<S-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Move line up and down with alt + j and k [DEPRECATED in favor to mini.move]
--vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
--vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
--vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
--vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
--vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv==gv", { desc = "Move line down" })
--vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv==gv", { desc = "Move line up" })

-- Change yanked strings to a word under the cursol
vim.keymap.set("n", "ciy", "ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>", { desc = "Change inner yank" })
vim.keymap.set("n", "<C-p>", "ciw<C-r>0<ESC>", { desc = "Change yank" })
vim.keymap.set("n", "cy", "Vp<CR>", { desc = "Relapce line with yanked line" })

-- Insert mode actions
vim.keymap.set("i", "<C-h>", "<BS>", { desc = "Backspace" })
vim.keymap.set("i", "<C-l>", "<Del>", { desc = "Delete" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Up" })

-- tkdhss111 added
vim.keymap.set("n", "<C-h>", "0", { desc = "Move to head" })
vim.keymap.set("n", "<C-l>", "$", { desc = "Move to tail" })
vim.keymap.set("n", "<C-j>", "<C-f>", { desc = "Page down" })
vim.keymap.set("n", "<C-k>", "<C-b>", { desc = "Page up" })
vim.keymap.set("n", "<C-c>", ":cd %:p:h<CR>:pwd<CR>", { desc = "Page up" })

vim.keymap.set("v", "<C-h>", "0", { desc = "Move to head" })
vim.keymap.set("v", "<C-l>", "$", { desc = "Move to tail" })

vim.keymap.set("n", "<Space>", "i", { desc = "Change to insert mode" })

vim.keymap.set("n", "<F12>", ":sp<CR>:terminal<CR>", { desc = "Open terminal" })
--vim.keymap.set("t", "<Esc>", "<C-><C-n>", { desc = "Return from terminal", silent = true })

vim.keymap.set(
	"v",
	"<F2>",
	":s/=/<equal>/ge<CR> :'<,'>s/::/=/g<CR> :'<,'>EasyAlign =<CR> :'<,'>s/=/::/g<CR> :'<,'>s/<equal>/=/ge<CR>",
	{ desc = "Fortran ::" }
)

--Automatic open last edited file added by tkdhss111
--vim.cmd([[
--  autocmd VimEnter * if argc() == 0 | exe "edit " .. v:oldfiles[1] | endif
--]])
--vim.cmd([[
--  autocmd VimEnter * if argc() == 0 && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
--]])

-- Backup files
-- Double slash to build file name from the complete path to the file with all path separators changed to percent '%' signs

if vim.fn.exists("g:os") == 0 then
	local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
	if is_windows then
		vim.g.os = "Windows"
		vim.opt.backupdir = "bak//"
		vim.g.python3_host_prog = "C:/Python312/python.exe"
	else
		local uname_output = vim.fn.system("uname")
		vim.g.os = string.gsub(uname_output, "\n", "")
		vim.opt.backupdir = vim.fn.expand("/mnt/VIM_BAKUP_FILES//")
	end
end
vim.opt.backup = true

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	{
		"sindrets/diffview.nvim",
	},

	--- Ctags
	{
		"ludovicchabant/vim-gutentags",
		config = function()
			vim.g.gutentags_ctags_executable = "ctags"
			vim.g.gutentags_generate_on_write = 1
			vim.g.gutentags_trace = 0
			vim.g.gutentags_generate_on_missing = 1
			-- Exclude directories like build, .git, node_modules
			vim.g.gutentags_ctags_extra_args = {
				"--exclude=build",
				"--exclude=build/*",
				"--exclude=vim",
				"--exclude=vim/*",
				"--exclude=.git",
				"--exclude=.git/*",
				"--exclude=old",
				"--exclude=old/*",
				"--exclude=archive",
				"--exclude=archive/*",
			}
		end,
	},
	--CSV Viewer
	{
		"hat0uma/csvview.nvim",
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			parser = { comments = { "#", "//" } },
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	},

	--CSV csvlens
	{
		"theKnightsOfRohan/csvlens.nvim",
		dependencies = {
			"akinsho/toggleterm.nvim",
		},
		config = true,
		opts = { --[[ Place your opts here ]]
			direction = "horizontal", -- "float" | "vertical" | "horizontal" |  "tab"
		},
	},
	-- QuickFix
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf", -- Load only when quickfix is opened
		config = function()
			require("bqf").setup({
				auto_enable = true,
				magic_window = true,
				auto_resize_height = true, -- Set to true if you want quickfix to resize automatically
				preview = {
					auto_preview = false,
					border = "rounded", -- Options: 'none', 'single', 'double', 'rounded', 'shadow'
					show_title = true,
					show_scroll_bar = true,
					delay_syntax = 50,
					win_height = 25,
					win_vheight = 25,
					winblend = 22,
					wrap = false,
					buf_label = true,
					should_preview_cb = nil,
				},

				func_map = {
					open = "o",
					openc = "O",
					drop = "gd",
					split = "<C-s>",
					vsplit = "<C-v>",
					tab = "T",
					tabc = "",
					ptogglemode = "z,",
				},

				filter = {
					fzf = {
						action_for = {
							["ctrl-t"] = "tabedit",
							["ctrl-v"] = "vsplit",
							["ctrl-x"] = "split",
							["ctrl-q"] = "signtoggle",
							["ctrl-c"] = "closeall",
						},
						extra_opts = { "--bind", "ctrl-o:toggle-all" },
					},
				},
			})
		end,
	},
	-- Ack
	{
		"wincent/ferret",
		config = function()
			vim.g.FerretExecutable = "rg"
			vim.g.FerretArgs =
				"--hidden --smart-case --no-heading --with-filename --line-number --column --glob='!build/'"
			vim.g.FerretQFCommand = "copen"
		end,
	},

	-- AsyncRun
	{
		"skywind3000/asyncrun.vim",
		config = function()
			vim.g.asyncrun_open = 35
			--vim.g.asyncrun_open = 10
			vim.api.nvim_create_user_command("Make", function(opts)
				vim.cmd("AsyncRun make " .. (opts.args or ""))
			end, { nargs = "*" })
			-- Open QuickFix list when AsyncRun is invoked and close it when success, otherwise keep opening it.
			--vim.cmd([[
			--  augroup AsyncRunQuickFix
			--    autocmd!
			--    autocmd User AsyncRunStart copen
			--    autocmd User AsyncRunStop if !v:shell_error | cclose | endif
			--  augroup END
			--]])
		end,
	},

	-- NeadTree
	{
		"preservim/nerdtree",
		keys = {
			{ "<C-n>", "<cmd>NERDTreeToggle<CR>", desc = "Toggle NERDTree" },
			{ "<C-c>", "<cmd>NERDTreeFind<CR>", desc = "Find file" },
		},
		config = function()
			vim.g.NERDTreeChDirMode = 1
			vim.g.NERDTreeRespectWildcards = 1
			vim.g.NERDTreeIgnore = { "^.git$", "^node_modules$" }
			vim.g.NERDTreeQuitOnOpen = 1
			vim.g.NERDTreeShowBookmarks = 1
			vim.g.NERDTreeDirArrows = 1
			vim.g.NERDTreeWinSize = 40
		end,
	},

	-- R
	{
		"R-nvim/R.nvim",
		-- Only required if you also set defaults.lazy = true
		lazy = false,
		-- R.nvim is still young and we may make some breaking changes from time
		-- to time (but also bug fixes all the time). If configuration stability
		-- is a high priority for you, pin to the latest minor version, but unpin
		-- it and try the latest version before reporting an issue:
		-- version = "~0.1.0"
		config = function()
			-- Function to detect OS and set the PDF viewer accordingly
			local function set_pdf_viewer()
				local os_type = vim.loop.os_uname().sysname

				if os_type == "Darwin" then
					-- macOS
					vim.g.r_pdfviewer = "open -a Preview" -- macOS default Preview app
				elseif os_type == "Linux" then
					-- Linux
					vim.g.r_pdfviewer = "zathura" -- Uses default Linux PDF viewer
				elseif os_type == "Windows_NT" then
					-- Windows
					vim.g.r_pdfviewer = "SumatraPDF" -- Uses default Windows PDF viewer
				else
					-- Default, in case the OS is not detected or unsupported
					vim.g.r_pdfviewer = "open" -- A fallback viewer (for Mac)
				end
			end

			-- Call the function to set the viewer
			set_pdf_viewer()
			-- Create a table with the options to be passed to setup()
			---@type RConfigUserOpts
			local opts = {
				hook = {
					on_filetype = function()
						vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
						vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
						vim.api.nvim_buf_set_keymap(0, "n", "<localleader>aa", "<Plug>RSendFile", {})
						vim.api.nvim_buf_set_keymap(0, "n", "<localleader>ab", "<Plug>RSendAboveLines", {})
					end,
				},
				pdfviewer = vim.g.r_pdfviewer,
				R_args = { "--quiet", "--no-save" },
				min_editor_width = 72,
				rconsole_width = 78,
				objbr_mappings = { -- Object browser keymap
					c = "class", -- Call R functions
					["<localleader>gg"] = "head({object}, n = 15)", -- Use {object} notation to write arbitrary R code.
					v = function()
						-- Run lua functions
						require("r.browser").toggle_view()
					end,
				},
				disable_cmds = {
					"RClearConsole",
					"RCustomStart",
					"RSPlot",
					"RSaveClose",
				},
			}
			-- Check if the environment variable "R_AUTO_START" exists.
			-- If using fish shell, you could put in your config.fish:
			-- alias r "R_AUTO_START=true nvim"
			if vim.env.R_AUTO_START == "true" then
				opts.auto_start = "on startup"
				opts.objbr_auto_start = true
			end
			require("r").setup(opts)
		end,
	},
	{
		"R-nvim/cmp-r",
		{
			"hrsh7th/nvim-cmp",
			config = function()
				require("cmp").setup({ sources = { { name = "cmp_r" } } })
				require("cmp_r").setup({})
			end,
		},
	},
	--	--Quarto
	--	{
	--		"quarto-dev/quarto-nvim",
	--		dependencies = {
	--			"jmbuhr/otter.nvim",
	--			"nvim-treesitter/nvim-treesitter",
	--		},
	--		config = function()
	--			require("quarto").setup({
	--				debug = false,
	--				closePreviewOnExit = true,
	--				lspFeatures = {
	--					enabled = true,
	--					chunks = "curly",
	--					languages = { "r", "python", "julia", "bash", "html" },
	--					diagnostics = {
	--						enabled = true,
	--						triggers = { "BufWritePost" },
	--					},
	--					completion = {
	--						enabled = true,
	--					},
	--				},
	--				codeRunner = {
	--					enabled = true,
	--					default_method = "slime", -- "molten", "slime", "iron" or <function>
	--					ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
	--					-- Takes precedence over `default_method`
	--					never_run = { "yaml" }, -- filetypes which are never sent to a code runner
	--				},
	--			})
	--		end,
	--	},
	-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
	--
	-- This is often very useful to both group configuration, as well as handle
	-- lazy loading plugins that don't need to be loaded immediately at startup.
	--
	-- For example, in the following configuration, we use:
	--  event = 'VimEnter'
	--
	-- which loads which-key before all the UI elements are loaded. Events can be
	-- normal autocommands events (`:help autocmd-events`).
	--
	-- Then, because we use the `opts` key (recommended), the configuration runs
	-- after the plugin has been loaded as `require(MODULE).setup(opts)`.

	--	{ -- Useful plugin to show you pending keybinds.
	--		"folke/which-key.nvim",
	--		event = "VimEnter", -- Sets the loading event to 'VimEnter'
	--		opts = {
	--			-- delay between pressing a key and opening which-key (milliseconds)
	--			-- this setting is independent of vim.opt.timeoutlen
	--			delay = 0,
	--			icons = {
	--				-- set icon mappings to true if you have a Nerd Font
	--				mappings = vim.g.have_nerd_font,
	--				-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
	--				-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
	--				keys = vim.g.have_nerd_font and {} or {
	--					Up = "<Up> ",
	--					Down = "<Down> ",
	--					Left = "<Left> ",
	--					Right = "<Right> ",
	--					C = "<C-…> ",
	--					M = "<M-…> ",
	--					D = "<D-…> ",
	--					S = "<S-…> ",
	--					CR = "<CR> ",
	--					Esc = "<Esc> ",
	--					ScrollWheelDown = "<ScrollWheelDown> ",
	--					ScrollWheelUp = "<ScrollWheelUp> ",
	--					NL = "<NL> ",
	--					BS = "<BS> ",
	--					Space = "<Space> ",
	--					Tab = "<Tab> ",
	--					F1 = "<F1>",
	--					F2 = "<F2>",
	--					F3 = "<F3>",
	--					F4 = "<F4>",
	--					F5 = "<F5>",
	--					F6 = "<F6>",
	--					F7 = "<F7>",
	--					F8 = "<F8>",
	--					F9 = "<F9>",
	--					F10 = "<F10>",
	--					F11 = "<F11>",
	--					F12 = "<F12>",
	--				},
	--			},
	--
	--			-- Document existing key chains
	--			spec = {
	--				{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
	--				{ "<leader>d", group = "[D]ocument" },
	--				{ "<leader>r", group = "[R]ename" },
	--				{ "<leader>s", group = "[S]earch" },
	--				{ "<leader>w", group = "[W]orkspace" },
	--				{ "<leader>t", group = "[T]oggle" },
	--				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
	--			},
	--		},
	--	},

	--
	-- The dependencies are proper plugin specifications as well - anything
	-- you do for a plugin at the top level, you can do for a dependency.
	--
	-- Use the `dependencies` key to specify the dependencies of a particular plugin

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		config = function()
			require("copilot_cmp").setup()
		end,
		dependencies = {
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			config = function()
				require("copilot").setup({
					suggestion = { enabled = false },
					panel = { enabled = false },
				})
			end,
		},
	},

	{
		"okuuva/auto-save.nvim",
		version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
		cmd = "ASToggle", -- optional for lazy loading on command
		event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
		opts = {},
	},
	-- VimTex added by tkdhss111
	--{
	--	"lervag/vimtex",
	--	lazy = false, -- we don't want to lazy load VimTeX
	--	-- tag = "v2.15", -- uncomment to pin to a specific release
	--	init = function()
	--		-- VimTeX configuration goes here, e.g.
	--		vim.g.vimtex_view_method = "zathura"
	--	end,
	--},

	-- Git
	{
		"tpope/vim-fugitive",
		lazy = false,
	},

	---- Fortran
	--{
	--	"wassup05/fortran.nvim",
	--	lazy = true,
	--	-- load the plugin when `ft` is fortran
	--	ft = { "fortran" },
	--	opts = {
	--		-- all your configuration options go here
	--		server_opts = {
	--			path = "fortls",
	--			args = {
	--				"--notify_init",
	--				"--lowercase_intrinsics",
	--				"--hover_signature",
	--				"--hover_language=fortran",
	--				"--use_signature_help",
	--				"--enable_code_actions",
	--			},
	--			filetypes = { "fortran" },
	--			settings = {},
	--		},

	--		fpm_opts = {
	--			terminal = true,
	--			path = "fpm",
	--			args = {
	--				-- fpm args go here exactly as you would pass them to fpm
	--			},
	--		},

	--		formatter_opts = {
	--			path = "fprettify",
	--			format_on_save = true,
	--			args = {
	--				-- fpretiffy args go here exactly as you would pass them to fprettify
	--			},
	--		},
	--	},
	--},

	-- LSP Plugins
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			-- Mason must be loaded before its dependents so we need to set it up here.
			-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end
					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({
									group = "kickstart-lsp-highlight",
									buffer = event2.buf,
								})
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`ts_ls`) will work just fine
				-- ts_ls = {},
				--

				lua_ls = {
					-- cmd = { ... },
					-- filetypes = { ... },
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			--
			-- To check the current status of installed tools and/or manually install
			-- other tools, you can run
			--    :Mason
			--
			-- You can press `g?` for help in this menu.
			--
			-- `mason` had to be setup earlier: to configure its options see the
			-- `dependencies` table for `nvim-lspconfig` above.
			--
			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},

	"hrsh7th/cmp-nvim-lsp", -- LSP source
	"hrsh7th/cmp-buffer", -- Buffer source
	"hrsh7th/cmp-path", -- Path source
	"hrsh7th/cmp-cmdline", -- Command-line source
	"saadparwaiz1/cmp_luasnip", -- Snippet completions
	"rafamadriz/friendly-snippets", -- Predefined snippets
	"hrsh7th/cmp-nvim-lsp-signature-help",

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function()
					--     require('luasnip.loaders.from_vscode').lazy_load()
					--   end,
					-- },
				},
			},
			"hrsh7th/cmp-nvim-lsp", -- LSP source
			"hrsh7th/cmp-buffer", -- Buffer source
			"hrsh7th/cmp-path", -- Path source
			"hrsh7th/cmp-cmdline", -- Command-line source
			"saadparwaiz1/cmp_luasnip", -- Snippet completions
			"rafamadriz/friendly-snippets", -- Predefined snippets
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = {
					--completeopt = "menu,menuone,noinsert",
					autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged }, -- Auto-trigger on text change
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-n>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- If you prefer more traditional completion keymaps,
					-- you can uncomment the following lines
					--['<CR>'] = cmp.mapping.confirm { select = true },

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C->>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-<>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				sources = {
					{
						name = "lazydev",
						-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
						group_index = 0,
					},
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "nvim_lsp_signature_help" },
				},
			})
		end,
	},

	{
		"nvim-lua/lsp-status.nvim",

		config = function()
			local lsp_status = require("lsp-status")
			-- completion_customize_lsp_label as used in completion-nvim
			-- Optional: customize the kind labels used in identifying the current function.
			-- g:completion_customize_lsp_label is a dict mapping from LSP symbol kind
			-- to the string you want to display as a label
			-- lsp_status.config { kind_labels = vim.g.completion_customize_lsp_label }

			-- Register the progress handler
			lsp_status.register_progress()
		end,
	},
	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("tokyonight").setup({
				styles = {
					comments = { italic = false }, -- Disable italics in comments
				},
			})

			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
	-- Markdown added by tkdhss111
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	--	-- Markdown added by tkdhss111
	--	{
	--		"toppair/peek.nvim",
	--		event = { "VeryLazy" },
	--		build = "deno task --quiet build:fast",
	--		config = function()
	--			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
	--			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
	--			require("peek").setup({
	--				auto_load = true, -- whether to automatically load preview when
	--				-- entering another markdown buffer
	--				close_on_bdelete = true, -- close preview window on buffer delete
	--				syntax = true, -- enable syntax highlighting, affects performance
	--				theme = "dark", -- 'dark' or 'light'
	--				update_on_change = true,
	--				app = "webview", -- 'webview', 'browser', string or a table of strings
	--				filetype = { "markdown" }, -- list of filetypes to recognize as markdown
	--				-- relevant if update_on_change is true
	--				throttle_at = 200000, -- start throttling when file exceeds this
	--				-- amount of bytes in size
	--				throttle_time = "auto", -- minimum amount of time in milliseconds
	--			})
	--		end,
	--	},
	--	-- Markdown added by tkdhss111
	--	{
	--		"MeanderingProgrammer/render-markdown.nvim",
	--		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	--		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	--		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	--		---@module 'render-markdown'
	--		---@type render.md.UserConfig
	--		opts = {},
	--		config = function()
	--			require("render-markdown").setup({
	--				completions = { lsp = { enabled = true } },
	--			})
	--		end,
	--	},
	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = true },
	},

	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			-- require("mini.surround").setup() -- disabled by tkehss111 since key "s" freezes

			--tkdhss111 added
			require("mini.move").setup()
			require("mini.align").setup()
			require("mini.splitjoin").setup()
			--require("mini.pairs").setup()
			require("mini.clue").setup()
			require("mini.comment").setup()
			local gen_loader = require("mini.snippets").gen_loader
			local latex_patterns = { "latex/**/*.json", "**/latex.json" }
			local lang_patterns = { tex = latex_patterns, plaintex = latex_patterns }
			require("mini.snippets").setup({
				snippets = {
					-- Load custom file with global snippets first (adjust for Windows)
					gen_loader.from_file("~/0_tkd/1_hss/2_tools/vim/.config/nvim/snippets/global.json"),

					-- Load snippets based on current language by reading files from
					-- "snippets/" subdirectories from 'runtimepath' directories.
					gen_loader.from_lang({ lang_patterns = lang_patterns }),
				},
				-- Module mappings. Use `''` (empty string) to disable one.
				mappings = {
					-- Expand snippet at cursor position. Created globally in Insert mode.
					expand = "<C-s>",
					-- Interact with default `expand.insert` session.
					-- Created for the duration of active session(s)
					jump_next = "<C-L>",
					jump_prev = "<C-H>",
					stop = "<C-c>",
				},
			})

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"fortran",
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"r",
				"rnoweb",
				"yaml",
				"latex",
				"csv",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	},

	-- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
	-- init.lua. If you want these files, they are in the repository, so you can just download them and
	-- place them in the correct locations.

	-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
	--
	--  Here are some example plugins that I've included in the Kickstart repository.
	--  Uncomment any of the lines below to enable them (you will need to restart nvim).
	--
	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',
	-- require 'kickstart.plugins.lint',
	-- require 'kickstart.plugins.autopairs',
	-- require 'kickstart.plugins.neo-tree',
	-- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

	-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--    This is the easiest way to modularize your config.
	--
	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	-- { import = 'custom.plugins' },
	--
	-- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
	-- Or use telescope!
	-- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
	-- you can continue same window with `<space>sr` which resumes last telescope search
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

--tkdhss111 added

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

--local cmp = require("cmp")
--cmp.setup({
--	-- other setup
--	sources = {
--		-- Copilot Source
--		{ name = "copilot", group_index = 2 },
--		-- Other Sources
--		{ name = "nvim_lsp", group_index = 2 },
--		{ name = "path", group_index = 2 },
--		{ name = "luasnip", group_index = 2 },
--	}, -- other sources
--	mapping = {
--		["<Tab>"] = vim.schedule_wrap(function(fallback)
--			if cmp.visible() and has_words_before() then
--				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
--			else
--				fallback()
--			end
--		end),
--	},
--})

-- CSV viewer keybind added by tkdhss111
vim.api.nvim_create_autocmd("filetype", {
	pattern = "csv",
	callback = function()
		vim.opt_local.wrap = false
		vim.api.nvim_buf_set_keymap(0, "n", "<F4>", ":CsvViewToggle<CR>", { noremap = true, silent = true })
		--		vim.cmd("split")
		--		vim.cmd("resize 1")
		vim.cmd("CsvViewEnable")
	end,
})

-- latex keybind added by tkdhss111
vim.api.nvim_create_autocmd("filetype", {
	pattern = "tex",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "<F3>", ":w<CR>:make quizsol<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "<F4>", ":w<CR>:make run<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":w<CR>:make release<CR>", { noremap = true, silent = true })
	end,
})

-- makefile keybind added by tkdhss111
vim.api.nvim_create_autocmd("filetype", {
	pattern = "make",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "<F3>", ":w<CR>:AsyncRun make debug<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "<F4>", ":w<CR>:AsyncRun make run<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<F6>",
			":w<CR>:AsyncRun make release<CR>",
			{ noremap = true, silent = true }
		)
	end,
})

-- Fortran keybind added by tkdhss111
vim.api.nvim_create_autocmd("filetype", {
	pattern = "fortran",
	callback = function()
		vim.cmd([[ syntax match FortranConceal /%/ conceal cchar=. ]])
		vim.cmd([[ highlight link FortranConceal Special ]])
		vim.api.nvim_buf_set_keymap(0, "i", ",,", "%", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "<F3>", ":w<CR>:make debug<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "<F4>", ":w<CR>:make test<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":w<CR>:make run<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<F6>",
			":w<CR>:AsyncRunmake relwithdebinfo<CR>",
			{ noremap = true, silent = true }
		)
	end,
})

-- Quarto keybind added by tkdhss111
vim.api.nvim_create_autocmd("FileType", {
	pattern = "quarto",
	callback = function()
		local current_file_path = vim.api.nvim_buf_get_name(0)
		vim.api.nvim_buf_set_keymap(0, "n", "<F3>", ":AsyncRun make quizsol<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<F4>",
			":AsyncRun make render file='" .. current_file_path .. "'<CR>",
			--":AsyncRun make file='" .. current_file_path .. "'<CR><Esc><C-w>k",
			{ noremap = true, silent = true }
		)
		--		vim.api.nvim_buf_set_keymap(
		--			0,
		--			"n",
		--			"<F5>",
		--			":sp<CR>:res 5<CR>:terminal<CR>i make preview file='" .. current_file_path .. "'<CR><Esc><C-w>k",
		--			{ noremap = true, silent = true }
		--		)
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<F5>",
			":AsyncRun make preview file='" .. current_file_path .. "'<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<F7>",
			":sp<CR>:res 25<CR>:terminal<CR>i make preview file='" .. current_file_path .. "'<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<F8>",
			":sp<CR>:res 25<CR>:terminal<CR>i make render file='" .. current_file_path .. "'<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<F9>",
			":AsyncRun make html_self_contained<CR>",
			{ noremap = true, silent = true }
		)
	end,
})

--QuickFix Toggle
local function toggle_quickfix()
	local windows = vim.fn.getwininfo()
	for _, win in pairs(windows) do
		if win["quickfix"] == 1 then
			vim.cmd.cclose()
			return
		end
	end
	vim.cmd.copen()
end

vim.keymap.set("n", "<F2>", toggle_quickfix, { desc = "Toggle Quickfix Window" })

-- Add timestamp as extension for backup files
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("timestamp_backupext", { clear = true }),
	desc = "Add timestamp to backup extension",
	pattern = "*",
	callback = function()
		vim.opt.backupext = "-" .. vim.fn.strftime("%Y%m%d%H%M")
	end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
