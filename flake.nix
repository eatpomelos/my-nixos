{
  description = "Spikely NixOS flake";

  # Inputs
  inputs = {
  	 nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
     # wezterm.url = "github:wez/wezterm?dir=nix";

	home-manager = {
		url = "github:nix-community/home-manager/release-24.11";

		inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { nixpkgs, home-manager, ...} @inputs: let
    userName = "spikely";
    in {
	nixosConfigurations = {
		nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
      # 将input向下传递
      specialArgs = {
        inherit inputs;
      };

			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages= true;
					home-manager.users.${userName}= import ./home/default.nix;
          home-manager.backupFileExtension = "hm.bak";

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
          home-manager.extraSpecialArgs = {
            inherit inputs userName;
          };
				}
			];
		};
	};
  };

}
