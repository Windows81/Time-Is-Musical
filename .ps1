$n=[DateTime]::Now.addseconds(14.5);
$c=@(
@('00',59),
@('01',1,10,24,28,37,40,48),
@('02',9,13,21,31,46,53,57),
@('03',14,18,23,29,56),
@('04',4,11,16,30,34,42,47,55),
@('05',7,17,20,33,38,58),
@('06',12,22,27,41,44,51),
@('07',2,6,15,36,43,52),
@('08',0,3,8,26,32,35,49)
,@('09',5,19,25,39,45,50,54));
$h=(0..23)|%{'{0:d2}'-f$_};
$m=(0..5);
$s=$n.hour*60*60+$n.minute*60+$n.second+$n.millisecond/1e3;
$mm=($m|%{"amovie=minute_$($_)0.wav,aloop=10:44100*60[mm$_];"})-join'';
$f="$mm$(($h|%{"amovie=hour_$($_).wav,aloop=60:44100*60[h$_];"})-join'')amovie=cycle_600s.wav,aloop=-1:44100*600[s600];amovie=cycle_60s.wav,aloop=-1:44100*60[s60];$(($c|%{"amovie=cycle_60s_$($_[0]).wav,asplit=$($_.length-1)$(($_[1..($_.length-1)]|%{"[c$_]"})-join'');"-f$2})-join'')$(($m|%{"[mm$_]"})-join'')concat=v=0:a=1:n=6,aloop=-1:44100*60*60[m];$(((0..59)|%{"[c$_]"})-join'')concat=v=0:a=1:n=60,aloop=-1:44100*60*60[hh];$(($h|%{"[h$_]"})-join'')concat=v=0:a=1:n=24[h];[hh][s60][m][h][s600]amix=inputs=5,volume=5,atrim=$s,asetpts=PTS-STARTPTS[out0];gradients=size=1280x720:x0=0:x1=1280:y0=0:y1=720,drawtext=text='%{pts\:localtime\:$s\:%H\\\:%M\\\:%S}':fontsize=69:font=consolas:box=1:boxborderw=10:x=(w-tw)/2:y=(h-lh)/2[out1]";
ffmpeg -re -f lavfi -i $f -v error -stats -g 48 -pix_fmt yuv420p -x264-params keyint=48:min-keyint=48:scenecut=-1 -b:a 128k -ar 44100 -acodec aac -vcodec libx264 -preset superfast -bufsize 960k -crf 28 -threads 2 -f flv "rtmp://b.rtmp.youtube.com/live2/gvwr-wj12-3vcs-04uw-1vp7"