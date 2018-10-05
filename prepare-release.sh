#!/bin/bash
set -Eeuxo pipefail

VERSION=$1

SRC_PATH=$(go env GOPATH)/src/git.proxeus.com/core/central/artifacts/dapp/

NAME_DARWIN=darwin-amd64/Proxeus.app.zip
NAME_LINUX=linux-amd64/Proxeus
NAME_WINDOWS=windows-amd64/Proxeus.exe

REL_PREFIX=./releases/${VERSION}/

mkdir -p ${REL_PREFIX}darwin-amd64/
mkdir -p ${REL_PREFIX}linux-amd64/
mkdir -p ${REL_PREFIX}windows-amd64/

cp ${SRC_PATH}${NAME_DARWIN} ${REL_PREFIX}${NAME_DARWIN}
cp ${SRC_PATH}${NAME_LINUX} ${REL_PREFIX}${NAME_LINUX}
cp ${SRC_PATH}${NAME_WINDOWS} ${REL_PREFIX}${NAME_WINDOWS}

URL_PREFIX=_/releases/

echo "{
	\"version\": \"$VERSION\"
	\"darwin\": \"${URL_PREFIX}${NAME_DARWIN}\"
	\"linux\": \"${URL_PREFIX}${NAME_LINUX}\"
	\"windows\": \"${URL_PREFIX}${NAME_WINDOWS}\"
}" > ./versions_v1

git add ./releases
git add versions_v1
git commit -m "publish release "$VERSION

echo "type this to release:"
echo "git push origin HEAD"