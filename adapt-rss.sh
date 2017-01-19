#!/bin/bash -xe

mkdir -p public/feeds
for i in public/tags/*/*.xml; do cp $i $(echo $i|sed -e s@public/tags@public/feeds@ -e s@/rss.xml@.tag.rss.xml@); done
for i in public/categories/*/*.xml; do cp $i $(echo $i|sed -e s@public/categories@public/feeds@ -e s@/rss.xml@.cat.rss.xml@); done


