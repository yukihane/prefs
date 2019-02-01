#!/bin/bash

set -eux

dir=$(dirname $BASH_SOURCE)

mvn install:install-file -Dfile=$dir/jconn4.jar -DgroupId=com.sybase \
 -DartifactId=jconnect -Dversion=16.0.b27403 -Dpackaging=jar
