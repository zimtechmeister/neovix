# This overlay, when applied to nixpkgs, adds the final neovim derivation to nixpkgs.
{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Use this to create a plugin from a flake input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  # Make sure we use the pinned nixpkgs instance for wrapNeovimUnstable,
  # otherwise it could have an incompatible signature when applying this overlay.
  pkgs-locked = inputs.nixpkgs.legacyPackages.${pkgs.system};

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix {
    inherit (pkgs-locked) wrapNeovimUnstable neovimUtils;
  };

  # NOTE: A plugin can either be a package or an attrset, such as
  # i changed some defaults look for defaultPlugin in mkNeovim.nix (optional)
  # { plugin = <plugin>; # the package, e.g. pkgs.vimPlugins.nvim-cmp
  #   config = <config>; # String; a config that will be loaded with the plugin
  #   # Boolean; Whether to automatically load the plugin as a 'start' plugin,
  #   # or as an 'opt' plugin, that can be loaded with `:packadd!`
  #   optional = <true|false>; # Default: true
  #   ...
  # }
  all-plugins = with pkgs.vimPlugins; [
    # plugins from nixpkgs go in here.
    # https://search.nixos.org/packages?channel=unstable&query=vimPlugins
    # or from flake inputs as
    # (mkNvimPlugin inputs.inputName "pulginName")

    #lsp
    nvim-lspconfig

    #debugger
    nvim-dap
    nvim-dap-ui
    nvim-nio
    nvim-dap-virtual-text

    nvim-treesitter.withAllGrammars
    blink-cmp
    lualine-nvim
    (mkNvimPlugin inputs.lualine-macro-recording "lualine-macro-recording")
    arrow-nvim
    nvim-scrollbar
    gitsigns-nvim
    undotree
    markdown-preview-nvim
    colorizer # no setup needed
    # folke
    snacks-nvim
    which-key-nvim
    todo-comments-nvim
    noice-nvim
    flash-nvim
    sidekick-nvim
    # mini
    mini-ai
    mini-comment
    mini-pairs
    mini-surround
    mini-files
    mini-icons

    # colorschemes
    (mkNvimPlugin inputs.vim-moonfly-colors "vim-moonfly-colors")
    (mkNvimPlugin inputs.vague-nvim "vague-nvim")
    gruvbox-nvim
    catppuccin-nvim
    tokyonight-nvim
    oxocarbon-nvim
    # everforest # sainnhe's version
    (mkNvimPlugin inputs.everforest-nvim "everforest-nvim")
    # gruvbox-material # sainnhe's version
    gruvbox-material-nvim
  ];

  extraPackages = with pkgs; [
    # language servers, etc.
    lua-language-server
    jdt-language-server
    clang-tools
    nixd
    alejandra
    copilot-language-server

    #rust
    rustc
    cargo
    rust-analyzer
    clippy
    rustfmt

    gdb

    # Snacks image dependency
    ghostscript
    mermaid-cli
  ];
in {
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # This is meant to be used within a devshell.
  # Instead of loading the lua Neovim configuration from
  # the Nix store, it is loaded from $XDG_CONFIG_HOME/nvim-dev
  nvim-dev = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
    appName = "nvim-dev";
    wrapRc = false;
  };

  # This can be symlinked in the devShell's shellHook
  nvim-luarc-json = final.mk-luarc-json {
    plugins = all-plugins;
  };

  # You can add as many derivations as you like.
  # Use `ignoreConfigRegexes` to filter out config
  # files you would not like to include.
  #
  # For example:
  #
  # nvim-pkg-no-telescope = mkNeovim {
  #   plugins = [];
  #   ignoreConfigRegexes = [
  #     "^plugin/telescope.lua"
  #     "^ftplugin/.*.lua"
  #   ];
  #   inherit extraPackages;
  # };
}
