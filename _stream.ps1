while ($true) {
	ffmpeg -discard nokey -dn -re -r 4 -f lavfi -t 900 -i (python .py 41) -v error -stats -ar 44100 -acodec aac -vcodec libx264 -preset superfast -bufsize 666k -crf 41 -threads 2 -dn -b:v 192k -b:a 192k -f flv "rtmp://b.rtmp.youtube.com/live2/jcmk-zhef-7ekc-z9sq-7fp5"
}
