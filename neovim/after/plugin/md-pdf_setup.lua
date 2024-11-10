require('md-pdf').setup() -- default options, or
require('md-pdf').setup({
  --- Set margins around document
  margins = "1.5cm",
  --- tango, pygments are quite nice for white on white
  highlight = "tango",
  --- Generate a table of contents, on by default
  toc = true,
  --- Define a custom preview command, enabling hooks and other custom logic
  preview_cmd = function() return 'firefox' end
})

-- setup mapping
vim.keymap.set("n", "<Space>,", function()
    require('md-pdf').convert_md_to_pdf()
end)

