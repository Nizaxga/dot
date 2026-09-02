#!/bin/sh

HEIGHT=15
WIDTH=40
BACKTITLE="Backtitle"
TITLE="Title"
MENU="Choose One"
CHOICE_HEIGHT=4

OPTIONS=(1 "Option 1"
        2 "Option 2"
        3 "Option 3")

CHOICE=$(dialog --clear --backtitle "$BACKTITLE" --title "$TITLE" --menu "$MENU" $HEIGHT $WIDTH $CHOICE_HEIGHT "${OPTIONS[@]}" 2>&1 >/dev/tty)

clear
case $CHOICE in
    1)
        echo "You chose option 1"
        ;;
    2)
        echo "You chose option 2"
        ;;
    3)
        echo "You chose option 3"
        ;;
esac
