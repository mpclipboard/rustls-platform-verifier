#!/usr/bin/env bash

set -euxo pipefail

./clean.sh

repo=https://github.com/stormshield-gt/rustls-platform-verifier.git
branch=use-CRL-by-default-instead-of-OCSP-on-android

git clone --depth 1 --branch $branch $repo tmp

pushd tmp/android
./gradlew assembleRelease
popd

artifact_name="rustls-platform-verifier-release.aar"
pushd tmp/android-release-support
artifact_path="../android/rustls-platform-verifier/build/outputs/aar/$artifact_name"
cp ./pom-template.xml ./maven/pom.xml
sed -i.bak "s/\$VERSION/0.6.0/" ./maven/pom.xml
rm ./maven/pom.xml.bak

mvn install:install-file -Dfile="$artifact_path" -Dpackaging="aar" -DpomFile="./maven/pom.xml" -DlocalRepositoryPath="$HOME/.m2/repository"

find ~/.m2/repository | grep rustls
