{ ... }: {
  imports = [
    ./ssh.nix
    ./cockpit.nix
    ./samba.nix
  ];
}