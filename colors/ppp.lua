vim.opt.background = 'dark'
vim.g.colors_name = 'ppp'
package.loaded['lush_theme.ppp'] = nil
require('lush')(require('lush_theme.ppp'))
