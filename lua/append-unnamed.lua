local repeatable = require("repeatable")

local function appendUnnamed(key)
    return function(o)
        local reg = vim.o.clipboard:gmatch("unnamedplus") and "+" or "@"
        local z = { vim.fn.getreg("z"), vim.fn.getregtype("z") }
        vim.fn.setreg("z", vim.fn.getreg(reg), vim.fn.getregtype(reg))
        if o.motion == "char" then
            vim.fn.feedkeys("`[" .. '"Z' .. key .. "v`]", "tx")
        else
            vim.fn.feedkeys("'[" .. '"Z' .. key .. "']", "tx")
        end
        vim.fn.setreg(reg, vim.fn.getreg("z"), vim.fn.getregtype("z"))
        vim.fn.setreg("z", z[1], z[2])
    end
end

return {
    setup = function(opts)
        opts = opts or {}
        local l = opts.leader or "<leader>"

        vim.keymap.set({"n", "v"}, l .. "d",
            repeatable(appendUnnamed("d"), {op = true}), {expr = true})

        vim.keymap.set({"n", "v"}, l .. "y",
            repeatable(appendUnnamed("y"), {op = true}), {expr = true})

        if opts.extra ~= false then
            vim.keymap.set({"n"}, l .. "yy", l .. "y_", {remap = true})
            vim.keymap.set({"n"}, l .. "dd", l .. "d_", {remap = true})
            vim.keymap.set({"n"}, l .. "Y", l .. "y$", {remap = true})
            vim.keymap.set({"n"}, l .. "D", l .. "d$", {remap = true})
            vim.keymap.set({"n"}, l .. "x", l .. "dl", {remap = true})
            vim.keymap.set({"v"}, l .. "Y", l .. "y", {remap = true})
            vim.keymap.set({"v"}, l .. "D", l .. "d", {remap = true})
            vim.keymap.set({"v"}, l .. "x", l .. "d", {remap = true})
        end
    end,
}
