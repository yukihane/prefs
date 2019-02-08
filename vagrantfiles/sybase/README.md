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

`/etc/profile` に追記するようにしています。

    source /opt/sap/SYBASE.sh

## [サーバが正常に動作しているか確認する](https://help.sap.com/viewer/244b731a316a4de0ad1dd618937b0f8e/16.0.0.0/en-US/a6ebdcc0bc2b1014a0f0fad105f10ae9.html)

    $SYBASE/$SYBASE_ASE/install/showserver

[実際にログインしてみる](https://help.sap.com/viewer/244b731a316a4de0ad1dd618937b0f8e/16.0.0.0/en-US/a6ec23cabc2b1014a8f3bd71e198083f.html):

    isql -Usa -PSybase123 -SSYBASE


(Transact-)SQL実行:

    selet @@version
    go

## [起動する](https://help.sap.com/viewer/5343aa754dca495fb95f39ef101d5398/16.0.0.0/en-US/a7015cbcbc2b1014a900d75f844d261e.html)

    sudo -i $SYBASE/$SYBASE_ASE/install/RUN_SYBASE &

## [終了する](https://help.sap.com/viewer/5343aa754dca495fb95f39ef101d5398/16.0.0.0/en-US/a7031e19bc2b10148574acf2e6c010a6.html)

    isql -Usa -PSybase123 -SSYBASE

でログインした後

    > shutdown
    > go

## Hostから接続する

[デフォルトの`interfaces`ファイル](./interfaces)で

    master tcp ether 10.0.2.1 5000

としていますが、 `10.0.2.1` をguestに割り当てられたIPアドレスに書き換えた後、Sybaseを再起動します(前述の終了処理と起動処理を実行します)。

guestのIPアドレスは、guestにログインしている状態で `ip addr`コマンドで確認できます。

(VirtualBox設定で、IPアドレス割り当てを固定化することができたと思いますので、それを設定するとより良いかもしれません。)

## その他

DDLは[このへん](https://help.sap.com/viewer/4c45f8d627434bb19e10dd0abbb757b0/16.0.0.0/en-US/ab04bcd2bc2b101497868a1a54944a99.html)にマニュアルが。

### デフォルトcharsetをsjisにする

マニュアルではUTF8に変換する例があるので、 `utf8` を `sjis` に読みかえれば良い。

* [Example: Converting a Unicode Database to UTF-8](http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc31654.1600/doc/html/san1360629218880.html)

テーブルが空の状態であれば `bcp` は必要ないので次のような手順になる。
設定変更してshutdown。

    charset -Usa -P binary.srt sjis
    isql -Usa -P
    sp_configure 'default sortorder id', 50, 'sjis'
    go
    shutdown
    go

起動させる

    sudo -i $SYBASE/$SYBASE_ASE/install/RUN_SYBASE

と設定が有効化され終了するので、再度起動。

    sudo -i $SYBASE/$SYBASE_ASE/install/RUN_SYBASE &

以上。

また、関連する情報は `master..syscharsets` に保存されているようだ。

* [Error 5824: Cannot reconfigure server to use sort order ID %d, because the row for its underlying character set (ID %d) does not exist in syscharsets.](http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.dc00729.1500/html/errMessageAdvRes/BGBBDCDB.htm)
