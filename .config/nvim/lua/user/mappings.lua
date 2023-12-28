return {
  n = {
    ["<F10>"] =  {":ClangdSwitchSourceHeader<cr>", desc = "Switch source/header"},
    ["<F9>"]  =  {":Neotree filesystem<cr>",       desc = "Switch neotree to filesystem view"},
    ["<F8>"]  =  {":Neotree buffers<cr>",          desc = "Switch neotree to buffers view"},
    ["<F7>"]  =  {":%!astyle --options=./astyle.conf<cr><cr>", desc = "Astyle"},
    ["<C-q>"] =  { "", desc = "Force quit is disabled" }
  },
}
