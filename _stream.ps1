ffmpeg -discard nokey -dn -re -r 4 -f lavfi -i (python .py $args) -v error -stats -pix_fmt yuv420p -x264-params keyint=666:min-keyint=666:scenecut=-1 -g 666 -b:a 192k -ar 44100 -acodec aac -vcodec libx264 -preset superfast -bufsize 666k -crf 28 -threads 2 -dn -f flv "rtmp://b.rtmp.youtube.com/live2/jcmk-zhef-7ekc-z9sq-7fp5"
