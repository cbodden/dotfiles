#!/bin/sh

screenshot(){
  case $1 in
    full) $(which scrot) -m ~/fshot_'%s_$wx$h'.png ;;
    window) sleep 1 ; $(which scrot) -s ~/wshot_'%s_$wx$h'.png ;;
    *) ;;
  esac
}

screenshot $1
