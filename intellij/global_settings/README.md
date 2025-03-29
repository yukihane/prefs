# IntelliJ 設定をバージョン管理し、複数環境で共有する

- refs. [IDE settings backup and sync > Export your settings manually](https://www.jetbrains.com/help/idea/sharing-your-ide-settings.html#import-export-settings)

## keymap

### import 方法

exportしたファイルはzipなので、それを展開したものをバージョン管理しています。
importする際はzipにしてから

```sh
zip -r settings.zip *
```

IntelliJ のアクション "Import Sttings..." でimportできます。

### export 方法

IntelliJ のアクション "Export Sttings..." で "**Keymaps(schemes)**" をexportし、展開したものをコミットします。
