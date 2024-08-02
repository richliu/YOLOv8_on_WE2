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
ENV HIMAX_MLFVP_DIR="/home/ML_FVP_EVALUATION" \
    ITRI_MLFVP_DIR="/home/YOLOv8_on_WE2"

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
    # python3.10 \
    # python3-pip \
    # python3.10-dev \
    # python3.10-venv \
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
    telnet

# Check versions
RUN gcc --version && g++ --version && python3 --version
RUN git config --global http.sslVerify false
RUN git config --global http.postBuffer 1048576000
RUN git config --global https.postBuffer 1048576000

# # Download and install GNU GCC 13.2 embedded toolchain
# RUN curl -L https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz -o gcc-arm-none-eabi.tar.xz && \
#     echo "6cd1bbc1d9ae57312bcd169ae283153a9572bd6a8e4eeae2fedfbc33b115fdbb gcc-arm-none-eabi.tar.xz" | sha256sum -c && \
#     mkdir /opt/gcc-arm-none-eabi && \
#     tar -xf  gcc-arm-none-eabi.tar.xz -C /opt/gcc-arm-none-eabi --strip-components 1 && \
#     rm gcc-arm-none-eabi.tar.xz

# Download and install GNU GCC 10.2.1 embedded toolchain
RUN curl -k -L https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 -o gcc-arm-none-eabi.tar.xz && \
    echo "21134caa478bbf5352e239fbc6e2da3038f8d2207e089efc96c3b55f1edcd618 gcc-arm-none-eabi.tar.xz" | sha256sum -c && \
    mkdir /opt/gcc-arm-none-eabi && \
    tar -xf  gcc-arm-none-eabi.tar.xz -C /opt/gcc-arm-none-eabi --strip-components 1 && \
    rm gcc-arm-none-eabi.tar.xz

ENV PATH="/opt/gcc-arm-none-eabi/bin/:$PATH"


# # Download and install Arm Corstone-300 FVP
# RUN wget --no-check-certificate "${FVP_BASE_URL}/FVP/Corstone-300/${FVP_300}_${FVP_VER_300}_Linux64.tgz" 2>/dev/null && \
#     echo "${FVP_300_SHA} ${FVP_300}_${FVP_VER_300}_Linux64.tgz" | sha256sum -c && \
#     mkdir -p /home/${FVP_300}/ && \
#     tar -xf ${FVP_300}_${FVP_VER_300}_Linux64.tgz -C /home/${FVP_300}/ && \
#     bash /home/${FVP_300}/${FVP_300}.sh --no-interactive --i-agree-to-the-contained-eula -d /home/${FVP_300} && \
#     rm "${FVP_300}_${FVP_VER_300}_Linux64.tgz"

# Download and install Arm Corstone-310 FVP
# RUN wget ${FVP_BASE_URL}/FVP/Corstone-310/${FVP_310}_${FVP_VER_310}_Linux64.tgz 2>/dev/null && \
#     echo "${FVP_310_SHA} ${FVP_310}_${FVP_VER_310}_Linux64.tgz" | sha256sum -c && \
#     mkdir -p /home/${FVP_310}/ && \
#     tar -xf ${FVP_310}_${FVP_VER_310}_Linux64.tgz -C /home/${FVP_310}/ && \
#     bash /home/${FVP_310}/${FVP_310}.sh --no-interactive --i-agree-to-the-contained-eula -d /home/${FVP_310} && \
#     rm "${FVP_310}_${FVP_VER_310}_Linux64.tgz"

# # Download and install Arm Corstone-315 FVP
# RUN wget "${FVP_BASE_URL}/FVP/Corstone-315/${FVP_315}_${FVP_VER_315}_Linux64.tgz" 2>/dev/null && \
#     echo "${FVP_315_SHA} ${FVP_315}_${FVP_VER_315}_Linux64.tgz" | sha256sum -c && \
#     mkdir -p /home/${FVP_315}/ && \
#     tar -xf ${FVP_315}_${FVP_VER_315}_Linux64.tgz -C /home/${FVP_315}/ && \
#     bash /home/${FVP_315}/${FVP_315}.sh --no-interactive --i-agree-to-the-contained-eula -d /home/${FVP_315} && \
#     rm "${FVP_315}_${FVP_VER_315}_Linux64.tgz"

# Clone the ml-embedded-evaluation-kit repository
# RUN git clone -b 22.02 "https://review.mlplatform.org/ml/ethos-u/ml-embedded-evaluation-kit" ${EVAL_KIT_DIR}

# Change working directory
# WORKDIR ${EVAL_KIT_DIR}

# Initialize submodules
# RUN git submodule update --init

# Download and install resources required for ml-embedded-evaluation-kit
# RUN python3 ./set_up_default_resources.py

# Update PATH to make the required version of CMake and GNU embedded toolchain is available.
# And add env variables to make access to the different FVPs easier.
# ENV PATH="${EVAL_KIT_DIR}/resources_downloaded/env/bin:/opt/gcc-arm-none-eabi/bin:${PATH}" \
#     FVP_300_U55="/home/${FVP_300}/models/Linux64_GCC-9.3/${FVP_300}_Ethos-U55" \
#     FVP_300_U65="/home/${FVP_300}/models/Linux64_GCC-9.3/${FVP_300}_Ethos-U65" \
#     FVP_310_U55="/home/${FVP_310}/models/Linux64_GCC-9.3/${FVP_310}" \
#     FVP_310_U65="/home/${FVP_310}/models/Linux64_GCC-9.3/${FVP_310}_Ethos-U65" \
#     FVP_315_U65="/home/${FVP_315}/models/Linux64_GCC-9.3/${FVP_315}" \
#     FVP_300_ARGS="-C mps3_board.telnetterminal0.start_telnet=0 -C mps3_board.uart0.out_file='-' -C mps3_board.uart0.shutdown_on_eot=1 -C mps3_board.visualisation.disable-visualisation=1" \
#     FVP_310_ARGS="-C mps3_board.telnetterminal0.start_telnet=0 -C mps3_board.uart0.out_file='-' -C mps3_board.uart0.shutdown_on_eot=1 -C mps3_board.visualisation.disable-visualisation=1" \
#     FVP_315_ARGS="-C mps4_board.telnetterminal0.start_telnet=0 -C mps4_board.uart0.out_file='-' -C mps4_board.uart0.shutdown_on_eot=1 -C mps4_board.visualisation.disable-visualisation=1 -C vis_hdlcd.disable_visualisation=1"

# ENV PATH="${EVAL_KIT_DIR}/resources_downloaded/env/bin:/opt/gcc-arm-none-eabi/bin:${PATH}" \
#     FVP_300_U55="/home/${FVP_300}/models/Linux64_GCC-9.3/${FVP_300}_Ethos-U55" \
#     FVP_300_ARGS="-C mps3_board.telnetterminal0.start_telnet=0 -C mps3_board.uart0.out_file='-' -C mps3_board.uart0.shutdown_on_eot=1 -C mps3_board.visualisation.disable-visualisation=1"

#ENV PATH="${EVAL_KIT_DIR}/resources_downloaded/env/bin:/opt/gcc-arm-none-eabi/bin:${PATH}" 

# +----------------------------------------------------------------------------
# | Clone the Himax ML_FVP_EVALUATION repository
# +----------------------------------------------------------------------------
# WORKDIR /home
# RUN git clone "https://github.com/HimaxWiseEyePlus/ML_FVP_EVALUATION.git" ${HIMAX_MLFVP_DIR}
# # Change working directory
# WORKDIR ${HIMAX_MLFVP_DIR}
# # Initialize submodules
# RUN git submodule update --init

# Change working directory
## WORKDIR ${EVAL_KIT_DIR}
## RUN sudo apt-get update && sudo apt-get install -y python-pip
## RUN sudo apt-get update && sudo apt-get install -y python3-pip
## RUN ./build_default.py --npu-config-name ethos-u55-64
## 
## # Build Himax Eexample
## WORKDIR ${HIMAX_MLFVP_DIR}
## RUN wget https://review.mlplatform.org/plugins/gitiles/ml/ethos-u/ml-embedded-evaluation-kit/+archive/refs/tags/22.02.tar.gz
## RUN mkdir -p ml-embedded-evaluation-kit
## RUN tar -C ml-embedded-evaluation-kit  -xvzf 22.02.tar.gz
## 
## RUN cp -r ./source/application/main/include ./ml-embedded-evaluation-kit/source/application/main
## RUN cp -r ./source/application/tensorflow-lite-micro/include ./ml-embedded-evaluation-kit/source/application/tensorflow-lite-micro
## RUN cp -r ./source/profiler/include ./ml-embedded-evaluation-kit/source/profiler
## RUN cp -r ./source/use_case/ad/include ./ml-embedded-evaluation-kit/source/use_case/ad
## RUN cp -r ./source/use_case/asr/include ./ml-embedded-evaluation-kit/source/use_case/asr
## RUN cp -r ./source/use_case/img_class/include ./ml-embedded-evaluation-kit/source/use_case/img_class
## RUN cp -r ./source/use_case/inference_runner/include ./ml-embedded-evaluation-kit/source/use_case/inference_runner
## RUN cp -r ./source/use_case/kws/include ./ml-embedded-evaluation-kit/source/use_case/kws
## RUN cp -r ./source/use_case/kws_asr/include ./ml-embedded-evaluation-kit/source/use_case/kws_asr
## RUN cp -r ./source/use_case/noise_reduction/include ./ml-embedded-evaluation-kit/source/use_case/noise_reduction
## RUN cp -r ./source/use_case/object_detection/include ./ml-embedded-evaluation-kit/source/use_case/object_detection
## RUN cp -r ./source/use_case/vww/include ./ml-embedded-evaluation-kit/source/use_case/vww
## RUN cp -r download_dependencies.py ./ml-embedded-evaluation-kit/
## RUN cp -r set_up_default_resources.py ./ml-embedded-evaluation-kit/
## 
## ## cd ml-embedded-evaluation-kit/
## WORKDIR ${HIMAX_MLFVP_DIR}/ml-embedded-evaluation-kit
## RUN sudo apt-get update && sudo apt-get install -y python-pip
## RUN sudo apt-get update && sudo apt-get install -y python3-pip
## RUN rm -rf ./dependencies
## RUN python3 ./download_dependencies.py
## ##RUN ./build_default.py --npu-config-name ethos-u55-64
## 
## WORKDIR ${HIMAX_MLFVP_DIR}
## RUN cp -r ./resources/img_person_detect ./ml-embedded-evaluation-kit/resources
## RUN cp -r ./source/use_case/img_person_detect ./ml-embedded-evaluation-kit/source/use_case
## RUN cp -r ./vela/img_person_detect ./ml-embedded-evaluation-kit/resources_downloaded/
## RUN cp -r ./resources/img_yolofastest_relu6_256_himax ./ml-embedded-evaluation-kit/resources
## RUN cp -r ./source/use_case/img_yolofastest_relu6_256_himax ./ml-embedded-evaluation-kit/source/use_case
## RUN cp -r ./vela/img_yolofastest_relu6_256_himax ./ml-embedded-evaluation-kit/resources_downloaded/      
## RUN cp -r ./resources/img_yolofastest_xl_relu6_256_himax ./ml-embedded-evaluation-kit/resources
## RUN cp -r ./source/use_case/img_yolofastest_xl_relu6_256_himax ./ml-embedded-evaluation-kit/source/use_case
## RUN cp -r ./vela/img_yolofastest_xl_relu6_256_himax ./ml-embedded-evaluation-kit/resources_downloaded/



# +----------------------------------------------------------------------------
# | ITRI
# +----------------------------------------------------------------------------

WORKDIR /home
RUN git clone -b ci_env "https://github.com/anitawuitri/YOLOv8_on_WE2.git" ${ITRI_MLFVP_DIR}
# Change working directory
WORKDIR ${ITRI_MLFVP_DIR}
# Initialize submodules
RUN git submodule update --init

WORKDIR ${ITRI_MLFVP_DIR}

# Download and install Arm Corstone-300 FVP
RUN mkdir temp
RUN wget --no-check-certificate "${FVP_BASE_URL}/FVP/Corstone-300/MPS3/${FVP_300}_Ethos-U55_${FVP_VER_300}.tgz"
RUN echo "${FVP_300_SHA} ${FVP_300}_Ethos-U55_${FVP_VER_300}.tgz" | sha256sum -c
RUN tar -xf ${FVP_300}_Ethos-U55_${FVP_VER_300}.tgz -C temp 
RUN temp/${FVP_300}_Ethos-U55.sh --no-interactive --i-agree-to-the-contained-eula -d ${FVP_300}
RUN rm "${FVP_300}_Ethos-U55_${FVP_VER_300}.tgz"


# Clone the ml-embedded-evaluation-kit repository
# RUN git clone -b 22.02 "https://review.mlplatform.org/ml/ethos-u/ml-embedded-evaluation-kit" 
RUN wget --no-check-certificate https://review.mlplatform.org/plugins/gitiles/ml/ethos-u/ml-embedded-evaluation-kit/+archive/refs/tags/22.02.tar.gz
RUN mkdir ml-embedded-evaluation-kit
RUN tar -C ml-embedded-evaluation-kit  -xvzf 22.02.tar.gz

# Download and install resources required for ml-embedded-evaluation-kit
# RUN python3 ./set_up_default_resources.py


WORKDIR ${ITRI_MLFVP_DIR}
RUN tools/install.sh

## cd ml-embedded-evaluation-kit/
WORKDIR ${ITRI_MLFVP_DIR}/ml-embedded-evaluation-kit
## RUN sudo /bin/python3 -m pip install --upgrade pip
## RUN pip3 list
## RUN sudo pip3 install virtualenv

RUN rm -rf ./dependencies
RUN python3 ./download_dependencies.py
#RUN sudo apt-get update
## RUN sudo apt-get remove -y python-pip python3-pip
## RUN sudo apt-get install -y python-pip python3-pip
## RUN sudo apt-get install -y cmake curl xterm python3 python3-venv libpython3-dev
RUN ./build_default.py --npu-config-name ethos-u55-64

## Go out ml-embedded-evaluation-kit folder and copy the example resources to ML embedded evaluation kit
## cd ..
WORKDIR ${ITRI_MLFVP_DIR}
RUN tools/post_install.sh

## Install vela
WORKDIR ${ITRI_MLFVP_DIR}/vela
RUN pip install ethos-u-vela
# vela --accelerator-config ethos-u55-64 --config himax_vela.ini --system-config My_Sys_Cfg --memory-mode My_Mem_Mode_Parent --output-dir ./img_yolov8_pose_192 ./img_yolov8_pose_192/yolov8n-pose_full_integer_quant.tflite

## cd ml-embedded-evaluation-kit/
WORKDIR ${ITRI_MLFVP_DIR}/ml-embedded-evaluation-kit
#RUN mkdir build_img_yolov8_192
#WORKDIR ${ITRI_MLFVP_DIR}/ml-embedded-evaluation-kit/build_img_yolov8_192
ENV GIT_SSL_NO_VERIFY=1
#RUN cmake ../ -DUSE_CASE_BUILD=img_yolov8_192 \-DETHOS_U_NPU_ENABLED=ON
#RUN make -j8

