local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local M = {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "windwp/nvim-autopairs",
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",
  },
}

function M.config()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local defaults = require("cmp.config.default")()
  local sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer" },
  })

  for _, source in ipairs(sources) do
    source.group_index = source.group_index or 1
  end

  local cmp = require("cmp")

  cmp.setup({
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<S-CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-CR>"] = function(fallback)
        cmp.abort()
        fallback()
      end,
      -- ["<Tab>"] = function(fallback)
      -- 	if cmp.visible() then
      -- 		cmp.select_next_item()
      -- 	else
      -- 		fallback()
      -- 	end
      -- end,

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- that way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),

      -- ["<S-Tab>"] = function(fallback)
      -- 	if cmp.visible() then
      -- 		cmp.select_prev_item()
      -- 	else
      -- 		fallback()
      -- 	end
      -- end,
      ["<Esc>"] = cmp.mapping(function()
        cmp.mapping.abort()
        vim.cmd("stopinsert")
      end),
    }),
    sources = sources,
    formatting = {
      fields = { "kind", "abbr", "menu" },
      expandable_indicator = true,
      format = function(entry, item)
        local icons = require("utils.ui.icons").kinds
        local icon = ""
        if icons[item.kind] then
          icon = icons[item.kind]
        end
        item.menu = "  (" .. item.kind .. ")  "
        item.kind = " " .. icon
        return item
      end,
    },
    window = {
      completion = {
        winhighlight = "Normal:Pmenu",
        border = make_border(),
        col_offset = -3,
        side_padding = 0,
      },
      documentation = {
        winhighlight = "Normal:Pmenu",
        border = make_border(),
      },
    },
    experimental = {
      ghost_text = {
        hl_group = "CmpGhostText",
      },
    },
    sorting = defaults.sorting,
  })

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

  require("luasnip.loaders.from_snipmate").lazy_load()
end

return M
