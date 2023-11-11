local CTRL_V = vim.api.nvim_replace_termcodes("<c-v>", true, true, true)

local COMMANDS = {
    line = "'[V']",
    char = "`[v`]",
    block = "`[" .. CTRL_V .. "`]",
}

local function opfunc(key)
    return function(type)
        if type == nil then
            vim.o.operatorfunc = "v:lua.require'append-unnamed'.opfuncs." .. key
            return "g@"
        end
        local reg = vim.o.clipboard:gmatch("unnamedplus") and "+" or "@"
        local z = { vim.fn.getreg("z"), vim.fn.getregtype("z") }
        vim.fn.setreg("z", vim.fn.getreg(reg), vim.fn.getregtype(reg))
        vim.cmd("noautocmd keepjumps normal!" .. COMMANDS[type] .. '"Z' .. key)
        vim.fn.setreg(reg, vim.fn.getreg("z"), vim.fn.getregtype("z"))
        vim.fn.setreg("z", z[1], z[2])
    end
end

local opfuncs = {
    d = opfunc("d"),
    y = opfunc("y"),
}

return {
    setup = function(opts)
        opts = opts or {}
        local l = opts.leader or "<leader>"
        for k, v in pairs(opfuncs) do
            vim.keymap.set({"n", "v"}, l .. k, v, {expr = true})
        end
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
    opfuncs = opfuncs,
}
