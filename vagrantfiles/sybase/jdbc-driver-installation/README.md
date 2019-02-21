# これは何？

https://maven.apache.org/guides/mini/guide-3rd-party-jars-local.html
を参考に、MavenローカルリポジトリにSybase jConnectorをインストールするスクリプトです。

# インストール

    ./mvn-install-jconnector.sh

# 使用方法

`pom.xml` の `dependencies` に追記します:

    <dependency>
      <groupId>com.sybase</groupId>
      <artifactId>jconnect</artifactId>
      <version>16.0.b27403</version>
      <scope>runtime</scope>
    </dependency>

