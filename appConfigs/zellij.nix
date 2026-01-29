{ pkgs, ... }: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      theme = "double-espresso";
      themes = {
        double-espresso = {
          bg = "#1d2021";  # Roasted Bean (Black/Dark Brown)
          fg = "#d5c4a1";  # Latte Foam
          red = "#cc241d"; # Cherry
          green = "#98971a"; # Matcha
          blue = "#458588";  # Water
          yellow = "#d79921"; # Honey
          magenta = "#b16286"; # Berry
          orange = "#d65d0e"; # Caramel
          cyan = "#689d6a";  # Sage
          black = "#282828"; # Espresso
          white = "#fbf1c7"; # Steamed Milk
        };
      };
      default_layout = "compact";
      ui = {
        pane_frames = {
            rounded_corners = true;
            hide_session_name = true;
        };
      };
    };
  };

  xdg.configFile."zellij/layouts/dashboard.kdl".text = ''
    layout {
        default_tab_template {
            pane size=1 borderless=true {
                plugin location="zellij:tab-bar"
            }
            children
            pane size=2 borderless=true {
                plugin location="zellij:status-bar"
            }
        }
        tab name="Dashboard" focus=true {
            pane split_direction="vertical" {
                pane split_direction="horizontal" {
                    pane command="btop" name="System" size="60%"
                    pane command="cmatrix" args="-b" name="Matrix"
                }
                pane split_direction="horizontal" {
                    pane command="yazi" name="Files" size="60%"
                    pane name="Terminal"
                }
            }
        }
    }
  '';
}
