{ config, pkgs, user, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in

{
  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    ripgrep   
    fd        
    fzf       
    jq        
    lazygit
    neovim
    nerd-fonts.hack
    eza
    zoxide
    fastfetch
    go
  ];
  fonts.fontconfig.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
    HOMEBREW_NO_AUTO_UPDATE = "1";
  };

  programs.git = {
    enable = true;
    userName = "taison36";
    userEmail = "tihon.korol77@gmail.com";
    extraConfig = {
      core.autocrlf = "input";
      init.defaultBranch = "master";
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;      # ghost text from history
    syntaxHighlighting.enable = true;  # commands turn green when valid
    initContent = ''
      # Load secrets that are not tracked in the dotfiles repo (gitignored)
      [ -f "$HOME/.config/zsh/secrets.zsh" ] && source "$HOME/.config/zsh/secrets.zsh"

      bindkey '^f' autosuggest-accept

      # completion using arrow keys (based on history)
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward

      eval "$(zoxide init zsh)"

      # Ctrl+S to bring last backgrounded job to foreground
      stty -ixon
      _fg_widget() { fg }
      zle -N _fg_widget
      bindkey '^S' _fg_widget
    '';
    shellAliases = {
      add = "git add .";
      push = "git push";
      pull = "git pull";
      ccl = "claude";
      ls = "eza --icons=always --color=always --no-user --long -la --no-permissions";
      cd = "z";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration$line_break$character";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
      };
      cmd_duration.format = "[$duration]($style) ";
    };
  };

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    mouse = true;
    keyMode = "vi";
    terminal = "tmux-256color";
    escapeTime = 10;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      resurrect
      continuum
#      tokyo-night-tmux
    ];

    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"
      unbind %
      bind u split-window -v -c "#{pane_current_path}"
      unbind '"'
      bind i split-window -h -c "#{pane_current_path}"
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf
      bind -r m resize-pane -Z
      bind M-c attach-session -c "#{pane_current_path}"

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel "pbcopy"
      bind-key -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe-and-cancel "pbcopy"

      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-restore 'on'
    '';
  };

  # Edit-in-place: the real file stays in my repo, ~/.config just points at it.
  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/wezterm";

  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/nvim";

  # Karabiner-Elements rewrites this file via its GUI, so point straight at the repo.
  home.file.".config/karabiner/karabiner.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/karabiner/karabiner.json";

  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.claude/settings.json";

  # Gitignored secrets file - edit-in-place, never committed.
  home.file.".config/zsh/secrets.zsh".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/zsh/secrets.zsh";

  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
}
