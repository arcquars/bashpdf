#!/bin/bash
function formatSize
{
 	IFS=' ' read -r -a array <<< "$1"
	echo "${array[4]%.*}"
}
RESULT=$(pdfinfo $1 | grep 'Page size')
SIZE=$(formatSize "$RESULT")
if [[ SIZE -ge 801 && SIZE -le 900 ]]; then
gs -o outputA3.pdf -sDEVICE=pdfwrite -sPAPERSIZE=a4 -dFIXEDMEDIA -dPDFFitPage -dCompatibilityLevel=1.4 -c "<</BeginPage{1.0 0.9 scale -45 65 translate}>> setpagedevice" -f $1 && pdftk template-no-perder.pdf stamp outputA3.pdf output output.pdf
elif [[ SIZE -ge 901 && SIZE -le 1000 ]]; then
gs -o outputA3.pdf -sDEVICE=pdfwrite -sPAPERSIZE=a4 -dFIXEDMEDIA -dPDFFitPage -dCompatibilityLevel=1.4 -c "<</BeginPage{1.0 0.9 scale -15 65 translate}>> setpagedevice" -f $1 && pdftk template-no-perder.pdf stamp outputA3.pdf output output.pdf
else
gs -o outputA3.pdf -sDEVICE=pdfwrite -sPAPERSIZE=a4 -dFIXEDMEDIA -dPDFFitPage -dCompatibilityLevel=1.4 -c "<</BeginPage{1.0 0.9 scale 0 65 translate}>> setpagedevice" -f $1 && pdftk template-no-perder.pdf stamp outputA3.pdf output output.pdf
fi
echo ${LEFTDOC}
#SUBSTRING="479 x 841"
