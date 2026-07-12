{ config, osConfig, lib, pkgs, ... }:

let
  cfg = config.nixconf.services.ollama;
in
{
  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
      loadModels = [
        "qwen3.5:9b"
        "llama3.1:8b"
        "gemma3:12b-it-qat"
      ];
    };
  };
}
