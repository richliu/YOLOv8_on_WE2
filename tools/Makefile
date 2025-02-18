

export DOCKER_IMAGE = heswiki/armmlek22p4
export DOCKER_IMAGE_TAR = armmlek22p4.tar

help:
	@echo "+-----------------------------------------------------"
	@echo "| Build Docker Images"
	@echo "+-----------------------------------------------------"
	@echo "\$$ make build"
	@echo "\$$ make run"
	@echo "\$$ make clean"
	@echo "\$$ make save | load"
	@echo "\$$ make push | pull"
	@echo ""

# +------------------------------------------------------------------
# | Build Docker image
# +------------------------------------------------------------------

build:
	docker build -t $(DOCKER_IMAGE) . 2>&1 | tee build.log
	docker images

run:
	docker run --rm -it -v /home/ubuntu/cs300fvp/runtime:/home/ubuntu/YOLOv8_on_WE2/ml-embedded-evaluation-kit/runtime \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		--volume="/home/richliu/.Xauthority:/root/.Xauthority:rw" \
		--privileged \
		--workdir /home/ubuntu/YOLOv8_on_WE2/ml-embedded-evaluation-kit/runtime \
		-e DISPLAY=:0 \
		-p 2222:22 \
		$(DOCKER_IMAGE) bash 

clean:
	docker image ls
	docker rmi $(DOCKER_IMAGE)
	docker image ls


# +------------------------------------------------------------------
# | Pull & Push Docker images
# +------------------------------------------------------------------

pull:
	docker pull $(DOCKER_IMAGE)

push:
	docker push $(DOCKER_IMAGE)
	#docker push $(DOCKER_IMAGE):tagname

# +------------------------------------------------------------------
# | Save & Load Docker images
# +------------------------------------------------------------------

save:
	docker save -o $(DOCKER_IMAGE_TAR) $(DOCKER_IMAGE):latest

save-zip:
	docker save $(DOCKER_IMAGE):latest | gzip $(IMAGE_TAR_FILE).tgz

load:
	docker load --input $(DOCKER_IMAGE_TAR)


# +------------------------------------------------------------------
# | Downloads a test image hello-world and runs it in a container
# | Please run docker login at first time
# +------------------------------------------------------------------

hello:
	docker run hello-world

ubuntu:
	docker login
	docker pull ubuntu:22.04
	docker run -it ubuntu:22.04


# +------------------------------------------------------------------
# | Docker CLI
# +------------------------------------------------------------------
cmd:
	@echo "\$$ docker rmi \$$(docker image ls -q)"
	@echo "\$$ docker rm \$$(docker ps -a -q)"
	@echo "\$$ docker image ls"
	@echo "\$$ docker ps -a"


