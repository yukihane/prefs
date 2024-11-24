ホームネットワークのゲートウェイサーバーとして購入した [N100](https://www.amazon.co.jp/gp/product/B0C6T2T4JH/) のセットアップメモです。
Ubuntu Serverと、必要なソフトウェアをセットアップします。

## Windowsライセンス紐づけ

将来使うかどうかわかりませんが、デフォルトでインストールされているライセンスのバックアップする目的で、一旦WindowsにログインしてMicrosoftアカウントを紐づけしました。

## Ubuntu インストール

Ubuntu 24.04.1 LTS のサーバーバージョンをインストールすることにしました。

- https://ubuntu.com/download/server

インストール時のオプションとしては、サードパーティソフトウェアのインストールをONにしてDockerをインストールしたのと、OpenSSHを有効にしました。

ここまでは N100 にキーボード&マウス、ディスプレイを接続していましたが、Ubuntuインストールが完了したらそれらは外し、リモートログインして作業することにしました。

ネットワークもWiFiなので、本体につながっているのは電源ケーブルだけです。

## 環境整備

### zsh

これまで同様 zprezto を使います。

- https://github.com/sorin-ionescu/prezto
- https://github.com/yukihane/prefs/tree/main/zsh

(`pbcopy` としてalias設定しているコマンドは使えなさそうなので外して良いかも)

### gh

- https://github.com/cli/cli/blob/trunk/docs/install_linux.md

GitHubにSSH鍵を登録するのに便利かと思ったけど、 `gh auth login` で登録するとどのPCの鍵かわからなくなるのでやめた(手動で作り直した)。

### git 

- https://git-scm.com/downloads/linux

### VPN server

ググるとOpenVPN or SoftEather VPNという感じでしたが、公式にドキュメントが存在している、という点でOpenVPNを選択しました。

- https://documentation.ubuntu.com/server/how-to/security/install-openvpn/

