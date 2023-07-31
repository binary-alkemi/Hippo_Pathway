#!/bin/bash

mv ./quinoline.mp4 old_movie.mp4

/usr/bin/ffmpeg -an -i ./frames/frames.%05d.ppm -vcodec mpeg4 -an -qscale 0 ./quinoline.mp4

#rm -rf movie
