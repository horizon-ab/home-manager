{
  config,
  pkgs,
  nixGL,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bsay";
  home.homeDirectory = "/home/bsay";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    manga-tui
    cargo
    rustc
    ani-cli
    (config.lib.nixGL.wrap thunderbird)
    asciiquarium
    (config.lib.nixGL.wrap zed-editor)
    (config.lib.nixGL.wrap vesktop)
  ];

  programs.fish = {
    enable = true;
    shellInit = ''
      fish_vi_key_bindings
      set fish_greeting
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  xdg.configFile = {
    "hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf;
    "starship.toml".source = ./dotfiles/jetpack.toml;
    "waybar" = {
      source = ./dotfiles/waybar;
      recursive = true;
    };
    "fastfetch/config.jsonc".source = ./dotfiles/fastfetch/config.jsonc;
  };

  nixGL.packages = nixGL.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.installScripts = [ "mesa" ];

  programs.kitty = {
    enable = true;
    # themeFile = "Ubuntu";
    package = config.lib.nixGL.wrap pkgs.kitty;
    shellIntegration.enableFishIntegration = true;
    shellIntegration.enableBashIntegration = true;
    settings = {
      font_size = 11;
      window_padding_width = "8 8";
      confirm_os_window_close = -1;
      enable_audio_bell = "no";
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      scrollback_pager = ''nvim --noplugin -c "set signcolumn=no showtabline=0" -c "silent write! /tmp/kitty_scrollback_buffer | te cat /tmp/kitty_scrollback_buffer - "'';
    };
    keybindings = {
      "kitty_mod+h" = "show_scrollback";
    };
  };

  programs.wofi = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  programs.fastfetch.enable = true;

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/bsay/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
