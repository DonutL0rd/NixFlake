    {pkgs, ...}: {
    home.username = "benjamincurrie";
    home.homeDirectory = "/Users/benjamincurrie";    
    home.stateVersion = "24.11"; # Comment out for error with "latest" version
    programs.home-manager.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        initExtra = ''
          clear
          neofetch 

          # Screensaver (5 minutes idle)
          # Only triggers when at the prompt, not while running commands.
          TMOUT=300
          TRAPALRM() {
            cmatrix -s -b
          }

          # AI Error Analyzer 'wtf'
          function wtf() {
            local cmd=""
            
            # If arguments are provided, use them as the command
            if [[ -n "$1" ]]; then
                cmd="$*"
            else
                # Otherwise, grab the last command from history
                # fc -ln -1 gets the last command; sed trims leading whitespace
                cmd=$(fc -ln -1 | sed 's/^[ \t]*//')
                echo "Re-running: $cmd"
            fi

            local log_file="/tmp/wtf_stderr.log"
            
            # Run the command using eval to handle quotes/pipes
            # 2> >(tee ...) captures stderr to file while showing it
            eval "$cmd" 2> >(tee "$log_file" >&2)
            local exit_code=$?

            if [[ $exit_code -ne 0 ]]; then
                echo ""
                # Color: Red (#cc241d)
                printf "\033[38;2;204;36;29m💥 Command failed (Exit: $exit_code). Asking AI...\033[0m\n"
                
                # Color: Caramel (#d65d0e)
                printf "\033[38;2;214;93;14m"
                cat "$log_file" | gemini "The following command failed: '$cmd'. Here is the error log:\n\n$(cat $log_file)\n\nExplain the error in one short sentence and provide the exact command to fix it if possible. Be concise." 2>/dev/null
                printf "\033[0m\n"
            elif [[ -z "$1" ]]; then
                echo "The command executed successfully this time."
            fi
            
            return $exit_code
          }
        '';
        shellAliases = {
            cat = "bat -pp";
            ls = "eza --icons -F -H --group-directories-first --git -1";
            z = "zellij attach main";
            y = "yazi";
            obdir = "cd /Users/benjamincurrie/Library/Mobile\\ Documents/iCloud\\~md\\~obsidian/Documents/Obsidian";
            hmswitch = "home-manager switch --flake ~/src/nix#benjamincurrie";
            dashboard = "zellij --layout dashboard";
        }; 
    };
}
