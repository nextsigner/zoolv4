#!/bin/bash
folder1=/home/ns/nsp/zoolv4/
folder2=/home/ns/nsp/zool-release

#sudo rm -r $folder2

rsync -av --exclude='.git' \
          --exclude='old' \
          --exclude='*.cfg' \
          --exclude='*.sh' \
          --exclude='mainZooland.qml' \
          $folder1 $folder2

