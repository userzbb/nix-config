{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    jdk21       # 默认 JDK（LTS）
    maven
    gradle
  ];
}