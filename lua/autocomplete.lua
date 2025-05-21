return {
    'saghen/blink.cmp', version = '1.3.1', opts = {
        keymap = {
            preset = 'default'
        },
        appearance = { nerd_font_variant = 'mono' },
        cmdline = { enabled = false },
        completion = { 
            list = { selection = {
                preselect = true,
                auto_insert = true, 
            }},
            documentation = { auto_show = true },
            menu = {
                draw = { columns = {
                    { "label", "label_description", gap = 1 },
                    { "kind_icon", "kind" }
                }}
            }
        },
        sources = {
            default = { 'lsp', 'path', 'buffer' }
        },
    }
}
