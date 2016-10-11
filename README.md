# dng2mov
A simple perl scrip to convert BMPCC DNG and similar format raw videos to another format

This utility is designed to run on Linux with dcraw and ffmpeg, may also run under MacOSX or Windows with Cygwin

Recommend using ffmpeg prebuilt binaries from https://www.johnvansickle.com/ffmpeg/

The first couple of lines define variables which you can tune:

* $ext is what formats the script should look for, if you have a different raw format, see if dcraw can convert it properly

* $fr is for frame rate, there are examples that you may comment out

* $pix is for pixel sub sampling and bit depth, '10le' is for 10bit, '12le' is for 12bit

* $size is to resize the footage to a desired size, leave commented out to keep in native resolution

* $au defines how to handle audio compression

* $container for desired container format

* $sub for the temporary working sub-directory, works directly out of whatever sub folder the script is called from

The script will also look for a wav file in the directory with the raw frames, if there is no wav file then it will encode a silent video (in which case $au is ignored).


https://ffmpeg.org/

http://www.cybercom.net/~dcoffin/dcraw/
