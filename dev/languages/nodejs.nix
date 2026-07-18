{ pkgs, ... }: {
  # Node.js 工具链 — home-manager 用户级配置

  home.packages = with pkgs; [
    nodejs
    bun
    pnpm
    yarn
  ];
}