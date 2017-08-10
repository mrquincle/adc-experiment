#!/bin/sh

file=${1:? "usage"}

if [ -e $file ]; then
  cat $file | grep Voltage | cut -f2 -d':' > $file.volt
  cat $file | grep Current | cut -f2 -d':' > $file.current
fi
