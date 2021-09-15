#!/usr/bin/bash
# Test code with either Gradle or Maven

set -x
if [[ -f pom.xml ]]
then
    mvn test
else
    gradle test
fi
set +x