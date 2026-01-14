
# linux-essentials

Breve colección de utilidades y ejemplos para tareas comunes en entornos Linux.

**Resumen**: este repositorio agrupa scripts y herramientas pequeñas (por ejemplo `diskutil` y `gitinit`) pensadas para automatizar tareas frecuentes y servir como material didáctico sobre comandos y buenas prácticas en Linux.

**Estructura del repositorio**
- `diskutil` : utilidad relacionada con operaciones sobre discos (mount, unmount, formateo, etc.).
- `gitinit`  : script para inicializar proyectos con configuración Git recomendada.
- `README.md`: este archivo.

**Requisitos**
- Un sistema tipo Unix (Linux, WSL, macOS). Algunos scripts pueden funcionar en PowerShell con adaptaciones.
- `bash` y utilidades GNU básicas (`coreutils`, `sed`, `awk`).
- `git` (para `gitinit`).

**Instalación rápida**
1. Clona el repositorio:

```bash
git clone https://github.com/jaavierdz/linux-essentials.git
cd linux-essentials
```

2. Haz ejecutables los scripts (si aplica):

```bash
chmod +x diskutil gitinit
```

Nota para usuarios de PowerShell en Windows: si usas WSL puedes ejecutar los scripts ahí; en PowerShell nativo puede que necesites adaptar la sintaxis o usar los comandos equivalentes.

**Uso (ejemplos)**
- `diskutil` (ejemplo genérico):

```bash
./diskutil --help
# o: ./diskutil mount /dev/sdb1
```

- `gitinit` (inicializar nuevo proyecto):

```bash
./gitinit mi-proyecto
# crea repositorio, añade .gitignore y hace el primer commit
```

Si algún script requiere parámetros específicos, ejecuta `--help` o abre el script para ver la documentación interna.

**Contribuir**
- Abre un issue si quieres proponer mejoras o reportar errores.
- Envía pull requests con cambios claros y pruebas cuando proceda.
- Sigue el estilo del proyecto y añade documentación para cualquier nueva utilidad.

**Licencia**
Por defecto no se incluye una licencia. Si deseas que el proyecto sea reutilizable públicamente, añade un archivo `LICENSE` (por ejemplo MIT) o dime qué prefieres y lo añado.

**Contacto**
- Autor: `jaavierdz` (GitHub). Abre issues en el repositorio para preguntas o propuestas.

---


