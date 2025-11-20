# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# =================[ CONFIG JAVIER ]==================

# ALIAS
alias ginit="git init"
alias gc="git commit -m '$1'"
alias gp="git push"
alias gf="git fetch && git pull"
alias ga="git add '$1'"
alias cd..="cd .."
alias ls="ls -la"
alias neofetch="fastfetch"
alias vim="nvim"

# funciones
mkcd() {
  mkdir -p "$1"
  cd "$1" || return
}
# Para extraer varios tipos de archivos comprimidos ez
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"    ;;
      *.tar.gz)    tar xzf "$1"    ;;
      *.bz2)       bunzip2 "$1"    ;;
      *.dmg)       hdiutil mount "$1" ;;
      *.gz)        gunzip "$1"     ;;
      *.tar)       tar xf "$1"     ;;
      *.tbz2)      tar xjf "$1"    ;;
      *.tgz)       tar xzf "$1"    ;;
      *.zip)       unzip "$1"      ;;
      *.ZIP)       unzip "$1"      ;;
      *.rar)       unrar x "$1"    ;;
      *.7z)        7z x "$1"       ;;
      *)           echo "'$1' no se puede extraer mediante extract()" ;;
    esac
  else
    echo "'$1' no es un archivo válido"
  fi
}
# funcion para saber el stack tecnologico del directorio actual
wdstack() {
    if [ -f "package.json" ]; then
        echo "Node.js"
        cat package.json | grep '"dependencies"' -A 10
    elif [ -f "requirements.txt" ]; then
        echo "Python"
        cat requirements.txt
    elif [ -f "Gemfile" ]; then
        echo "Ruby"
        cat Gemfile
    elif [ -f "pom.xml" ]; then
        echo "Java"
        cat pom.xml | grep '<dependency>' -A 5
    elif [ -f "build.gradle" ]; then
        echo "Java (Gradle)"
        cat build.gradle | grep 'implementation' -A 5
    elif [ -f "Cargo.toml" ]; then
        echo "Rust"
        cat Cargo.toml | grep '\[dependencies\]' -A 10
    elif [ -f "go.mod" ]; then
        echo "Go"
        cat go.mod
    elif [ -f "composer.json" ]; then
        echo "PHP"
        cat composer.json | grep '"require"' -A 10
    elif [ -f "index.html" ] || [ -f "index.php" ]; then
        echo "Static HTML"
        ls *.css *.js
    elif [ -f "Dockerfile" ]; then
        echo "Docker"
        cat Dockerfile
    elif [ -f "Makefile" ]; then
        echo "Makefile detected"
        cat Makefile
    elif [ -f "CMakeLists.txt" ]; then
        echo "CMake detected"
        cat CMakeLists.txt
    elif [ -f "setup.py" ]; then
        echo "Python (setup.py)"
        cat setup.py
    else
        echo "No se pudo detectar el stack tecnológico del directorio actual"
    fi
}
# funcion para mostrar la ip publica
publicip() {
    curl ifconfig.me
    echo ""
}
# funcion para mostrar la ip privada
privateip() {
    ipconfig getifaddr en0
}
# funcion para mostrar ambas ips
myips() {
    echo "IP Privada: $(privateip)"
    echo "IP Pública: $(publicip)"
}
# funcion para reiniciar servicios
restartservice() {
    sudo systemctl restart "$1"
    if [ $? -eq 0 ]; then
        echo "Servicio $1 reiniciado correctamente."
    else
        echo "Error al reiniciar el servicio $1."
    fi
}
# funcion para ver el estado de un servicio
statusservice() {
    sudo systemctl status "$1"
}
