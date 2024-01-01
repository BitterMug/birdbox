now=$(date +"%M_%H_%m_%d_%Y")
path='/opt/birdbox'
d=$(date)
start='<img src="img/bird-'
end='.png" alt="" width="600">'
pointer='\npointer'
file='archive.html'
minute=$(date +"%M");

if [ $minute -eq 0 ] | [ $minute -eq 20 ] | [ $minute -eq 40 ]; then
  sudo libcamera-still -o $path/img/bird-$now.png --rotation 180 --autofocus-window 0.4,0.5,0.6,0.8
  sudo sed -i "s|pointer|$start$now$end$pointer|g" $path/$file
else
  sudo libcamera-still -o $path/img/bird-current.png --rotation 180 --autofocus-window 0.4,0.5,0.6,0.8 --width 1600 --height 900
  sudo convert $path/img/bird-current.png -fill white -pointsize 40 -bordercolor black -gravity center -draw "text 400,400 '$d'" $path/img/bird-current.png
fi

aws s3 sync $path s3://bcview.cz --delete --cache-control max-age=60
