{ config, lib, osConfig, ... }:
#let
#  hw = osConfig.nixconf.desktop.mango
#
#lib.mkIf (osConfig.nixconf.desktop.mango.enable) {
#  
#  xdg.configFile."mango/mango.conf".text = 
let
  enabled = osConfig.nixconf.desktop.mango.enable;
  monitors = lib.concatMapStrings (m: "monitorrule=${m}\n") osConfig.nixconf.desktop.mango.monitors;
in
{
  config = lib.mkIf enabled {
    
    xdg.configFile."mango/config.conf".text = ''

      
      # Keyboard
      repeat_rate=50
      repeat_delay=250
      xkb_rules_layout=se

      # Mouse
      mouse_accel_profile = 0
      mouse_accel_speed = -1

      # Trackpad
      trackpad_accel_profile = 2
      trackpad_accel_speed = 0.7

      # System
      #syncobj_enable = 1
      drag_tile_to_tile = 1
      drag_corner = 4
      no_border_when_single = 0
      no_radius_when_single = 0

      # Startup
      exec-once=dms run
      #exec-once=awww-daemon

      # Rule
      windowrule = isfloating:1, isnoborder:1, isunglobal:1, height:800, width:400, offsetx:-120, title:^StreamingChatOverlay$

      tagrule = layout_name:dwindle

      # Theme
      borderpx = 0
      gappih = 0
      gappiv = 0
      gappoh = 0
      gappov = 0

      focused_opacity = 1
      unfocused_opacity = 0.95

      blur = 1
      blur_params_radius = 3

      # Animations
      animation_type_open = zoom
      animation_type_close = zoom

      animation_fade_in=1
      animation_fade_out=1
      fadein_begin_opacity=0.5
      fadeout_begin_opacity=0.5

      # Layouts
      dwindle_smart_split = 0
      dwindle_hsplit = 0
      dwindle_vsplit = 0
      dwindle_smart_resize = 0

      # Sub config load
      source=./binds.conf
      source=./env.conf
      source=./monitors.conf
    '';

    xdg.configFile."mango/binds.conf".text = ''
      # Mango
      bind=SUPER,r,reload_config
      bind=SUPER,m,quit
      bind=SUPER,q,killclient,
      bind=SUPER,Space,togglefloating,
      bind=SUPER,f,togglemaximizescreen,0
      bind=SUPER+ctrl,f,togglefullscreen,
      bind=SUPER+shift,f,togglefakefullscreen,
      bind=SUPER,s,toggle_scratchpad
      bind=SUPER+alt,Up,incgaps,+2
      bind=SUPER+alt,Down,incgaps,-2

      bind=Super,1,view,1
      bind=Super,2,view,2
      bind=Super,3,view,3
      bind=Super,4,view,4
      bind=Super,5,view,5
      bind=Super,6,view,6
      bind=Super,7,view,7
      bind=Super,8,view,8
      bind=Super,9,view,9

      bind=ctrl+Super,1,tag,1
      bind=ctrl+Super,2,tag,2
      bind=ctrl+Super,3,tag,3
      bind=ctrl+Super,4,tag,4
      bind=ctrl+Super,5,tag,5
      bind=ctrl+Super,6,tag,6
      bind=ctrl+Super,7,tag,7
      bind=ctrl+Super,8,tag,8
      bind=ctrl+Super,9,tag,9
      
      # switch window focus
      bind=SUPER,Tab,focusstack,next
      bind=SUPER,Left,focusdir,left
      bind=SUPER,Right,focusdir,right
      bind=SUPER,Up,focusdir,up
      bind=SUPER,Down,focusdir,down
     
      # resize window
      bind=SUPER+CTRL,Up,resizewin,+0,-50
      bind=SUPER+CTRL,Down,resizewin,+0,+50
      bind=SUPER+CTRL,Left,resizewin,-50,+0
      bind=SUPER+CTRL,Right,resizewin,+50,+0
      
      # switch layout
      bind=CTRL+SUPER,i,setlayout,dwindle
      bind=CTRL+SUPER,l,setlayout,scroller
      bind=SUPER,n,switch_layout

      # Mouse Bindings 
      mousebind=SUPER,btn_left,moveresize,curmove
      mousebind=SUPER,btn_right,moveresize,curresize
      mousebind=SUPER+CTRL,btn_right,killclient
      mousebind=SUPER+CTRL,btn_middle,togglefullscreen
      mousebind=SUPER,btn_middle,togglemaximizescreen,0

      # DMS
      bind=SUPER,d,spawn,dms ipc launcher toggle
      bind=SUPER,v,spawn,dms ipc clipboard toggle

      # Custom app bind
      bind=SUPER,Return,spawn,foot
      bind=SUPER,b,spawn,librewolf
      bind=SUPER+CTRL,b,spawn,foot elinks
      bind=SUPER+SHIFT,d,spawn,vesktop
    '';

    xdg.configFile."mango/env.conf".text = ''
      
    '';

    xdg.configFile."mango/monitors.conf".text = monitors;

  };
}
