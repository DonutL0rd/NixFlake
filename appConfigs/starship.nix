{pkgs, lib, config, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      
      format = lib.concatStrings [
        "[](color_orange)"
        "$os"
        "$username"
        "$hostname"
        "[](bg:color_yellow fg:color_orange)"
        "$directory"
        "[](fg:color_yellow bg:color_aqua)"
        "$git_branch"
        "$git_status"
        "[](fg:color_aqua bg:color_blue)"
        "$c"
        "$rust"
        "$golang"
        "$nodejs"
        "$php"
        "$java"
        "$kotlin"
        "$haskell"
        "$python"
        "[](fg:color_blue bg:color_bg3)"
        "$kubernetes"
        "$docker_context"
        "$conda"
        "[](fg:color_bg3 bg:color_bg1)"
        "$time"
        "[ ](fg:color_bg1)"
        "$line_break$character"
      ];
      
      palette = lib.mkForce "tokyonight";
      
      palettes.tokyonight = {
        color_fg0 = "#1a1b26";
        color_bg1 = "#414868";
        color_bg3 = "#565f89";
        color_blue = "#7aa2f7";
        color_aqua = "#7dcfff";
        color_green = "#9ece6a";
        color_orange = "#ff9e64";
        color_purple = "#bb9af7";
        color_red = "#f7768e";
        color_yellow = "#e0af68";
      };
      
      os = {
        disabled = false;
        style = "bg:color_orange fg:color_fg0";
        symbols = {
          Arch = "󰣇 ";
          Linux = "󰌽 ";
          Macos = "󰀵 ";
          NixOS = " ";
        };
      };
      
      username = {
        show_always = true;
        style_user = "bg:color_orange fg:color_fg0";
        format = "[$user]($style)";
      };
      
      hostname = {
        ssh_only = true;
        style = "bg:color_orange fg:color_fg0";
        format = "[@$hostname ]($style)";
      };
      
      kubernetes = {
        symbol = " ";
        style = "fg:color_fg0 bg:color_bg3";
        format = "[ $symbol$context ]($style)";
        disabled = false;
      };
      
      directory = {
        style = "fg:color_fg0 bg:color_yellow";
        format = "[ $path ]($style)";
        truncation_length = 3;
      };
      
      git_branch = {
        symbol = "";
        style = "bg:color_aqua";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
      };
      
      git_status = {
        style = "bg:color_aqua";
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
      };
      
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };
      
      character = {
        success_symbol = "[](bold fg:color_green)";
        error_symbol = "[](bold fg:color_red)";
      };
      
      nodejs.symbol = "";
      python.symbol = "";
      rust.symbol = "";
      golang.symbol = "";
      docker_context.symbol = "";
    };
  };
}