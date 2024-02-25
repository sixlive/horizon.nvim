--- Generated by ./build/convert.lua
--- DO NOT EDIT THIS FILE DIRECTLY

local palette = {
  ansi = {
    bright = {
      blue = '#3FC4DE',
      cyan = '#6BE4E6',
      green = '#3FDAA4',
      magenta = '#F075B5',
      red = '#EC6A88',
      yellow = '#FBC3A7',
    },
    normal = {
      blue = '#26BBD9',
      cyan = '#59E1E3',
      green = '#29D398',
      magenta = '#EE64AC',
      red = '#E95678',
      yellow = '#FAB795',
    },
  },
  syntax = {
    apricot = '#F09483',
    cranberry = '#E95678',
    gray = '#BBBBBB',
    lavender = '#B877DB',
    rosebud = '#FAB795',
    tacao = '#FAC29A',
    turquoise = '#25B0BC',
  },
  ui = {
    accent = '#2E303E',
    accentAlt = '#6C6F93',
    background = '#2C3240',
    backgroundAlt = '#151620',
    border = '#1A1C23',
    darkText = '#06060C',
    lightText = '#D5D8DA',
    modified = '#21BFC2',
    negative = '#F43E5C',
    positive = '#09F7A0',
    secondaryAccent = '#E9436D',
    secondaryAccentAlt = '#E95378',
    shadow = '#16161C',
    tertiaryAccent = '#FAB38E',
    warning = '#27D797',
  },
}

local theme = {
  active_line_number_fg = '#81858D',
  bg = '#2C3240',
  class_variable = {
    fg = '#D65272',
  },
  code_block = {
    fg = '#DC8A7C',
  },
  codelens_fg = '#4C516A',
  color_column_fg = '#3F4459',
  comment = {
    fg = '#575B65',
    italic = true,
  },
  constant = {
    fg = '#DC8A7C',
  },
  cursor_bg = '#E95378',
  cursor_fg = '#2C3240',
  cursorline_bg = '#2D313F',
  delimiter = {
    fg = '#74777E',
  },
  diff_added_bg = '#29464A',
  diff_deleted_bg = '#4A2024',
  error = '#F43E5C',
  external_link = '#E9436D',
  fg = '#BBBBBB',
  field = {
    fg = '#D65272',
  },
  float_bg = '#151620',
  float_border = '#151620',
  func = {
    fg = '#26A3B0',
  },
  git_added_fg = '#29A67D',
  git_deleted_fg = '#F43E5C',
  git_ignored_fg = '#5F646E',
  git_modified_fg = '#FAB38E',
  git_untracked_fg = '#27D797',
  inactive_line_number_fg = '#3D434F',
  indent_guide_active_fg = '#2E303E',
  indent_guide_fg = '#2D313F',
  keyword = {
    fg = '#AA70CC',
  },
  link = {
    fg = '#E5AA8D',
  },
  match_paren = '#4C516A',
  operator = {
    fg = '#BBBBBB',
  },
  parameter = {
    italic = true,
  },
  pmenu_bg = '#151620',
  pmenu_item_sel_fg = '#E95378',
  pmenu_thumb_bg = '#323848',
  pmenu_thumb_fg = '#4C516A',
  regex = {
    fg = '#DC8A7C',
  },
  sidebar_bg = '#2C3240',
  sidebar_fg = '#81858D',
  sign_added_bg = '#14BC83',
  sign_deleted_bg = '#B83A54',
  sign_modified_bg = '#24959B',
  special_keyword = {
    fg = '#AA70CC',
  },
  statusline_active_fg = '#2E303E',
  statusline_bg = '#2C3240',
  statusline_fg = '#81858D',
  storage = {
    fg = '#AA70CC',
  },
  string = {
    fg = '#E5AA8D',
  },
  structure = {
    fg = '#E5B491',
  },
  tag = {
    fg = '#D65272',
    italic = true,
  },
  template_delimiter = {
    fg = '#AA70CC',
  },
  term_cursor_bg = '#D5D8DA',
  term_cursor_fg = '#4C516A',
  title = {
    fg = '#D65272',
  },
  type = {
    fg = '#E5B491',
  },
  variable = {
    fg = '#D65272',
  },
  visual = '#3F4459',
  warning = '#29A67D',
  winbar = '#151620',
  winseparator_fg = '#1A1C23',
}

return { theme = theme, palette = palette }
-- vim: set nomodifiable :
