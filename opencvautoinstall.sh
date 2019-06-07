#!/bin/bash
echo "This is an auto compilation/installation bash script for the OpenCV4.1 . It will create a clean ~/opencv folder, download all required dependencies, "
echo "and OpenCV & Contrib zips. It will also extract and make them. So, it may take a while to finish."
echo "Press [ENTER] to continue or [CTRL][C] to cancel."
read var
start=$(date +%s.%N)
sudo apt-get install build-essential
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev
cd ~
sudo rm -r opencv && echo "Removing old OpenCV folder" || echo "Creating a new ~/OpenCV/"; mkdir opencv
cd opencv
echo "Downloading OpenCV"
wget https://github.com/opencv/opencv/archive/4.1.0.tar.gz
echo "Extracting..."
tar -zxf 4.1.0.tar.gz && echo "OK" || exit
rm 4.1.0.tar.gz
echo "Downloading OpenCV_contrib"
wget https://github.com/opencv/opencv_contrib/archive/4.1.0.tar.gz
echo "Extracting..."
tar -zxf 4.1.0.tar.gz && echo "OK" || exit
rm 4.1.0.tar.gz
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=Release -OPENCV_EXTRA_MODULES_PATH=~/opencv/opencv_contrib-4.1.0/modules/ -DCMAKE_INSTALL_PREFIX=/usr/local ~/opencv/opencv-4.1.0/ && echo "OK" || exit
make -j7 && echo "OK" || exit
sudo make install && echo "OK" || exit
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "INSTALATION SCRIPT FINISHED\nExecution time: %.6f seconds\n" $dur
echo "OPENCV IS NOW READY TO USE."

