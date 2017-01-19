+++
title = "Burtning audio CD's"
lang = "en"
date = "2014-12-24T16:27:14"
+++

Here is the procedure to burn an audio cd under Linux.



First step: install cdrtools and mpg123:

```bash
cave resolve -x cdrtools mpg123
```

Go to a temp directory && copy there music you want to burn:

```bash
cd $(mktemp -d) && cp /home/foobar/music/cd05/*.mp3 .
```

Convert the files into WAV, using mpg123.

```bash
for i in *.mp3; do mpg123 -w "$(basename "$i" .mp3).wav" "$i"; done
```

Find the right bus ID:

```bash
cdrecord -scanbus
```

In my case, I get:

    ... snip ...
    scsibus3:
    3,0,0 300) 'HL-DT-ST' 'DVD+-RW GSA-T11N' 'A103' Removable CD-ROM
    ... snip ...

Important part is 3,0,0. Be sure it is your CD/DVD burner.

And, start burning (replace 3,0,0 by your bus id!!!):

```bash
cdrecord dev=3,0,0 -eject speed=48 -pad -audio *.wav
```

Eventually, delete tmpdir:

```bash
tmp_dir="$PWD"
cd .. && rm $tmp_dir/*.{wav,mp3} && rmdir $tmp_dir
```
