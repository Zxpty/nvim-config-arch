# Estructura de la Configuración de Neovim

Esta configuración está organizada en carpetas para facilitar la personalización.

## 📁 Estructura de Carpetas

```
lua/
├── core/              # Configuraciones principales de Neovim
│   ├── options.lua    # Opciones de Vim (números relativos, tabs, etc.)
│   ├── mappings.lua   # Atajos de teclado personalizados
│   ├── autocmds.lua   # Autocomandos de Neovim
│   ├── cpp.lua        # Configuración específica para C++ (F8, F9, F10)
│   └── python.lua     # Configuración específica para Python (F8, F9)
│
├── ui/                # Configuraciones de interfaz y apariencia
│   ├── theme.lua      # 🎨 CAMBIA EL TEMA AQUÍ
│   ├── statusline.lua # Configuración de la barra de estado
│   ├── dashboard.lua  # Configuración del dashboard de inicio
│   └── telescope.lua  # Configuración de Telescope (buscador)
│
├── plugins/           # Definición de plugins
│   └── init.lua       # Lista de todos los plugins instalados
│
├── configs/           # Configuraciones de plugins específicos
│   ├── conform.lua    # Formateo de código (solo Lua)
│   ├── lspconfig.lua  # Configuración de LSP (solo Lua, C++ y Python usan CoC)
│   ├── coc.lua        # 🔤 CoC.nvim - Autocompletado para C++ y Python
│   └── lazy.lua       # Configuración del gestor de plugins
│
├── coc-settings.json  # ⚙️ Configuración de CoC (clangd para C++, pylsp para Python)
│
└── snippets/          # Snippets personalizados
    └── cpp.lua        # Snippets para C++

chadrc.lua             # Archivo principal de NvChad (importa configuraciones de ui/)
init.lua               # Archivo de entrada principal
```

## 🎨 Cómo Cambiar el Tema

1. Abre el archivo: `lua/ui/theme.lua`
2. Cambia la línea `theme = "nord"` por el tema que quieras
3. Temas populares disponibles:
   - `nord`
   - `catppuccin`
   - `tokyonight`
   - `dracula`
   - `gruvbox`
   - `onedark`
   - Y muchos más en: https://github.com/NvChad/base46/tree/v2.5/lua/base46/themes

## 🔧 Otras Personalizaciones Comunes

### Cambiar la Barra de Estado
- Archivo: `lua/ui/statusline.lua`
- Cambia `theme` o `separator_style`

### Cambiar el Dashboard
- Archivo: `lua/ui/dashboard.lua`
- Modifica el `header` (ASCII art) o `load_on_startup`

### Agregar Atajos de Teclado
- Archivo: `lua/core/mappings.lua`
- Agrega tus keymaps personalizados aquí

### Cambiar Opciones de Vim
- Archivo: `lua/core/options.lua`
- Modifica opciones como números relativos, tabs, etc.

### Agregar Plugins
- Archivo: `lua/plugins/init.lua`
- Agrega nuevos plugins en la lista

### Configurar LSP
- Archivo: `lua/configs/lspconfig.lua`
- Agrega o modifica servidores de lenguaje

### Agregar Snippets
- Archivo: `lua/snippets/cpp.lua` (para C++)
- Crea `lua/snippets/python.lua` si necesitas snippets para Python

### Configuración de C++ y Python
- **C++**: Configurado en `lua/core/cpp.lua` (F8: test, F9: compilar, F10: ejecutar)
- **Python**: Configurado en `lua/core/python.lua` (F8: test, F9: ejecutar)
- **Autocompletado**: Ambos usan CoC.nvim (configurado en `coc-settings.json`)

### Configurar Autocompletado (CoC.nvim)
- Archivo: `coc-settings.json` - Configuración principal de CoC
- Archivo: `lua/configs/coc.lua` - Keymaps y configuración de CoC
- El autocompletado funciona automáticamente cuando escribes (como en tu setup anterior)
- CoC maneja:
  - **LSP**: Completado inteligente del servidor de lenguaje (clangd para C++)
  - **Snippets**: Snippets con UltiSnips
  - **Diagnósticos**: Errores y advertencias en tiempo real

## ⌨️ Atajos de Autocompletado (CoC)

- **Tab**: Seleccionar siguiente sugerencia o expandir snippet
- **Shift+Tab**: Seleccionar sugerencia anterior
- **Enter**: Confirmar y aceptar sugerencia
- **K**: Mostrar documentación del símbolo bajo el cursor
- **gd**: Ir a definición
- **gr**: Ver referencias
- **<leader>rn**: Renombrar símbolo
- **<leader>a**: Acciones de código

## 📝 Notas

- Todos los archivos están organizados por función
- Los comentarios en cada archivo explican qué hace
- La estructura es modular: puedes modificar una parte sin afectar las demás
