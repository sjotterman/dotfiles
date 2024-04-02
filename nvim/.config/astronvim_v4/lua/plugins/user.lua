-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==


  -- == Examples of Overriding Plugins ==

  -- customize alpha options

  -- You can disable default plugins as follows:

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call

    {
"nvim-neo-tree/neo-tree.nvim",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.neo-tree"(plugin, opts) -- include the default astronvim config that calls the setup call
      opts.open_files_do_not_replace_types = {"terminal", "trouble", "qf", "fugitive"}
    end,
  },
}
