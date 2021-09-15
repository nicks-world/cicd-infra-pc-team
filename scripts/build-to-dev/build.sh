#!/usr/bin/bash
# Build from source with either Gradle or Maven

set -x
if [[ -f pom.xml ]]
then
    mvn -DskipTests --batch-mode clean package
else
    gradle build -x test
fi
set +x