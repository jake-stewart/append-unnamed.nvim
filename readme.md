append-unnamed.nvim
===================
Works like `"A` which appends to register `a`, but for the unnamed (default) register.

### dependency
relies on [repeatable.nvim](https://github.com/jake-stewart/repeatable.nvim)

### usage
use `<leader>d` to delete and append to unnamed register.
use `<leader>y` to yank and append to unnamed register.

synonyms like `<leader>x`, `<leader>Y`, `<leader>dd` are automatically mapped.
You can provide `extra = false` in setup opts to disable this.

you can use another key instead of `<leader>` by overriding the `leader` option
in setup opts.


### setup
```lua
require("append-unnamed").setup()
```

or for further customization:

```lua
require("append-unnamed").setup({
    leader = "<leader>",
    extra = true
})
```


