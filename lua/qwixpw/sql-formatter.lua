--Need to setup with null-ls in packer.lua
local h = require("null-ls.helpers")
local methods = require("nulls-ls.methods")

local FORMATTING = methods.internal.FORMATTING

return h.make_builtin({
    name = "sql-formatter",
    meta = {
        url = "https://github.com/sql-formatter-org/sql-formatter",
        description = "A whitespace formatter for different query languages",
    },
    methods = FORMATTING,
    filetypes = { "sql", "md" },
    generator_opts = {
        command = "sql-formatter",
        to_stdin = true,
    },
    factory = h.formatter_factory,
})
