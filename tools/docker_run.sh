#!/bin/bash
container_name=$USER-fvp
usrid=`id -u`
grpid=`id -g`
DOCKER_IMAGE="himax/fvp"

### docker build
# docker build -t himax/fvp

### check container is ready
echo "create $container_name container"

docker run --rm --name himax_fvp -idt \
    --net=host \
    -v /home/$USER/YOLOv8_on_WE2/docker/runtime:/home/ubuntu/YOLOv8_on_WE2/ml-embedded-evaluation-kit/runtime \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /home/$USER/.Xauthority:/home/ubuntu/.Xauthority:rw \
    -e DISPLAY=$DISPLAY \
    himax/fvp bash


docker run --rm --name himax_fvp_dev -idt \
    --net=host \
    -v /home/$USER/YOLOv8_on_WE2/:/home/ubuntu/YOLOv8_on_WE2/ \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /home/$USER/.Xauthority:/home/ubuntu/.Xauthority:rw \
    -e DISPLAY=$DISPLAY \
    himax/fvp:dev bash
