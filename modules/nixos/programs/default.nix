{ config, lib, pkgs, ... }:

let
  p = config.nixconf.programs;
in {

  environment.systemPackages = with pkgs;
       lib.optionals p.kitty.enable       [ kitty      ]
    ++ lib.optionals p.foot.enable        [ foot       ]
    ++ lib.optionals p.librewolf.enable   [ librewolf  ]
    ++ lib.optionals p.elinks.enable      [ elinks     ]
    ++ lib.optionals p.vesktop.enable     [ vesktop    ]
    ++ lib.optionals p.faugus.enable      [ faugus-launcher ];
}
