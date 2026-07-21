{ ... }: {
  imports = [
    ./ssh.nix
#    ./cockpit.nix
    ./samba.nix
    ./proxy.nix
    ./firewall.nix
  ];
}
