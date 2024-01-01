path='/opt/birdbox'
d=$(date)

sudo libcamera-still -o $path/img/bird-current.png --rotation 180 --autofocus-window 0.4,0.5,0.6,0.8 --width 1600 --height 900

sudo convert $path/img/bird-current.png -fill white -pointsize 40 -bordercolor black -gravity center -draw "text 400,400 '$d'" $path/img/bird-current.png

aws s3 sync $path s3://bcview.cz --delete --cache-control max-age=20
