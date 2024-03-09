local M = {}

M.diagnostics = {
  Error = " ",
  Warn  = " ",
  Hint  = " ",
  Info  = " ",
}

M.git = {
  added    = " ",
  modified = " ",
  removed  = " ",
}

M.kinds = {
  Array         = " ",
  Boolean       = "⊨ ",
  Class         = " ",
  -- Codeium       = "󰘦 ",
  Color         = " ",
  Control       = " ",
  Collapsed     = " ",
  Constant      = "  ",
  Constructor   = " ",
  -- Copilot       = " ",
  Enum          = " ",
  EnumMember    = " ",
  Event         = " ",
  Field         = " ",
  File          = " ",
  Folder        = " ",
  Function      = "󰡱 ",
  Interface     = " ",
  Key           = " ",
  Keyword       = " ",
  Method        = " ",
  Module        = " ",
  Namespace     = "Nm ",
  Null          = "NULL ",
  Number        = " ",
  Object        = " ",
  Operator      = " ",
  Package       = " ",
  Property      = " ",
  Reference     = " ",
  Snippet       = " ",
  String        = " ",
  Struct        = "𝓢 ",
  -- TabNine       = "󰏚 ",
  Text          = " ",
  TypeParameter = " ",
  Unit          = " ",
  Value         = " ",
  Variable      = " ",
}

return M;
