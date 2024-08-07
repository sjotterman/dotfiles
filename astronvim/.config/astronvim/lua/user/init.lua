return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "astrodark",
  -- colorscheme = "darcubox",
  -- colorscheme = "onedark",
  -- colorscheme = "minimal",
  -- colorscheme = "nvim-juliana",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    mappings = function(table)
      table.n.gd = { "<cmd>lua My_go_to_definition()<cr>", desc = "Go to definition" }
      return table
    end,
    -- customize lsp formatting options
    formatting = {
      -- use prettier, not tsserver, to format
      -- https://docs.astronvim.com/recipes/advanced_lsp/
      -- https://github.com/AstroNvim/AstroNvim/issues/1440#issuecomment-1348491819
      filter = function(client)
        if client.name == "tsserver" then return false end
        return true
      end,
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "prettier"
      -- "pyright"
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    --
    --
    --
    vim.cmd [[
    function! DeleteHiddenBuffers()
      let tpbl=[]
      let closed = 0
      call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
      for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        if getbufvar(buf, '&mod') == 0
          silent execute 'bwipeout' buf
          let closed += 1
        endif
      endfor
      echo "Closed ".closed." hidden buffers"
  endfunction
  ]]

    --- If we're in a TS file, use the TypeScript go to source definition, which skips
    --- the generated d.ts files
    function My_go_to_definition()
      if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
        vim.cmd "TypescriptGoToSourceDefinition"
      else
        vim.lsp.buf.definition()
      end
    end

    vim.cmd [[
    command! W write
    ]]

    vim.cmd [[
    command! Wq wq
    ]]

    vim.cmd [[
    command! Wqall wqall
    ]]

    vim.cmd [[
    command! Qall qall
    ]]

    vim.cmd [[
    command! Vsp vsplit
    ]]
    -- is this the best place for this?
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      update_in_insert = false,
    })
  end,
}
