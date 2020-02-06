#!/bin/bash

# Download the jetson image from here
# https://developer.download.nvidia.com/training/nano/dlinano_v1-0-0_image_20GB.zip
# Burn the image to SD card using - Balena Etcher

# Recomendations:
# get the fastest SD card you can afford
# get a higher amperage power supply (5 volt 4 Amp from Altronics, or equivelent)
# jumper the J48 pins to use the 2.1mm power jack
# do the course - https://courses.nvidia.com/courses/course-v1:DLI+C-RX-02+V1/info


#log onto the Jetson Nano via SSH
# usename and password - dlinano


# Most of the infor was pieced together from here, but it was a little out of order
##  https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-devkit
##  https://developer.download.nvidia.com/assets/embedded/secure/jetson/Nano/docs/NVIDIA_Jetson_Nano_Developer_Kit_User_Guide.pdf?jV8Ya0iDABVzSSCEHmE63z7qQ9jLfxXZ6psLu2yAIrLAGUO7_NCr4O4CGqTtcCL4wkFmjEM7pNjLMrLnLKJTqkILL2ppRRJyMZF5xAd6nN7vVlbBHhXiSbT_slRpfUiMpsv6TowjjJxuGrc-Um1oJReo3qN8mQNXA9lR-24OpreFwjgQdABJ0LwNwc4jG_F9poky4Bw6
##  https://github.com/NVIDIA-AI-IOT/trt_pose
##  https://devtalk.nvidia.com/default/topic/1049071/pytorch-for-jetson-nano-version-1-3-0-now-available/

# Recommend changing size of swap drive to maybe 4-6GB if you have a big enough SD card
## https://bogdancornianu.com/change-swap-size-in-ubuntu/

#update the system first
sudo apt-get update
sudo apt-get upgrade

#install some files that appear to be missing from the Python install
sudo apt install python3-pip
sudo apt install nano
pip3 install Cython
sudo apt-get install build-essential
pip3 install python-osc
pip3 install setuptools
pip3 install jupyter


#setup jetson nano for python 3.6
#> info <> https://devtalk.nvidia.com/default/topic/1049071/pytorch-for-jetson-nano-version-1-3-0-now-available/
wget https://nvidia.box.com/shared/static/phqe92v26cbhqjohwtvxorrwnmrnfx1o.whl -O torch-1.3.0-cp36-cp36m-linux_aarch64.whl
pip3 install numpy torch-1.3.0-cp36-cp36m-linux_aarch64.whl

#Install torchvision, etc
# > info <> https://devtalk.nvidia.com/default/topic/1049071/pytorch-for-jetson-nano-version-1-3-0-now-available/
sudo apt-get install libjpeg-dev zlib1g-dev
git clone --branch v0.5.0 https://github.com/pytorch/vision torchvision
cd torchvision
sudo python3 setup.py install
cd ~  # attempting to load torchvision from build dir will result in import error


#install trt_pose
pip3 install tqdm pycocotools
sudo apt-get install python3-matplotlib
git clone https://github.com/NVIDIA-AI-IOT/trt_pose
cd trt_pose
sudo python3 setup.py install
cd ~

#install torch2trt
git clone https://github.com/NVIDIA-AI-IOT/torch2trt
cd torch2trt
sudo python3 setup.py install
cd ~

sudo apt install libcanberra-gtk-module


# download weights - in web browser
# and place in (tasks/human_pose) directory
# https://drive.google.com/open?id=1XYDdCUdiF2xxx4rznmLb62SdOUZuoNbd 
# cd ~/trt_pose/tasks/human_pose

#end
