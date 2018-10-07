#!/bin/sh
echo "running ./pdfalto -readingOrder $FILE ./output/output.xml"
cd output && ../pdfalto -readingOrder $FILE ./output.xml
exit
