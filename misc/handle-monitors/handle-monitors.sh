export DISPLAY=:0

function connect() {
    if [ $1 = 'DP-2' ] || [ $1 = 'DP-1' ]
    then
        xrandr --output $1 --off
        xrandr --output $1 --left-of eDP-1 --auto
    elif [ $1 = 'DP-1-2' ] || [ $1 = 'DP-2-2' ]
    then
        xrandr --output $1 --off
        xrandr --output $1 --right-of eDP-1 --auto
    fi
}

function disconnect() {
    xrandr --output $1 --off
}

function main() {
    sleep 0.8s

    for disp in 'DP-1' 'DP-1-2' 'DP-2' 'DP-2-2';
    do
        xrandr --query | grep "^$disp connected" &> /dev/null && connect $disp || disconnect $disp
    done

    sudo -u nicolas xmonad --recompile
    sudo -u nicolas xmonad --restart
}

main &
