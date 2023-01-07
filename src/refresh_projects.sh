#! /bin/sh

find ~/Documents -type d -name .git | sed "s/.git//g" > ~/.projects