#!/bin/bash
container_name=$USER-fvp
usrid=`id -u`
grpid=`id -g`
DOCKER_IMAGE="himax/fvp"

### docker build
# docker build -t himax/fvp

### check container is ready
echo "create $container_name container"
#docker run --rm -it himax/fvp bash bash 
docker run --rm --name himax_fvp -idt himax/fvp bash
docker run --rm -idt -e DISPLAY=:10.0 himax/fvp bash
#docker run --rm -it -v /labs/corstone/docker/runtime:/home/ml-embedded-evaluation-kit/runtime \
#		-e DISPLAY=:0 \
#		$(DOCKER_IMAGE) bash 


# if [ `docker ps | grep -c $container_name` = 1 ]; then
#     echo "set dev uid and gid"
#     docker exec -d $container_name usermod -u $usrid -g $grpid dev
#     ####
# else
#     echo "container $container_name is not ready"
# fi