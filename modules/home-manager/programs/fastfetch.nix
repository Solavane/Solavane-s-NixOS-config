{ ... }: {

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "NixOS_small";
        padding = {
          right = 1;
        };
      };
      display = {
        size = {
          binaryPrefix = "si";
        };
        color = "blue";
        separator = ": ";
        percent = {
          type = 9;
          color = {
            green = "green";
            yellow = "yellow";
            red = "red";
          };
        };
      };
      modules = [
        "title"
        "separator"
        {
          type = "datetime";
          key = "Date";
          format = "{1}-{2}-{11}";
        }
        {
          type = "datetime";
          key = "Time";
          format = "{14}:{17}:{20}";
        }
        "separator"
        {
          type = "kernel";
          key = "Kernel";
        }
        {
          type = "cpu";
          format = "{name} ({cores-physical}/{cores-logical}T) @ {freq-max}";
        }
        {
          type = "memory";
          key = "Memory";
          percent = {
            type = 3;
            green = 20;
            yellow = 70;
          };
        }
      ];
    };
  };
}
