#  SPDX-FileCopyrightText: Copyright 2022-2024 Arm Limited and/or its
#  affiliates <open-source-office@arm.com>
#  SPDX-License-Identifier: Apache-2.0
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

ENV EVAL_KIT_DIR="/home/ml-embedded-evaluation-kit" \
    FVP_BASE_URL="https://developer.arm.com/-/media/Arm%20Developer%20Community/Downloads/OSS/" \
    FVP_300="FVP_Corstone_SSE-300" \
    FVP_VER_300="11.14_24" \
    FVP_300_SHA="7c269c90b455cb4fb09012f2b9b56a38ca93f3be5100d3425d7d8cc276bb824c"

## User added
RUN useradd -m ubuntu && echo "ubuntu:ubuntu" | chpasswd
RUN usermod -aG sudo ubuntu
ENV ITRI_MLFVP_DIR="/home/ubuntu/YOLOv8_on_WE2"


RUN apt-get update && \
    apt-get install -y \
    make \
    build-essential \
    fakeroot \
    dpkg-dev \
    git \
    python3 \
    python3-pip \
    python3.8-venv \
    libpython3.8-dev \
    cmake \
    gnutls-bin \
    unzip \
    curl \
    wget \
    gpg \
    libsndfile1 \
    sudo \
    vim \
    curl \
    net-tools \
    wget \
    xterm \
    p7zip-full \
    nomacs \
    telnet \
    x11-apps

ENV USER_NAME ubuntu
RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER_NAME} 


# Download and install GNU GCC 10.2.1 embedded toolchain
RUN curl -k -L "https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2" -o gcc-arm-none-eabi.tar.xz && \
    echo "21134caa478bbf5352e239fbc6e2da3038f8d2207e089efc96c3b55f1edcd618 gcc-arm-none-eabi.tar.xz" | sha256sum -c && \

# RUN curl -k -L "https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-aarch64-linux.tar.bz2?revision=cff794bc-3fb1-4c9c-934b-782886767324&rev=cff794bc3fb14c9c934b782886767324&hash=14BD0CC7D78E6D5E5FCF87DBB6D845C4A651BFD7" -o gcc-arm-none-eabi.tar.xz && \
#    echo "343d8c812934fe5a904c73583a91edd812b1ac20636eb52de04135bb0f5cf36a gcc-arm-none-eabi.tar.xz" | sha256sum -c && \
    mkdir /opt/gcc-arm-none-eabi && \
    tar -xf  gcc-arm-none-eabi.tar.xz -C /opt/gcc-arm-none-eabi --strip-components 1 && \
    rm gcc-arm-none-eabi.tar.xz

USER ubuntu
WORKDIR /home/ubuntu

# Check versions
RUN gcc --version && g++ --version && python3 --version
RUN git config --global http.sslVerify false
RUN git config --global http.postBuffer 1048576000
RUN git config --global https.postBuffer 1048576000

ENV PATH="/opt/gcc-arm-none-eabi/bin/:$PATH"

# +----------------------------------------------------------------------------
# | ITRI
# +----------------------------------------------------------------------------

RUN git clone -b ci_env "https://github.com/richliu/YOLOv8_on_WE2.git"
# Change working directory
WORKDIR ${ITRI_MLFVP_DIR}
# Initialize submodules
RUN git submodule update --init


# Download and install Arm Corstone-300 FVP
RUN mkdir temp
RUN wget --no-check-certificate "${FVP_BASE_URL}/FVP/Corstone-300/MPS3/${FVP_300}_Ethos-U55_${FVP_VER_300}.tgz"
RUN echo "${FVP_300_SHA} ${FVP_300}_Ethos-U55_${FVP_VER_300}.tgz" | sha256sum -c
RUN tar -xf ${FVP_300}_Ethos-U55_${FVP_VER_300}.tgz -C temp 
RUN temp/${FVP_300}_Ethos-U55.sh --no-interactive --i-agree-to-the-contained-eula -d ${FVP_300}
RUN rm "${FVP_300}_Ethos-U55_${FVP_VER_300}.tgz"


# download the 22.02 ml-embedded-evaluation-kit repository
RUN wget http://richliu.com/ARM/22.02.2.tar.gz
RUN mkdir ml-embedded-evaluation-kit
RUN tar -C ml-embedded-evaluation-kit  -xvzf 22.02.2.tar.gz
RUN wget http://richliu.com/ARM/download_dependencies.py

WORKDIR ${ITRI_MLFVP_DIR}
RUN tools/install.sh

## cd ml-embedded-evaluation-kit/
WORKDIR ${ITRI_MLFVP_DIR}/ml-embedded-evaluation-kit

RUN rm -rf ./dependencies
RUN python3 ./download_dependencies.py
RUN ./build_default.py --npu-config-name ethos-u55-64

## Go out ml-embedded-evaluation-kit folder and copy the example resources to ML embedded evaluation kit
## cd ..
WORKDIR ${ITRI_MLFVP_DIR}
RUN tools/post_install.sh

## Install vela
# WORKDIR ${ITRI_MLFVP_DIR}/vela
RUN sudo pip install ethos-u-vela
# e.g. vela --accelerator-config ethos-u55-64 --config himax_vela.ini --system-config My_Sys_Cfg --memory-mode My_Mem_Mode_Parent --output-dir ./img_yolov8_pose_192 ./img_yolov8_pose_192/yolov8n-pose_full_integer_quant.tflite

## cd ml-embedded-evaluation-kit/
# WORKDIR ${ITRI_MLFVP_DIR}/ml-embedded-evaluation-kit
RUN pip install Pillow
# yolov8 example
# RUN mkdir build_img_yolov8_192
# WORKDIR ${ITRI_MLFVP_DIR}/ml-embedded-evaluation-kit/build_img_yolov8_192
# RUN cmake ../ -DUSE_CASE_BUILD=img_yolov8_192 \-DETHOS_U_NPU_ENABLED=ON
# RUN make -j8

