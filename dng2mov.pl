#!/usr/bin/perl -w
use Cwd qw();
use File::Basename;
$ext = "*.dng *.DNG *.ari *.ARI";
$delete = 1;

#frame rate
$fr = "23.976";
#$fr = "24";
#$fr = "25";
#$fr = "29.97";
#$fr = "30";
#$fr = "59.94";
#$fr = "60";

#pix_fmt
#$pix = "yuv420p";
#$pix = "yuv422p";
#$pix = "yuv422p10le";
$pix = "yuv422p12le";
#$pix = "yuv444p10le";
#$pix = "yuv444p12le";

#resize
#$size = "-s 1920x1080";

#audio
$au = "-c:a aac -b:a 128k";
#$au = "-acodec pcm_s16le -ar 48000 -ac 2";
#$au = "-c:a pcm_s24le -ar 48000 -ac 2";

#video
$vi = "-c:v libx265 -preset medium -x265-params crf=16";
#$vi = "-vcodec prores -profile:v 3";
#$vi = "-c:v jpeg2000 -q:v 3";

$container = "mp4";
#$container = "mov";
#$container = "mkv";
#$container = "mxf";

$sub = "dng-tiff-tmp";

$path = Cwd::cwd();
$clipname = basename(Cwd::cwd());

if (glob("*.wav")) {
	$name = glob("*.wav");
	$ai = "-i '$name'";
} else {
	$au = "-c:a none";
	$ai = "";
}

if ($ARGV[0]) { $path = $ARGV[0]; }
chdir($path);
unless(-d $path."/".$sub){
	mkdir "$path/$sub";
}

$ct = 0;
@files = glob($ext);
foreach $file (@files) {
	my ($fileType) = $file =~ /\.(.*?)$/;
	$newname = sprintf("%6d", $ct);
	$newname=~ tr/ /0/;
	print "creating $newname.tiff \n";
	print `dcraw -6 -T -c "$file" > $sub/$newname.tiff`;
	$ct++;
}

print `ffmpeg -thread_queue_size 512 -i $sub/%06d.tiff $ai -r:v $fr $size $au -pix_fmt $pix $vi -r $fr '$clipname.$container'`;
if ($delete) {
	`rm $sub/*.tiff`;
	`rmdir $sub`;
}
