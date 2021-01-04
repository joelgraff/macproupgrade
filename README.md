# macproupgrade
A collection of files and wiki for updating firmware on a MacPro 1,1 and installing alternative operating systems

Clone the repo for the files.

# Updating the firmware

There are two things which are required:  The firmware itself, which is available in this repo as well as Apple's support site for the time being, and the upgrade tool, also included in this repo.  Copy them to the Mac Pro desktop for convenience.  Extract the Upgrade Tool zip to the desktop.  See the (Links) for links to the firmware from Apple's website and other useful resources.

## The "B00" Firmware Upgrade

Note that there are two versions of the upgrade tool.  There is a firmware revision for the Mac Pro 1,1 that does not work with the orignal tool.  Specifically, MP11.005D.B00 requires the modified version.  The firmware version can be determined using Apple Icon -> About This Mac -> More Info -> System Report.  Near the bottom of the report, the firmware revision will be listed.  Firmware ending in "B00" requires the version named "Mac Pro 2006-2007 Firmware Tool (005D-B00).zip"

The B00 firmware revision appended a date code (not shown in the About This Mac -> System Report view) which would cause the original upgrade tool to fail.  Thus, the tool had to be modified to recognize that date code.  Thus far, only two date codes have been identified:  *0709141354* and *0708280936*.

It is likely most B00 firmware revisions use one of these two date codes.  There may be more out there, however.  Modifying the tool to include a new date code is possible with a hex editor, but determining the actual date code may be challenging.  Previously a tool called [GeekBench](https://geekbench.com) was used to identify the date code.  However, older versions of the software which support OSX Lion no longer work as they require a server connection that has been shut down.  At this time, no other information has been found to determine the date code for a B00 firmware on a gen 1,1 Mac Pro.

## Mount the firmware image

Simply open the firmware DMG file to mount the image.  Run the package if desired.  The application will post a notification stating the update is not necessary for this machine.

## Run the Upgrade Tool

Open the upgrade tool.  The tool shold post error 5530 with no further information.  This occurs as the tool tries to download needed files for the upgrade from a server which no longer exists.  Close the dialog.  Note that a "RAM Disk" is now mounted on the desktop.

## Populate the RAM Disk

Open the RAM Disk.  Then, right-click on the Upgrade Tool and select "Show Contents".  In the window, click on "Contents" then "Resources".  Several files will be visible.  Select and drag five files from the Upgrade Tool to the RAM Disk: 

- ExtractAndPatchEFIFiles.sh
- UpgradeEFI2006-2007.sh
- DowngradeEFI2007-2006.sh
- MacProEFIUpdater2006.patch
- MacProEFIUpdater2007.patch

## Modify the extract script

### Note:  It may not be necessary to modify the script in all cases.  ###

Right click on *ExtractAndPatchEFIFiles.sh* and edit it with a text editor.  In the file, four lines need to be removed:

- hdiutil attach -nobrowse MacProEFI2006and2007.dmg
- rm -R Expanded
- rm -R System
- rm Payload

Save the changes and close the window.

## Run the modified script.

In the terminal window, type a period.  Then, select the ExtractAndPatchEFIFiles.sh script from the RAM Disk window and drag it into the terminal window.  The path to the file will be inserted in the terminal after the period.  Press ENTER.  The script should run, setting up the necessary files.

## Run the Upgrade script.

In the temrinal window, type "sudo ." (no quotes).  Then, drag and drop the *UpgradeEFI2006-2007.sh* script from the RAM Disk to the terminal window and press ENTER.

## Upgrade the firmware

Shut down the computer.  Turn it on, holding the power button until the light above it starts to flash rapidly.  The Mac Pro will emit a long system beep followed by the typical Apple startup sound.  Eventually, the screen will go gray with the Apple logo, and a progress bar should appear, as the firmware is upgraded. Once compelte, the computer will reboot automatically to the desktop.  If the screen flashes and immediately reboots, the upgrade failed.

## Check the firmware version

Uner Apple Icon -> About This Mac -> More Info -> System Report, the reported firmware version should be MP21.007F.B06.

# Installing Ubuntu

This process can undoubtedly be used for other Linux distributions.  Installation requires a surrogate computer to start.

## Create a Live install

Download an ISO of Ubuntu and create a Live CD / USB.  Install the blank HDD / SSD in the surrogate computer, or in an enclosure.  Boot the computer from the live media to install Ubuntu and install normally.

NOTE:  The Ubuntu install must be in EFI mode for this to work.  If, when booting the live media, a purple screen appears with a white symbols at the bottom (a keyboard, an arrow, and a stick figure in a circle), the install is booting in BIOS mode.

## Boot the New Install

Run the new installation off the internal disk on the surrogate computer.  Do whatever setup may be necessary.

## Install rEFInd

Navigate to the rEFInd project page (see links below).  Download a copy - Ubuntu installs can use the .deb binary.  Install rEFInd.

## Boot the Mac Pro

If rEFInd installs without error, install the disk in the MacPro and turn it on.  It should boot normally into Ubuntu.

## Final Notes

There are other approaches to installing Ubuntu on the early Mac Pro systems which do not require rEFInd.  These approaches, however, require modifing the live install media and work less reliably with USB than they do DVD's.  In the case of the Mac Pro 1,1 with the B00 firmware revision, this may be eespecially difficult.  Nevertheless, these approaches do eliminate the dependency on rEFInd.

# Links

## Firmware

Video detailing the process of the firmware upgrade described in this README:
https://www.youtube.com/watch?v=1Z6FEd8j5Jo

Original netkas thread with the Upgrade Tool.  Link is to page 13, which includes the modified tool for the B00 firmware:
http://forum.netkas.org/index.php/topic,1094.180.html

MacRumors forum thread detailing modifying the tool to install firmware upgrade:
https://forums.macrumors.com/threads/mac-pro-1-1-firmware-upgrade-issues.2174741/

Apple Support page for Mac Pro firmware:
https://download.info.apple.com/Mac_OS_X/061-3943.20070927.pO93v/MacProFirmwareUpdate1.2.dmg

## Ubuntu Installation

rEFInd project page (downloads):
http://www.rodsbooks.com/refind/getting.html

rEFInd project page (installation):
http://www.rodsbooks.com/refind/installing.html

## Installing Ubuntu without rEFInd

http://blog.sergem.net/boot-ubuntu-18-04-1-live-usb-on-macpro-11/#comment-467

https://mattgadient.com/linux-dvd-images-and-how-to-for-32-bit-efi-macs-late-2006-models/

## Known Issues

How To Get Around 5530 Error while upgrade Mac Pro 1,1 EFI To 2,1 - New Procedure

https://www.youtube.com/watch?v=1Z6FEd8j5Jo




