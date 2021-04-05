# Configuración de Linux
Repositorio con los archivos de configuración con los programas que uso en Linux.
La mayoría de los commits con modificaciones a los archivos de neovim.

---

Actualmente usando KDE y pensando en migrar a BSPWM.

Neovim sigue estando configurado en vimscript por cuestiones de compatibilidad con versiones viejas, en algún momento migraré la configuración a Lua.

*Nota: Automatizar commits con cronie no es buena idea.*

## Programas instalados
- **Terminal:** [Alacritty](https://github.com/alacritty/alacritty)
- **Shell:** ZSH
- **Editor de texto / código / navaja suiza:** [Neovim](https://github.com/neovim/neovim)
- **Gestor de extensiones de vim:** [Vim-Plug](https://github.com/junegunn/vim-plug)

## Programas viejos usados
(por si quiero volver algún día)
- **Gestor de ventanas:** [SwayWM](https://github.com/swaywm/sway)
- **Gestor de notificaciones:** [Mako](https://github.com/emersion/mako)
- **Montado automático de discos:** [Udiskie](https://github.com/coldfix/udiskie)
- **Barra de estado:** [Waybar](https://github.com/Alexays/Waybar)
- **Control de audio:** Amixer
    - **Audio por PipeWire**
- **Control de reproducción multimedia:** Playerctl
- **Lanzador de aplicaciones:** [Rofi](https://github.com/davatorium/rofi)
- **Capturas de pantalla:** [Grim](https://github.com/emersion/grim) + [Slurp](https://github.com/emersion/slurp)
- **Gestor de extensiones para terminal:** [Oh My Zsh](https://ohmyz.sh/)
- **Gestor de archivos por terminal:** Ranger

## Estilos adicionales
- **Cursor:** Vimix white
- **Íconos:** Papirus
- **GTK3:** Juno ocean

## Por hacer
- [ ] Migrar la configuración de Neovim a Lua.
- [ ] Migrar de KDE a BSPWM.
- [ ] Script de configuración automática.
- [ ] Agregar trabajos de Cronie.
