#!/bin/bash

# https://github.com/mapstruct/mapstruct.org/issues/76
# LombokとMapStructを導入しているとEclipse pluginが正常に動作しない問題の対処

set -eux

lombok_ver=1.18.8

lombok_url=https://repo1.maven.org/maven2/org/projectlombok/lombok/${lombok_ver}/lombok-${lombok_ver}.jar
filename=original-${lombok_ver}.jar

if [ -e lombok ]; then
  rm -r lombok
fi
mkdir lombok

curl -L -o ${filename} ${lombok_url}
pushd lombok
jar xf ../${filename}

mkdir -p org/mapstruct/ap/spi
cp secondaryLoading.SCL.lombok/org/mapstruct/ap/spi/AstModifyingAnnotationProcessor.SCL.lombok org/mapstruct/ap/spi/AstModifyingAnnotationProcessor.class

jar cfm ../lombok.jar META-INF/MANIFEST.MF .
