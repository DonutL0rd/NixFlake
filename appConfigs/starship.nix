{ pkgs, lib, config, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableTransience = false;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      
      # The "Double Espresso" Gradient:
      # OS/User (Espresso) -> Dir (Dark Roast) -> Git (Medium Roast) -> Languages (Latte)
      format = lib.concatStrings [
        "[](color_bg1)"
        "$os"
        "$username"
        "$hostname"
        "[](fg:color_bg1 bg:color_bg3)"
        "$directory"
        "[](fg:color_bg3 bg:color_coffee)"
        "$git_branch"
        "$git_status"
        "[](fg:color_coffee bg:color_cream)"
        "$c"
        "$rust"
        "$golang"
        "$nodejs"
        "$php"
        "$java"
        "$kotlin"
        "$haskell"
        "$python"
        "[ ](fg:color_cream)"
        "$line_break$character"
      ];

      right_format = lib.concatStrings [
        "[](fg:color_coffee)"
        "$kubernetes"
        "$docker_context"
        "$conda"
        "[](fg:color_coffee bg:color_bg1)"
        "$time"
        "[](fg:color_bg1)"
      ];
      
      palette = "coffee";
      
      palettes.coffee = {
        color_fg0 = "#fbf1c7"; # Milk/Foam
        color_bg1 = "#282828"; # Espresso (Darkest)
        color_bg3 = "#3c3836"; # Dark Roast
        color_coffee = "#504945"; # Medium Roast
        color_brown = "#665c54"; # Light Roast
        color_cream = "#d5c4a1"; # Latte
        color_green = "#98971a"; # Matcha
        color_orange = "#d65d0e"; # Caramel
        color_red = "#cc241d"; # Cherry
        color_yellow = "#d79921"; # Honey
        color_blue = "#458588"; # Water
        color_aqua = "#689d6a"; # Sage
      };
      
      os = {
        disabled = false;
        style = "bg:color_bg1 fg:color_fg0";
        symbols = {
          Arch = "󰣇 ";
          Linux = "󰌽 ";
          Macos = "󰀵 ";
          NixOS = " ";
        };
      };
      
      username = {
        show_always = true;
        style_user = "bg:color_bg1 fg:color_yellow";
        format = "[$user]($style)";
      };
      
      hostname = {
        ssh_only = true;
        style = "bg:color_bg1 fg:color_yellow";
        format = "[@$hostname ]($style)";
      };
      
      directory = {
        style = "fg:color_fg0 bg:color_bg3";
        format = "[ $path ]($style)";
        truncation_length = 3;
      };
      
      git_branch = {
        symbol = "";
        style = "bg:color_coffee";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_coffee)]($style)";
      };
      
      git_status = {
        style = "bg:color_coffee";
        format = "[[($all_status$ahead_behind )](fg:color_yellow bg:color_coffee)]($style)";
      };

      kubernetes = {
        symbol = "☸";
        style = "fg:color_fg0 bg:color_coffee";
        format = "[$symbol $context]($style)";
        disabled = false;
      };

      docker_context = {
        symbol = "";
        style = "bg:color_coffee";
        format = "[ $symbol $context ](fg:color_fg0 bg:color_coffee)";
      };

      conda = {
        symbol = "";
        style = "bg:color_coffee";
        format = "[ $symbol $environment ](fg:color_fg0 bg:color_coffee)";
      };
      
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };
      
      character = {
        success_symbol = "[☕ ❯](bold fg:color_green)";
        error_symbol = "[☕ ❯](bold fg:color_red)";
      };
      
      nodejs = {
        symbol = "";
        style = "bg:color_cream";
        format = "[[ $symbol ($version) ](fg:color_bg1 bg:color_cream)]($style)";
      };
      
      python = {
        symbol = "";
        style = "bg:color_cream";
        format = "[[ $symbol ($version) ](fg:color_bg1 bg:color_cream)]($style)";
      };
      
      rust = {
        symbol = "";
        style = "bg:color_cream";
        format = "[[ $symbol ($version) ](fg:color_bg1 bg:color_cream)]($style)";
      };
      
      golang = {
        symbol = "";
        style = "bg:color_cream";
        format = "[[ $symbol ($version) ](fg:color_bg1 bg:color_cream)]($style)";
      };
      
      c = { style = "bg:color_cream"; format = "[[ $symbol ($version) ](fg:color_bg1 bg:color_cream)]($style)"; };
      php = { style = "bg:color_cream"; format = "[[ $symbol ($version) ](fg:color_bg1 bg:color_cream)]($style)"; };
      java = { style = "bg:color_cream"; format = "[[ $symbol ($version) ](fg:color_bg1 bg:color_cream)]($style)"; };
      kotlin = { style = "bg:color_cream"; format = "[[ $symbol ($version) ](fg:color_bg1 bg:color_cream)]($style)"; };
      haskell = { style = "bg:color_cream"; format = "[[ $symbol ($version) ](fg:color_bg1 bg:color_cream)]($style)"; };
    };
  };
}