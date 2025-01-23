{
  inputs = {
  	nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { self, nixpkgs, nixos-wsl, ... } @inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # 将input向下传递
        specialArgs = {
          inherit inputs;
        };

        modules = [
          ./configuration.nix
          nixos-wsl.nixosModules.wsl
        ];
      };
    };
  };
}
