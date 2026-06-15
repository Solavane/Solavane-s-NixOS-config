## Common nix patterns

```nix
# Make Option true/false Option
options.nixconf.*option* = lib.mkOption {
  type = lib.type.bool;
  default = false;
};

```
```nix
# Enables option from above
nixconf.*option* = true;
```
```nix
# Enables if option above is enabled
config = lib.mkIf config.nixconf.*option* {
  
};
```
```nix
# Simple Enable Option
options.nixconf.*option*.enable = lib.mkEnableOption "Description";
config = lib.mkIf config.nixconf.*option*.enable {
};
```
```nix
# Simple let-in Enable Option
let
  cfg = config.nixconf.*option*
in {
  config = lib.mkIf cfg.enable {
  
  };
}
```
```nix
# Multiple Enable Options
options = {
  nixconf.*option*.enable = lib.mkEnableOption "Description"
  nixconf...
};

config = lib.mkMerge [
  (lib.mkIf config.nixconf.*option*.enable {
  
  })
  (lib.mkIf...
  
  })
  
  #Always Active
  {
  
  }
];
```
```nix

```

