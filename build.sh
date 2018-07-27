  #!/bin/bash

GRAALVMDIR=/opt/jvm/graalvm-ee
PROJECT_DIR="`dirname \"$0\"`"
LIBPATH=$PROJECT_DIR/clibraries/linux-amd64

cd $PROJECT_DIR
mvn clean package
rm vertx-graal*
echo "LIB PATH:" $LIBPATH
$GRAALVMDIR/bin/native-image \
 --verbose \
 --no-server \
 --static \
 -H:+JNI \
 -H:JNIConfigurationFiles=./graalvm/jni-netty.json \
 -Djava.library.path=$LIBPATH \
 -Dio.netty.native.workdir=$LIBPATH \
 -H:CLibraryPath=$LIBPATH \
 -H:+ReportUnsupportedElementsAtRuntime \
 -Dfile.encoding=UTF-8 \
 -jar target/vertx-graalvm-native-image-test-0.0.1-SNAPSHOT.jar
