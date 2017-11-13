#!/bin/bash
function formatSize
{
	IFS=' ' read -r -a array <<< "$1"
	echo "${array[2]%.*} ${array[3]} ${array[4]%.*}"
}
RESULT=$(pdfinfo $1 | grep 'Page size')
SIZE=$(formatSize "$RESULT")
SUBSTRING="479 x 841"
#echo $SIZE
if [[ "$SIZE" == *"$SUBSTRING"* ]]; then
	exec gs -o outputA3.pdf -sDEVICE=pdfwrite -sPAPERSIZE=a3 -dFIXEDMEDIA -dPDFFitPage -dCompatibilityLevel=1.4 -c "<</BeginPage{1.0 0.88 scale 0 65 translate}>> setpagedevice" -f $1
	echo "true"
else
	echo "false"
fi
