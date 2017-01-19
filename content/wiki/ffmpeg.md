+++
title = "ffmpeg tips and tricks"
lang = "en"
date = "2015-07-05T17:00:20"
+++

Getting info of a video

    ffprobe video.avi

Audio: from 5.1 to stereo

    ffmpeg -i video.avi -ac 2 out.avi

Video: xvid

    ffmpeg -i video.avi -c:v libxvid output.avi

Quality

    ffmpeg -i video.avi -q:vscale 7 -q:ascale 7 output.avi
