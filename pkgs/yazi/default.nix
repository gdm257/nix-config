{ lib, stdenv, fetchzip, unzip }:

stdenv.mkDerivation rec {
  pname = "yazi";
  version = "25.5.31";

  # 平台特定的下载映射
  src = fetchzip {
    url = {
      x86_64-linux = "https://github.com/sxyazi/yazi/releases/download/v${version}/yazi-x86_64-unknown-linux-gnu.zip";
      aarch64-linux = "https://github.com/sxyazi/yazi/releases/download/v${version}/yazi-aarch64-unknown-linux-gnu.zip";
      x86_64-darwin = "https://github.com/sxyazi/yazi/releases/download/v${version}/yazi-x86_64-apple-darwin.zip";
      aarch64-darwin = "https://github.com/sxyazi/yazi/releases/download/v${version}/yazi-aarch64-apple-darwin.zip";
    }.${stdenv.hostPlatform.system} or (throw "Unsupported platform: ${stdenv.hostPlatform.system}");

    sha256 = {
      x86_64-linux = "eyw27/5uQJ1rGRunM+Z5dW3Cc20UdyGUfWhAdtV16/w=";
      aarch64-linux = "1zpqx3fycfdlkznx9k7hllvij0rxpn2kdyprwm3pldf1ch7rbj14";
      x86_64-darwin = "0fw19yjnql556hq0sah0lsb7gpsv3azjq93ncicpfj4i4xs4vbra";
      aarch64-darwin = "0w7x5dfm387nqvhf47xjb82x31j8isvg4vw6vpwi3kc4ixz17pwb";
    }.${stdenv.hostPlatform.system};

    stripRoot = false;  # ZIP 文件包含版本号目录
  };

  nativeBuildInputs = [ unzip ];

  # 安装阶段
  installPhase = ''
    runHook preInstall

    # 创建安装目录
    mkdir -p $out/bin
    mkdir -p $out/share/yazi

    # 查找并安装主程序（在版本号目录中）
    YAZI_DIR=$(find . -maxdepth 1 -type d -name "*yazi*" | head -n 1)
    if [ -z "$YAZI_DIR" ]; then
      YAZI_DIR="."
    fi

    # 安装主程序
    if [ -f "$YAZI_DIR/yazi" ]; then
      cp "$YAZI_DIR/yazi" $out/bin/
      chmod +x $out/bin/yazi
    fi

    # 安装 ya (可选的 CLI 工具)
    if [ -f "$YAZI_DIR/ya" ]; then
      cp "$YAZI_DIR/ya" $out/bin/
      chmod +x $out/bin/ya
    fi

    # 复制其他必要文件
    if [ -d "$YAZI_DIR/plugins" ]; then
      cp -r "$YAZI_DIR/plugins" $out/share/yazi/
    fi
    if [ -d "$YAZI_DIR/presets" ]; then
      cp -r "$YAZI_DIR/presets" $out/share/yazi/
    fi

    runHook postInstall
  '';

  # 元数据
  meta = with lib; {
    description = "Blazing fast terminal file manager written in Rust, based on async I/O";
    homepage = "https://github.com/sxyazi/yazi";
    changelog = "https://github.com/sxyazi/yazi/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "yazi";
    platforms = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}