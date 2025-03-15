# !/bin/bash

set -eu

# ~/.bashrc が存在するか確認
if [ -f ~/.bashrc ]; then
    # すでに ssh 関数が定義されていないか確認
    if ! grep -q "ssh() {" ~/.bashrc; then
        # ssh関数が未設定の場合に追加
        cat <<EOS >> ~/.bashrc
ssh() {
    echo -e "\033]11;#541215\007"  # 背景を暗赤色
    command ssh "\$@"
    echo -e "\033]11;#000000\007"  # SSH終了後に黒背景へ戻す
}
EOS
        echo "ssh関数を.bashrcに追加しました。"
    else
        echo "既に.bashrcにssh関数が設定されています。"
    fi
else
    echo "~/.bashrc ファイルが存在しません。"
fi
