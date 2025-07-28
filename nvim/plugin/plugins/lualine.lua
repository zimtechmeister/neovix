require('lualine').setup({
    options = {
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_c = {
            { 'filename', path = 1, },
            "macro_recording", "%S"
        },
    },
})
