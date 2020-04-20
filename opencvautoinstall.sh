#!/bin/bash
version=4.3.0
if [ "$1" != "" ]; then
   version=$1
fi
echo "This is an auto compilation/installation bash script for OpenCV $version created by www.jeanvitor.com. If you choose to continue, all needed dependencies, "
echo "and OpenCV & Contrib zips is will be downloaded, compiled and installed. So, this may take a while to finish."
echo "Press [ENTER] to continue or [CTRL][C] to cancel."
read var
start=$(date +%s.%N)
sudo apt-get install build-essential
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev
cd ~
rm -r opencv && echo "Removing old OpenCV folder" || echo "Creating a new ~/OpenCV/"; mkdir opencv
cd opencv
echo "Downloading OpenCV"
wget https://github.com/opencv/opencv/archive/$version.tar.gz
echo "Extracting..."
tar -zxf $version.tar.gz && echo "OK" || exit
rm $version.tar.gz
echo "Downloading OpenCV_contrib"
wget https://github.com/opencv/opencv_contrib/archive/$version.tar.gz
echo "Extracting..."
tar -zxf $version.tar.gz && echo "OK" || exit
rm $version.tar.gz
mkdir build
cd build
echo "Running cmake..."
cmake -D CMAKE_BUILD_TYPE=Release -D OPENCV_GENERATE_PKGCONFIG=YES -OPENCV_EXTRA_MODULES_PATH=~/opencv/opencv_contrib-$version/modules/ -DCMAKE_INSTALL_PREFIX=/usr/local ~/opencv/opencv-$version/ && echo "OK" || exit
cores=$(nproc)
echo "Running make..."
make -j$cores && echo "OK" || exit
sudo make install && echo "OK" || exit
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
sudo mkdir /usr/local/lib/pkgconfig
sudo cp ~/opencv/build/unix-install/opencv4.pc /usr/local/lib/pkgconfig/
sudo sed -i 's#includedir_old=${prefix}/include/opencv4/opencv#includedir_old=${prefix}/include/opencv4/opencv2#g' /usr/local/lib/pkgconfig/opencv4.pc
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "INSTALATION SCRIPT FINISHED\nExecution time: %.6f seconds\n" $dur
echo "OPENCV IS NOW READY TO USE."
