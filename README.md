# About 

This is an auto compilation/installation script for OpenCV 4.2.0 . It will create a clean ~/opencv folder, download all required dependencies and OpenCV & Contrib tars. Then, will extract and make them. This script is to make new OpenCV installations on Linux systems easier, and it won't check for errors during the process, so, make sure to follow the terminal messages. 


# How to use

- Tested on the Linux Debian Family (Ubuntu and Mint)
- run on your terminal:

```
cd ~ 
git clone https://github.com/Jeanvit/opencvautoinstaller.git
cd opencvautoinstaller
sudo sh opecvautoinstall.sh
``` 

Want a different version? Just pass it as argument, and make sure to use only 4.0.0+ 

```
sudo sh opecvautoinstall.sh 4.1.2
```


# Test if it is working properly

- There is a `.cpp` file that you can use to confirm if the script did everything correctly. You can compile it by running on the terminal:

 ```
g++ opencvtest.cpp -o opencvtest `pkg-config --cflags --libs opencv4`
./opencvtest
 ```

- Ideally this commands must not generate errors and output the following text:

```
OpenCV version : 4.2.0
Major version : 4
Minor version : 2
Subminor version : 0
```
