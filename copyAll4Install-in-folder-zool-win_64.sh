#!/bin/bash
folder1=/home/ns/nsp/zoolv4/
folder2=/media/ns/Archivos/zool-win-64/build/zool-release

sudo rm -r $folder2

rsync -av --exclude='.git' \
          --exclude='swe' \
          --exclude='old' \
          --exclude='*.cfg' \
          --exclude='copyAll4Install.sh' \
          --exclude='zool_launch_linux.sh' \
          --exclude='install.sh' \
          --exclude='mainZooland.qml' \
          $folder1 $folder2

#cp -r /media/ns/Archivos/zooldev/PythonOk76Mb $folder2/Python
