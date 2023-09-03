#!/usr/bin/env bash
EAF="/Volumes/RamDisk/ExtractAndPatchEFIFiles.sh"
printf "Fixing %s file...\n" "$EAF"
sleep 1
sed \
-e "s&hdiutil attach&#hdiutil attach&" \
-e "s&rm -R Expanded&#rm -R Expanded&" \
-e "s&rm -R System&#rm -R System&" \
-e "s&rm Payload&#rm Payload&" \
"$EAF" > "$EAF.sed"
rm "$EAF"
mv "$EAF.sed" "$EAF"
printf "Done.\n"
