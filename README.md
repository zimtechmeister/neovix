[template](https://github.com/nix-community/kickstart-nix.nvim)

# todo:
- [ ] in gerneral could rework how lsps work take reference from the template
- [ ] noice plugin has exaple on how not to use lze
- [ ] what do i need the lua/user/lsp file for?

---
old readme from the nixCats config i had
# lze (plugin lazyloader)

## link list:
[nixcats wiki](https://nixcats.org/)  
[nixCats repo](https://github.com/BirdeeHub/nixCats-nvim)  
[nixCats-nvim discussions](https://github.com/BirdeeHub/nixCats-nvim/discussions)  
[lze](https://github.com/BirdeeHub/lze)  
[BirdeeHub birdeevim repo](https://github.com/BirdeeHub/birdeevim)  

## these are loding hooks in lze
sometimes i pass arguments in this function  
when do i pass what arguments in those loading hooks?
```lua
after = function(plugin)
    require('lualine').setup()
end,
-- or
before = function()
    -- Configuration for plugins that don't force you to call a `setup` function
    -- for initialization should typically go in a `before`
    -- or `beforeAll` function.
    vim.g.startuptime_tries = 10
end,
```
## other things i dont fully understand
how do i set keymaps correctly

how to use neovide (https://github.com/BirdeeHub/nixCats-nvim/discussions/99)

rename this repo

autoupdate (maybe use github actions)

swap all mini plugins for mini.deps also lazyloads to my understanding
