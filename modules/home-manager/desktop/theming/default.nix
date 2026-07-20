{ pkgs, lib, config, osConfig, ... }:
let
  enabled = osConfig.nixconf.system.desktop.shell.enable;
  wallpaperDir = ../../../../assets/wallpapers;

  setWallpaper = pkgs.writeShellApplication {
    name = "set-wallpaper";
    runtimeInputs = [ pkgs.awww ];
    text = ''
      if [ $# -ne 1 ]; then
        echo "usage: set-wallpaper <path-to-image>" >&2
        exit 1
      fi

      img="$1"
      state_dir="$HOME/.local/state/theme"
      mkdir -p "$state_dir"

      awww img "$img" \
        --transition-type random \
        --transition-duration 1 \
        --transition-fps 60 \
        --filter Nearest

      echo "$img" > "$state_dir/wallpaper"

      matugen image "$img" \
        --prefer less-saturation
    '';
  };
  wallpaperMenu = pkgs.writeShellApplication {
    name = "wallpaper-menu";
    runtimeInputs = [ pkgs.rofi setWallpaper pkgs.findutils pkgs.coreutils ];
    text = ''
      wallpaper_dir="${wallpaperDir}"

      choice=$(find -L "$wallpaper_dir" -maxdepth 1 -type f \
      \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.gif' -o -iname '*.webp' \) \
      -printf '%f\000icon\037%p\n' | sort | rofi -dmenu \
      -p "Wallpaper" \
      -show-icons \
      -theme-str '
        window { width: 80%; }
        mainbox { children: [ listview ]; }
        listview { lines: 1; columns: 6; flow: horizontal; spacing: 2px; }
        element { orientation: vertical; children: [ element-icon ]; padding: 2px; }
        element-icon { size: 240px; horizontal-align: 0.5; expand: false; }
        scrollbar { enabled: false; }
      ')

      [ -z "$choice" ] && exit 0

      set-wallpaper "$wallpaper_dir/$choice"
    '';
  };

in
{
  config = lib.mkIf enabled {

    home.packages = [
      pkgs.awww
      pkgs.matugen
      setWallpaper
      wallpaperMenu
    ];

    home.activation.themeState = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "$HOME/.local/state/theme"
      $DRY_RUN_CMD touch $VERBOSE_ARG "$HOME/.config/foot/theme.ini"
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "$HOME/.config/gtk-3.0"
      $DRY_RUN_CMD touch $VERBOSE_ARG "$HOME/.config/gtk-3.0/colors.css"
    '';

    gtk = {
      enable = true;
      gtk3.extraCss = ''
        @import url("file://${config.home.homeDirectory}/.config/gtk-3.0/colors.css");
      '';
      gtk4.extraCss = ''
        @import url("file://${config.home.homeDirectory}/.config/gtk-4.0/colors.css");
      '';
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };
  };
}
