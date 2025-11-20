#
#
#
# ~/.zshrc
# Descripcion: Archivo de configuracion de ZSH personalizado de Javier
# Autor: Javier Rodríguez-Alarcón <javier@javierdz.dev>




ZSH_THEME="agnoster"


plugins=(git)

source ~/.oh-my-zsh/oh-my-zsh.sh


# =================[ CONFIG JAVIER ]==================

# ALIAS
alias ginit="git init"
alias gc="git commit -m '$1'"
alias gp="git push"
alias gf="git fetch && git pull"
alias ga="git add '$1'"
alias ls="ls -la"
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias reload="source ~/.zshrc"

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
        return "Node.js"
    elif [ -f "requirements.txt" ]; then
        echo "Python"
        return "Python"
        cat requirements.txt
    elif [ -f "Gemfile" ]; then
        echo "Ruby"
        return "Ruby"
        cat Gemfile
    elif [ -f "pom.xml" ]; then
        echo "Java"
        return "Java"
        cat pom.xml | grep '<dependency>' -A 5
    elif [ -f "build.gradle" ]; then
        echo "Java (Gradle)"
        return "Java (Gradle)"
        cat build.gradle | grep 'implementation' -A 5
    elif [ -f "Cargo.toml" ]; then
        echo "Rust"
        return "Rust"
        cat Cargo.toml | grep '\[dependencies\]' -A 10
    elif [ -f "go.mod" ]; then
        echo "Go"
        return "Go"
        cat go.mod
    elif [ -f "composer.json" ]; then
        echo "PHP"
        return "PHP"
        cat composer.json | grep '"require"' -A 10
    elif [ -f "index.html" ] || [ -f "index.php" ]; then
        echo "Static HTML"
        return "Static HTML"
        ls *.html *.htm *.php
        ls *.css *.js
    elif [ -f "Dockerfile" ]; then
        echo "Docker"
        return "Docker"
        cat Dockerfile
    elif [ -f "Makefile" ]; then
        echo "Makefiles"
        return "Makefiles"
        cat Makefile
    elif [ -f "CMakeLists.txt" ]; then
        echo "CMake"
        return "CMake"
        cat CMakeLists.txt
    elif [ -f "setup.py" ]; then
        echo "Python (setup.py)"
        return "Python (setup.py)"
        cat setup.py
    elif ls *.sh 1> /dev/null 2>&1; then
        echo "Shell Script"
        return "Shell Script"
        ls *.sh
    else
        echo "No se pudo detectar el stack tecnológico del directorio actual"
        return ""
    fi
}
# funcion para mostrar la ip publica
publicip() {
    curl ifconfig.me
    echo ""
}
# funcion para mostrar la ip privada
privateip() {
    ifconfig getifaddr en0
}
# funcion para mostrar ambas ips
myips() {
    echo "IP Privada: $(privateip)"
    echo "IP publica: $(publicip)"
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

release() {
    lsb_release -a
}
# funcion para actualizar este .zshrc desde el repositorio
update_zshrc() {
    if [ ! -d "~/linux-essentials" ]; then
        echo "El directorio ~/linux-essentials no existe. Clonando el repositorio..."
        git clone https://github.com/jaavierdz/linux-essentials.git ~/linux-essentials
    fi
    cd ~/linux-essentials || return
    git pull origin main
    cp ~/.zshrc ~/.zshrc.bak
    cp .zshrc ~/.zshrc
    source ~/.zshrc
    echo ".zshrc actualizado desde el repositorio."
}

# PROMPT personalizado (versión mejorada)
setopt PROMPT_SUBST

# Muestra la rama y el estado de Git (✓ = limpio, * = cambios)
git_prompt() {
    local branch state
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
    if [ -n "$branch" ]; then
        if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
            state="*"
        else
            state="✓"
        fi
        echo "%F{magenta}(${branch}${state})%f"
    fi
}

# Muestra el código de salida del último comando si es distinto de 0
exit_status_prompt() {
    local es=$?
    if [ $es -ne 0 ]; then
        echo "%F{red}[!$es]%f "
    fi
}

# Prompt principal (izquierda) y prompt derecho con hora
# - Usuario@host en cyan
# - Ruta en amarillo
# - Código de salida (si != 0) y estado de git
export PROMPT='%F{cyan}%n@%m%f %F{yellow}%~%f $(exit_status_prompt) $(git_prompt)%f %B%F{blue}%#%f%b '
export RPROMPT='%F{green}%*%f'