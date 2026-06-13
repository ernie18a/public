#!/bin/bash
mkdir -p /g/.public/TMP/cache
set -e

# 確保在專案目錄下執行
cd "$(dirname "$0")"

# 將工具鏈與快取完全限制在當前專案資料夾的 TMP/ 目錄中，絕對不超出目前所在地 (/g/app/geph5/)
export RUSTUP_HOME="$(pwd)/TMP/.rustup"
export CARGO_HOME="$(pwd)/TMP/.cargo"
export PATH="$CARGO_HOME/bin:$PATH"

# 檢查本地或當前 PATH 是否有大於等於 1.85.0 的 cargo
NEEDS_INSTALL=false
if ! command -v cargo &> /dev/null; then
    NEEDS_INSTALL=true
else
    # 取得當前的次要版本號 (例如 1.75.0 中的 75)
    RUST_MINOR_VER=$(cargo --version | cut -d' ' -f2 | cut -d'.' -f2)
    if [ "$RUST_MINOR_VER" -lt 85 ]; then
        NEEDS_INSTALL=true
    fi
fi

if [ "$NEEDS_INSTALL" = true ]; then
    echo "當前 Cargo 版本過低，無法支援 Rust 2024 Edition。"
    echo "正在安裝獨立 Rust 工具鏈至專案本地的 ./TMP/ （不影響作業系統，亦不超出本專案目錄）..."
    
    mkdir -p ./TMP
    
    # 下載 rustup-init
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o ./TMP/rustup-init.sh
    
    # 執行安裝：
    # -y: 自動確認
    # --no-modify-path: 絕對不修改 ~/.bashrc 等任何使用者環境設定檔
    # --default-toolchain stable: 安裝最新的 stable 版本
    sh ./TMP/rustup-init.sh -y --no-modify-path --default-toolchain stable
    
    # 清理安裝腳本
    rm ./TMP/rustup-init.sh
    echo "本地 Rust 工具鏈安裝成功！"
fi

# 建立快取目錄
mkdir -p ./TMP/cache

echo "正在使用本地 ./TMP/ 下的 Rust 工具鏈編譯並啟動 geph5-client..."
exec cargo run --release -p geph5-client -- --config client_config.yaml
