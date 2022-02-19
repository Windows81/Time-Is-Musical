#!/bin/bash
f=$(python .py $@)
echo $f
ffmpeg -discard nokey -dn -f lavfi -i "$f" -v error -stats -g 69 -pix_fmt yuv420p -x264-params keyint=69:min-keyint=69:scenecut=-1 -g 69 -b:a 128k -ar 44100 -acodec aac -vcodec libx264 -preset superfast -bufsize 960k -crf 28 -threads 2 -dn -f flv "rtmp://b.rtmp.youtube.com/live2/gvwr-wj12-3vcs-04uw-1vp7"
