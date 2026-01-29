{ pkgs, ... }: {
  # Install Ghostty
  # home.packages = [ pkgs.ghostty ]; # Currently broken on aarch64-darwin in nixpkgs

  # Configure Ghostty
  xdg.configFile."ghostty/config".text = ''
    # --- Double Espresso Theme (Custom) ---
    background = #1d2021
    foreground = #d5c4a1
    selection-background = #504945
    selection-foreground = #fbf1c7
    
    # Palette (Roasted Coffee)
    palette = 0=#282828
    palette = 1=#cc241d
    palette = 2=#98971a
    palette = 3=#d79921
    palette = 4=#458588
    palette = 5=#b16286
    palette = 6=#689d6a
    palette = 7=#fbf1c7
    
    # Bright Palette
    palette = 8=#928374
    palette = 9=#fb4934
    palette = 10=#b8bb26
    palette = 11=#fabd2f
    palette = 12=#83a598
    palette = 13=#d3869b
    palette = 14=#8ec07c
    palette = 15=#ebdbb2

    # --- Fonts ---
    font-family = "JetBrainsMono Nerd Font Mono"
    font-size = 13
    # Enable ligatures (usually auto, but forcing ensures it)
    font-feature = calt
    
    # --- 1. CRT Shader (The "Cool" Factor) ---
    # Un-comment other shaders to try them!
    # shader = crt
    # shader = bloom
    # shader = glitch
    
    # --- 2. Window & Focus ---
    window-padding-x = 12
    window-padding-y = 12
    window-decoration = true
    macos-titlebar-style = transparent
    
    # Dim the terminal when you aren't using it (Focus helper)
    # focus-lost-opacity = 0.85
    
    # --- 3. Transparency & Blur ---
    background-opacity = 0.93
    background-blur-radius = 20
    
    # --- 4. Mouse Powers ---
    # Hide mouse when typing (Cleaner)
    mouse-hide-while-typing = true
    # Option+Click to move cursor in vim/emacs/shell (Magic!)
    mouse-shift-capture = true
    
    # --- 5. Cursor ---
    cursor-style = block
    cursor-style-blink = false
    
    # --- 6. Shell Integration ---
    shell-integration = zsh
    # Enables fancy features like "sudo" detection and cursor placement
    shell-integration-features = no-cursor,sudo,title
    
    # --- 7. Window Management ---
    # Start new windows in the same directory as the current one
    window-inherit-working-directory = false
    
    # --- 8. Copy/Paste ---
    # Linux-style: Copy immediately when selecting text (Optional, default false)
      copy-on-select = true
    
    # --- 9. Keybinds (Productivity) ---
    # Reload config instantly
    keybind = cmd+shift+r=reload_config
    # Toggle "Focus Mode" (No padding, fullscreen-ish)
    keybind = cmd+shift+z=toggle_window_decorations
    
    # --- 10. Auto-Update ---
    # Keep it fresh
    auto-update = check
  '';
}
