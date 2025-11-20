#
#
#
# ~/.zshrc
# Descripcion: Archivo de configuracion de ZSH personalizado de Javier
# Autor: Javier Rodríguez-Alarcón <javier@javierdz.dev>




ZSH_THEME="agnoster"


plugins=(git)

source $ZSH/oh-my-zsh.sh


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
alias update_omz="omz update"

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
