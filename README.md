# nix-config

我的 NixOS 配置

基于 **Nix Flakes** 的模块化 NixOS 配置，支持多主机、开发、学术写作与 AI 工具，完全声明式、可复现。

## 架构

```
~/nix-config/
├── flake.nix                 # 入口：定义输入与主机
├── .gitignore
├── base/                     # 系统地基
│   ├── default.nix           # 聚合 base 模块
│   ├── system.nix            # 内核、网络、时区、全局 Zsh + yazi 函数
│   ├── users.nix             # 用户、sudo、默认 shell
│   ├── packages.nix          # 系统级基础包（vim, git, yazi 等）
│   └── proxy.nix             # 代理开关（可选）
├── host-services/            # 宿主机服务
│   ├── ssh.nix
│   ├── cockpit.nix
│   └── samba.nix
├── dev/                      # 开发工具链
│   ├── default.nix
│   ├── languages/            # 编程语言
│   ├── containers/           # 容器引擎
│   └── remote/               # VS Code Server
├── writing/                  # 学术写作
│   ├── default.nix
│   ├── texlive.nix
│   ├── typst.nix
│   ├── pandoc.nix
│   └── zotero.nix
├── ai/                       # AI 助手
│   ├── default.nix
│   ├── claude-code.nix
│   └── cc-switch-cli.nix
├── home/                     # 用户环境 (Home Manager)
│   ├── default.nix
│   ├── shell.nix
│   ├── git.nix
│   ├── vim.nix
│   └── nixpkgs-config.nix
└── hosts/                    # 多主机定义
    ├── nixos/                # 当前主机
    │   ├── configuration.nix
    │   └── hardware-configuration.nix
    ├── server/               # 示例：未来服务器
    └── laptop/               # 示例：未来笔记本
```

## 快速开始

1. 克隆本仓库到 `~/nix-config`
2. 在新机器上生成硬件配置：
   ```bash
   sudo nixos-generate-config --show-hardware-config | sudo tee /etc/nixos/hardware-configuration.nix
   cp /etc/nixos/hardware-configuration.nix ~/nix-config/hosts/nixos/hardware-configuration.nix
   ```
3. 首次部署：
   ```bash
   sudo nixos-rebuild switch --flake ~/nix-config#nixos
   ```

## 日常命令

| 操作 | 命令 |
|------|------|
| 更新系统 | `cd ~/nix-config && nix flake update && sudo nixos-rebuild switch --flake .#nixos` |
| 清理旧版本 | `nix-collect-garbage -d` |
| 仅重建用户环境 | `home-manager switch --flake .#zizimiku` |

## 注意

- 硬件配置 (`hardware-configuration.nix`) 已纳入版本控制，换机时请重新生成。
- 代理模块通过 `base/default.nix` 中的 `./proxy.nix` 控制开关，注释即关闭。
- 所有模块增删规则见 **AI-GUIDE**。

# AI-GUIDE

AI 自动操作手册（供 AI 助手如 Claude Code 等使用）

## 核心规则

- 系统级软件包（需 root）放入 `base/packages.nix` 的 `environment.systemPackages` 列表，或按功能域新建文件（如 `dev/languages/xxx.nix`）。
- 系统服务放入 `host-services/`，一个服务一个文件。
- 用户级配置（Home Manager）放入 `home/`，一个应用一个文件。
- 通过各目录的 `default.nix` 聚合导入，或由主机 `configuration.nix` 直接导入。
- 每次文件修改后必须执行 `git add` 和 `git commit`，然后运行 `sudo nixos-rebuild switch --flake .#nixos`。
- 禁止直接修改 `/etc/nixos/configuration.nix`。

## 文件放置与编辑指南

- **系统基础工具**：直接编辑 `base/packages.nix`，在 `environment.systemPackages` 中添加包名。
- **开发语言**：创建 `dev/languages/语言名.nix`，内容形如 `{ pkgs, ... }: { environment.systemPackages = with pkgs; [ 包1 包2 ]; }`，然后在 `dev/default.nix` 的 `imports` 中加入 `./languages/语言名.nix`。
- **容器引擎**：类似，放在 `dev/containers/` 下。
- **写作工具**：创建 `writing/工具名.nix`，在 `writing/default.nix` 中导入。
- **AI 工具**：创建 `ai/工具名.nix`，在 `ai/default.nix` 中导入。
- **系统服务**：创建 `host-services/服务名.nix`，在对应主机 `hosts/nixos/configuration.nix` 的 `imports` 中添加 `../../host-services/服务名.nix`。
- **用户应用配置**：创建 `home/应用名.nix`，使用 Home Manager 选项（如 `programs.tmux.enable = true`），然后在 `home/default.nix` 的 `imports` 中添加 `./应用名.nix`。
- **删除软件**：在相应的 `default.nix` 中注释或移除对应导入行，可选删除源文件。

## AI 操作标准流程

1. 根据用户请求确定软件类型，选择正确的文件位置。
2. 创建或编辑对应的 `.nix` 文件。
3. 若需聚合，修改 `default.nix` 或主机 `configuration.nix`。
4. 执行以下命令：
   ```bash
   cd ~/nix-config
   git add .
   git commit -m "描述修改"
   sudo nixos-rebuild switch --flake .#nixos
   ```
5. 若构建失败，分析错误输出，必要时调整并重试，或将错误反馈给用户。

## 注意事项

- 任何新建文件必须用 `git add` 跟踪，否则构建会报错。
- 包名可用 `nix search nixpkgs <关键词>` 确认。
- 若某个包因网络问题下载失败，可临时在对应 `default.nix` 中注释掉导入，待网络恢复后再启用。
- 永远不要修改 `hardware-configuration.nix`（除非确知硬件变动
