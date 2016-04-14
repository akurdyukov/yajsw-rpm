#!/bin/bash

VERSION="11.11"
ITERATION="1"
DOWNLOAD="http://iweb.dl.sourceforge.net/project/yajsw/yajsw/yajsw-stable-11.11/yajsw-stable-$VERSION.zip"
if [ ! -f yajsw-stable-$VERSION.zip ]; then
	wget -O yajsw-stable-$VERSION.zip $DOWNLOAD
fi

unzip -q -o yajsw-stable-$VERSION.zip

rm -rf yajsw-stable-$VERSION/bat yajsw-stable-$VERSION/bin yajsw-stable-$VERSION/build \
	yajsw-stable-$VERSION/conf yajsw-stable-$VERSION/doc yajsw-stable-$VERSION/log \
	yajsw-stable-$VERSION/scripts yajsw-stable-$VERSION/src yajsw-stable-$VERSION/templates \
	yajsw-stable-$VERSION/tmp yajsw-stable-$VERSION/webapps

fpm -s dir -t rpm -C yajsw-stable-$VERSION --name yajsw --version $VERSION \
    --prefix /usr/share/java/yajsw -a noarch --rpm-os linux \
	--iteration $ITERATION --description "Yet Another Java Service Wrapper" .

curl -T yajsw-$VERSION-$ITERATION.noarch.rpm -uakurdyukov:$BINTRAY_API_KEY \
	https://api.bintray.com/content/akurdyukov/rpm/yajsw/$VERSION/yajsw-$VERSION-$ITERATION.noarch.rpm
