# Introduction

## About this Learning Path
* Skill level: Introduction
* Author: Anita Wu
* Reading time: 
* Arm IP: Cortex-M55, Ethos-U55 

### Who is this for?
This is an introductory topic for developers interested in integrating object detection into their applications.

###  What will you learn?
Upon completion of this learning path, you will be able to:
1. TBD
2. TBD


### Prerequisites
Before starting, you will need the following:
1. Ubuntu or Windows WSL enviroment
2. X

# Set up your Grove Vision AI V2 FVP (Himax WE 2)
## Prerequisites

# Run Docker for FVP
## Build up Himax FVP docker Development and Test Environment
- Git clone from github
  ```
  git clone -b ci_env https://github.com/anitawuitri/YOLOv8_on_WE2.git 
  ```
- Build Docker file
  ```
  cd YOLOv8_on_WE2
  cd tools
  docker build -t himax/fvp:dev -f Dockerfile.dev .
  ```
- Run docker container
  ```
  docker run --rm --name himax_fvp_dev -idt \
  --net=host \
  -v /home/$USER/YOLOv8_on_WE2:/home/ubuntu/YOLOv8_on_WE2 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /home/$USER/.Xauthority:/home/ubuntu/.Xauthority:rw \
  -e DISPLAY=$DISPLAY \
  himax/fvp:dev bash
  ```
- Enter container 
  ```
  docker exec -it himax_fvp_dev /bin/bash
  ```

## Install Development Environment in Container
- Run Installation Script
  ```
  cd YOLOv8_on_WE2/
  tools/install.sh
  ```
- Run Post Installation Script
  ```
  tools/post_install.sh
  ```
## Build Yolov8 Models with vela in Container
  ```
  cd vela
  vela --accelerator-config ethos-u55-64 --config himax_vela.ini --system-config My_Sys_Cfg --memory-mode My_Mem_Mode_Parent --output-dir ./img_yolov8_pose_192 ./img_yolov8_pose_192/yolov8n-pose_full_integer_quant.tflite
  ```
## Make Yolov8 FVP Inference sample codes in Container
  ```
  cd ../ml-embedded-evaluation-kit/
  mkdir build_img_yolov8_192
  cd build_img_yolov8_192
  cmake ../ -DUSE_CASE_BUILD=img_yolov8_192 \-DETHOS_U_NPU_ENABLED=ON
  make -j4
  ```
## RUN FVP in Container
  ```
  cd ../../
  FVP_Corstone_SSE-300/models/Linux64_GCC-6.4/FVP_Corstone_SSE-300_Ethos-U55 -C ethosu.num_macs=64 ml-embedded-evaluation-kit/build_img_yolov8_192/bin/ethos-u-img_yolov8_192.axf
  ```

# Review
## What you've learned
You should now know how to:
* TBD
* TBD
## Knowledge Check
#### True or False? TBD 
- [X] True
- [ ] False


# Next Steps

### Continue Learning
This is the first in a series of Learning Paths on using the Grove Vision AI V2 and training your own models for various ML tasks.




