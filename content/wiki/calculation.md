+++
title = "Math in bash"
lang = "en"
date = "2013-12-17T18:23:33"
+++

the simple way

    echo $((2+2))

the complex way

    echo 2+2|bc -lq

get a random number

    echo $(($RANDOM%10))
