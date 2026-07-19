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
│   ├── system.nix            # 内核、网络、时区、Nix 配置
│   ├── users.nix             # 用户、sudo、默认 shell
│   ├── packages.nix          # 系统级基础包（含监控工具）
│   └── nix-ld.nix            # nix-ld 兼容层（运行预编译二进制）
├── network/                  # 网络相关（防火墙、代理、服务）
│   ├── default.nix
│   ├── ssh.nix               # OpenSSH
│   ├── cockpit.nix           # Cockpit Web 管理面板
│   ├── samba.nix             # Samba 文件共享
│   ├── proxy.nix             # 全局代理 + nix-daemon 代理
│   └── firewall.nix          # 手动防火墙规则（端口放行）
├── dev/                      # 开发工具链
│   ├── default.nix
│   ├── languages/            # 语言工具链
│   │   ├── default.nix
│   │   ├── c-cpp.nix         # GCC / Clang / CMake / GDB
│   │   ├── python.nix        # Python / pip / uv / pipx
│   │   ├── rust.nix          # cargo / rustc / rust-analyzer
│   │   ├── nodejs.nix        # Node.js / bun / pnpm / yarn（home-manager）
│   │   ├── go.nix            # Go / gopls
│   │   └── java.nix          # JDK 21 / Maven / Gradle
│   ├── containers/           # 容器引擎
│   │   ├── default.nix
│   │   ├── podman.nix        # Podman + lazyjournal + podman-compose
│   │   └── docker.nix        # Docker + docker-compose + lazydocker
│   └── editors/              # 代码编辑器
│       ├── default.nix
│       └── vscode.nix         # VS Code
├── writing/                  # 学术写作
│   └── default.nix           # pandoc / typst / texliveFull / zotero
├── ai/                       # AI 助手
│   ├── default.nix
│   ├── claude-code.nix
│   └── cc-switch-cli.nix
├── home/                     # 用户环境 (Home Manager) — 唯一配置来源
│   ├── default.nix
│   ├── shell.nix             # zsh + oh-my-zsh + 别名 + y() + 代理变量
│   ├── git.nix               # git 用户配置
│   ├── vim.nix               # vim 全部配置 + 自动 symlink 给 root
│   ├── yazi.nix              # yazi 全部配置 + 自动 symlink 给 root
│   └── nixpkgs-config.nix
└── hosts/                    # 多主机定义
    ├── nixos/                # 当前主机
    │   ├── configuration.nix
    │   └── hardware-configuration.nix
    ├── server/               # 未来服务器
    └── laptop/               # 未来笔记本
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

| 操作           | 命令                                                                               |
| -------------- | ---------------------------------------------------------------------------------- |
| 更新系统       | `cd ~/nix-config && nix flake update && sudo nixos-rebuild switch --flake .#nixos` |
| 清理旧版本     | `nix-collect-garbage -d`                                                           |
| 仅重建用户环境 | `home-manager switch --flake .#zizimiku`                                           |

## 设计原则

- **`home/` 是唯一配置来源**——所有应用配置（vim、yazi、zsh、git）都在 `home/`，不在 `base/` 重复。
- **`base/` 只管系统和包**——内核、网络、用户、系统级包，不含用户配置内容。
- **其他用户通过 systemd oneshot 共享**——root 等用户的配置由 `systemd.services.link-root-configs` 自动 `ln -sf` 到 zizimiku 的配置目录。
- 一个功能域内的软件包尽量放在同一个文件里，不做"一个包一个文件"的过细拆分。

## 配置检查

**每次新增软件包或写新配置前，必须先确认包名/选项名存在且可用。**

### 1. 搜索包名

```bash
nix search nixpkgs <关键词>
```

能搜到 = 包存在，直接用。搜不到说明包名不对或不在 nixpkgs 里。

### 2. 搜索 NixOS 选项

```bash
man nixos-options 2>/dev/null || nixos-option 2>/dev/null
```

或者直接查 nixpkgs 源码里的 options 定义，确认选项名不是废弃/重命名的。

### 3. 构建检查（commit 前必须通过）

```bash
nix build --no-link --impure '.#nixosConfigurations.nixos.config.system.build.toplevel'
```

- `--no-link` — 不创建 `/nix/store` 软链接，纯检查用
- `--impure` — 允许读取 flake 源码外的文件（如 token 文件）
- **输出 `error:` → 配置有问题，修复后再 commit**
- **无输出或只输出 `/nix/store/...` 路径 → 检查通过 ✅**

> 三步走：搜包 → 写配置 → build 检查，把问题挡在 commit 和部署之前。

## 注意

- 硬件配置 (`hardware-configuration.nix`) 已纳入版本控制，换机时请重新生成。
- 代理模块通过 `network/default.nix` 中的 `./proxy.nix` 控制开关，注释即关闭。
- 所有模块增删规则见 **AI-GUIDE**。

# AI-GUIDE

AI 自动操作手册（供 AI 助手如 Claude Code 等使用）

## 核心规则

- **`home/` 是唯一配置来源**——所有应用的用户配置（vim、yazi、zsh、git）都在 `home/`，不在 `base/` 重复。
- 系统级软件包放入 `base/packages.nix`，或按功能域收拢到 `dev/`、`writing/`、`ai/` 的 `default.nix`。
- 系统服务及防火墙规则放入 `network/`，一个服务一个文件。
- 通过各目录的 `default.nix` 聚合导入。
- 每次文件修改后必须执行 `git add` 和 `git commit`，然后运行 `sudo nixos-rebuild switch --flake .#nixos`。
- 禁止直接修改 `/etc/nixos/configuration.nix`。

## 文件放置与编辑指南

- **系统基础工具**：直接编辑 `base/packages.nix`，在 `environment.systemPackages` 中添加包名。
- **开发语言**：优先收拢到 `dev/languages/default.nix`，直接往 `environment.systemPackages` 追加包名即可。只有配置复杂（如多个版本、自定义环境）时才拆分单独文件。
- **容器引擎**：优先收拢到 `dev/containers/default.nix`，把 Docker、Podman、lazydocker 一起放在同一个模块里管理。
- **写作工具**：优先直接放进 `writing/default.nix`，只有真正有独立配置逻辑时才拆单文件。
- **AI 工具**：优先直接放进 `ai/default.nix`，只有真正有独立逻辑时才拆单文件。
- **系统服务/防火墙**：创建 `network/服务名.nix`，在对应主机 `hosts/nixos/configuration.nix` 的 `imports` 中添加 `../../network/服务名.nix`。纯防火墙端口放行用 `networking.firewall.allowedTCPPorts`。
- **用户应用配置**：创建 `home/应用名.nix`，使用 Home Manager 选项（如 `programs.tmux.enable = true`），然后在 `home/default.nix` 的 `imports` 中添加 `./应用名.nix`。
- **删除软件**：在相应的 `default.nix` 中注释或移除对应导入行，可选删除源文件。

## AI 操作标准流程

1. 根据用户请求确定软件类型，选择正确的文件位置。
2. **搜索确认包名/选项可用**（必须在写配置之前）：
    ```bash
    nix search nixpkgs <关键词>
    ```
3. 创建或编辑对应的 `.nix` 文件。
4. 若需聚合，修改 `default.nix` 或主机 `configuration.nix`。
5. **运行构建检查**（必须通过才能继续）：
    ```bash
    nix build --no-link --impure '.#nixosConfigurations.nixos.config.system.build.toplevel'
    ```
6. 执行以下命令：
    ```bash
    cd ~/nix-config
    git add .
    git commit -m "描述修改"
    sudo nixos-rebuild switch --impure --flake .#nixos
    ```
7. 若构建失败，分析错误输出，必要时调整并重试，或将错误反馈给用户。

## 注意事项

- 任何新建文件必须用 `git add` 跟踪，否则构建会报错。
- 包名可用 `nix search nixpkgs <关键词>` 确认。
- 若某个包因网络问题下载失败，可临时在对应 `default.nix` 中注释掉导入，待网络恢复后再启用。
- 永远不要修改 `hardware-configuration.nix`（除非确知硬件变动
