{ config, lib, pkgs, ... }:

let
  cfg = config.nixconf.hosting.minecraft-servers.fjomp;
in
{
  config = lib.mkIf cfg.enable {

    services.minecraft-servers.servers.fjomp = {
      enable = true;
      openFirewall = true;

      package = pkgs.fabricServers.fabric-26_2.override {
        loaderVersion = "0.19.3";
        jre_headless = pkgs.jdk25_headless;
      };
      whitelist = { #doxing my MC acc lmao
        Solavane  = "12c603b6-d15c-4ae9-8357-6a1dc630d5d1";
        pjupp44   = "51a00d51-2001-49b1-8ea4-12c505ad1ac7";
      };
      serverProperties = {
        server-port = 43029;
        difficulty = 3;
        gamemode = 0;
        max-players = 3;
        white-list = true;
        allow-cheats = false;
        level-name = "fjomp";
      };
      jvmOpts = "-XX:+UnlockExperimentalVMOptions -Xms2G -Xmx4G -Djava.net.preferIPv4Stack=true -XX:+UseZGC -XX:+AlwaysPreTouch -XX:+UseStringDeduplication -XX:+UseCompactObjectHeaders";

      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {

            # Modlist
            Fabric-API = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/Kr4WG5mG/fabric-api-0.154.2%2B26.2.jar";
              sha512 = "sha512-fO2thi6BBafejbCQwHB8JaFKlHJlQJCGHc9JD4NIYsMhJyPnYvb3l6DkaDEE9LOiDTaS+ynXtcCvQ3YTKD002w==";
            };
            C2ME = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/VSNURh3q/versions/ZrrJuWws/c2me-fabric-mc26.2-0.4.2-alpha.0.18.jar";
              sha512 = "sha512-m3K0QVDAjeqQpKHri8j/inhZonK+4YXf6uX+/WmsK7C2ObIbz4X/pWJetC91n3REDoYcxwmn1Q+zWIJnVZNW6A==";
            };
            Lithium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/UPNexAfy/lithium-fabric-0.25.2%2Bmc26.2.jar";
              sha512 = "sha512-22djdsBbfpEs2uWq2eUfElrcFVSuKyBFmcy1mHUZIa7brJjpe5y6AzO2tSSIxrdckVp9vVBDb5eAA4f+Gq0cUA==";
            };
            ScalableLux = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/EKLUURiy/ScalableLux-fabric-0.3.0-alpha.0.3-all.jar";
              sha512 = "sha512-6hVRyHKKcm9u6C/tMECvUnkZQ++Z9rY0KO13B5f2BnfgFgl1rVmtD1G81KTsK12jnGkTqyN58uJdI5cTLUaalA==";
            };
            Krypton = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/5WeL0Nkz/krypton-0.3.1.jar";
              sha512 = "sha512-uNmvNM0AUEk6+4piMsuPeF2qnYiHtwRfbmpTxrubX/xDGP2bA0epQOrP66R3PxDLgK4L4eec5MGIj5btoh5WTg==";
            };
            FerriteCore = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/uXXizFIs/versions/d5ddUdiB/ferritecore-9.0.0-fabric.jar";
              sha512 = "sha512-2B+pfhF4TBnUL4nC9DODHQB2A91xk87kX6F35KapxSs4SxmFhuBKD39jzZlv7XEzIleL3pqNtX4RiIVK5cvlhA==";
            };
            SeeU = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/coyNPDey/versions/gyNWLCPb/seeu-fabric-0.7.2.jar";
              sha512 = "sha512-c6lTKXWx0fegWkdz9eaOBrkCyT8q5FgU4REX2CUgaw4i+dL/G2cGglbR7+MnUGzBBsWZQnjAUEvv6vJAHy/JzA==";
            };
            ServerCore = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/4WWQxlQP/versions/edrtnY9v/servercore-fabric-1.5.19%2B26.2.jar";
              sha512 = "sha512-qkz8k/jgIXKRAwJEQzDjdxPfzyBH0o5V63Mjo81dUUkzdKCVmqPmJuwr9D/HB6dVUIuDRUuzS21X1lwGmSkHSw==";
            };
            Chunky = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/fALzjamp/versions/4Eotm6ov/Chunky-Fabric-1.5.3.jar";
              sha512 = "sha512-uDv+eyGNCqYjKvl3rnQdwfgrEOUM0Su3WfZc9Ba4tivsy1Q+WH7wuWcKvgOBVmD44JG8aCNiTWXPBzAFcVc1Fg==";
            };
            #VoxyServer = pkgs.fetchurl {
            #  url = "https://cdn.modrinth.com/data/fNtGd1cx/versions/UXvMg0cW/VoxyServer-1.2.3.jar";
            #  sha512 = "sha512-5FCGn5kfDSTGbGEBHS7fyddPuGVK9ekLazgPBC+LSQTrZPV015UUeBNrQHZSlEjDn+0tvT/DA0Ha9kAU+5mHmw==";
            #};
          }
        );
      };
    };
  };
}
