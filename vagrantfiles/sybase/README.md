# これは何？

個人で専有できるSybase ASEデータベース環境を作りたかったので
[Express Edition](http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc10083.1540/doc/html/wil1317747719948.html)インストールを自動化したVagrantfileです。

# オフィシャルリソース

* [Sybase ASE Express Editionダウンロード](https://www.sap.com/cmp/syb/crm-xu15-int-asexprdm/index.html)
* [インストールマニュアル](https://help.sap.com/viewer/244b731a316a4de0ad1dd618937b0f8e/16.0.0.0/en-US/a6e667adbc2b101494d092f8b04012ba.html)

# `vagrant up` 実行まで

## ファイル説明

### Vagrantfile

* centos/7
* メモリを1GBに設定しています。これ以下だと満足に動作しないと思います。必要に応じて大きくしてください。
* guest:5000 を host:5000 にポートフォワーディングしています。5000はSybaseが使用するデフォルトポートです。

### response.txt

Sybaseのインストール条件を設定するファイルです。

* Aybaseのtarを展開して得られる `sample_response.txt` を編集したものです。
* 変更点はgitの履歴を見てください。
* パスワード設定は `SY_CFG_ASE_PASSWORD`、その他一般的なものは `SY_CFG_ASE_` から始まるものだと思います。
* Express Editionをインストールするための `SYBASE_PRODUCT_LICENSE_TYPE=express` は変更必須だと思います。

## 実行手順

30分くらいはかかります。

1. 冒頭リンクよりSybaseのtar-ball(`ASE_Suite.linuxamd64.tgz`)を取得し`Vagrantfile`と同じディレクトリに配置します。
1. 必要に応じてパラメータを編集します。
1. `vagrant up`コマンドを実行します。

デフォルトのままインストールした場合:

* インストール場所: `/opt/sap`
* `sa`ユーザパスワード: `Sybase123`

# 利用方法

マニュアルの[Postinstallation Tasks](https://help.sap.com/viewer/244b731a316a4de0ad1dd618937b0f8e/16.0.0.0/en-US/a6e8dcfbbc2b1014a59bceaf9d7f47ce.html)あたりの内容です。

## [環境変数設定](https://help.sap.com/viewer/244b731a316a4de0ad1dd618937b0f8e/16.0.0.0/en-US/a6ebdcc0bc2b1014a0f0fad105f10ae9.html)

bashの場合は次のコマンドです。 `~/.bash_profile`などに追記しておきましょう。

    source /opt/sap/SYBASE.sh

## [サーバが正常に動作しているか確認する](https://help.sap.com/viewer/244b731a316a4de0ad1dd618937b0f8e/16.0.0.0/en-US/a6ebdcc0bc2b1014a0f0fad105f10ae9.html)

    $SYBASE/$SYBASE_ASE/install/showserver

[実際にログインしてみる](https://help.sap.com/viewer/244b731a316a4de0ad1dd618937b0f8e/16.0.0.0/en-US/a6ec23cabc2b1014a8f3bd71e198083f.html):

    isql -Usa -PSybase123 -SSYBASE

ちなみに`vagrant`ではデフォルトでホスト(ssh接続元)のLANG設定がゲスト(ssh接続先)へ連携されるようですが、これが原因でSybaseが日本語リソース持ってない旨のエラーを吐きました。`~/.bash_profile`に

    export LANG=C

などと書いておくことで対処します。

(Transact-)SQL実行:

    selet @@version
    go

DDLは[このへん](https://help.sap.com/viewer/4c45f8d627434bb19e10dd0abbb757b0/16.0.0.0/en-US/ab04bcd2bc2b101497868a1a54944a99.html)にマニュアルが有る。
