#!/bin/sh

###EDIT HERE###
openurl='/usr/bin/purebrowser.real'
opentext='/usr/bin/cat'
openimage='/usr/bin/gwenview'
openvideo='/usr/bin/mpv'
###STOP EDITING###

cd $(dirname $(readlink -f $0))
cd ..
rm sbin/open-url 2>/dev/null
ln -s $openurl sbin/open-url
rm sbin/open-text 2>/dev/null
ln -s $opentext sbin/open-text
rm sbin/open-image 2>/dev/null
ln -s $openimage sbin/open-image
rm sbin/open-video 2>/dev/null
ln -s $openvideo sbin/open-video
PATH=$(pwd)/sbin:$PATH
[ -e dev ] || ln -s sys dev
rm -r proc 2>/dev/null
ln -s dev proc
[ -x proc/init ] && proc/init


echo -n "$ "
while read cmd params ; do
    if [ -x bin/$cmd ] ; then
        bin/$cmd $params
    elif [ $root ] && [ -x sbin/$cmd ] ; then
        sbin/$cmd $params
    else
        cmd-not-found $cmd $params
    fi
    echo -n "$ "
done

rm -r proc 2>/dev/null
