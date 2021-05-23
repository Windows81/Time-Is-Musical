#!/bin/bash
f=$(python .py $@)
echo $f
ffmpeg -re -f lavfi -i "$f" -v error -stats -g 48 -pix_fmt yuv420p -x264-params keyint=48:min-keyint=48:scenecut=-1 -b:a 128k -ar 44100 -acodec aac -vcodec libx264 -preset superfast -bufsize 960k -crf 28 -threads 2 -f flv "rtmp://b.rtmp.youtube.com/live2/gvwr-wj12-3vcs-04uw-1vp7"
