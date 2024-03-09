return {
  "tsserver",
  setup = function()
    return {
      root_dir = require('lspconfig.util').root_pattern('.git'),
      init_options = {
        plugins = {
          {
            name = '@styled/typescript-styled-plugin',
            location = '/Users/anty3/Library/Application Support/fnm/node-versions/v18.14.2/installation/lib'
          }
        }
      }
    }
  end
}
