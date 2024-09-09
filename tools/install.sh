#!/bin/bash

FVP_BASE_URL="https://developer.arm.com/-/media/Arm%20Developer%20Community/Downloads/OSS/"
FVP_300="FVP_Corstone_SSE-300"
FVP_VER_300="11.14_24"
FVP_300_SHA="7c269c90b455cb4fb09012f2b9b56a38ca93f3be5100d3425d7d8cc276bb824c"

echo "Download and install Arm Corstone-300 FVP"
mkdir temp
wget --no-check-certificate "${FVP_BASE_URL}/FVP/Corstone-300/MPS3/${FVP_300}_Ethos-U55_${FVP_VER_300}.tgz"
echo "${FVP_300_SHA} ${FVP_300}_Ethos-U55_${FVP_VER_300}.tgz" | sha256sum -c
tar -xf ${FVP_300}_Ethos-U55_${FVP_VER_300}.tgz -C temp 
temp/${FVP_300}_Ethos-U55.sh --no-interactive --i-agree-to-the-contained-eula -d ${FVP_300}
rm "${FVP_300}_Ethos-U55_${FVP_VER_300}.tgz"

echo "download the 22.02 ml-embedded-evaluation-kit repository"
wget --no-check-certificate https://review.mlplatform.org/plugins/gitiles/ml/ethos-u/ml-embedded-evaluation-kit/+archive/refs/tags/22.02.tar.gz
mkdir ml-embedded-evaluation-kit
tar -C ml-embedded-evaluation-kit  -xvzf 22.02.tar.gz

cp -r ./source/application/main/include ./ml-embedded-evaluation-kit/source/application/main
cp -r ./source/application/tensorflow-lite-micro/include ./ml-embedded-evaluation-kit/source/application/tensorflow-lite-micro
cp -r ./source/profiler/include ./ml-embedded-evaluation-kit/source/profiler
cp -r ./source/use_case/ad/include ./ml-embedded-evaluation-kit/source/use_case/ad
cp -r ./source/use_case/asr/include ./ml-embedded-evaluation-kit/source/use_case/asr
cp -r ./source/use_case/img_class/include ./ml-embedded-evaluation-kit/source/use_case/img_class
cp -r ./source/use_case/inference_runner/include ./ml-embedded-evaluation-kit/source/use_case/inference_runner
cp -r ./source/use_case/kws/include ./ml-embedded-evaluation-kit/source/use_case/kws
cp -r ./source/use_case/kws_asr/include ./ml-embedded-evaluation-kit/source/use_case/kws_asr
cp -r ./source/use_case/noise_reduction/include ./ml-embedded-evaluation-kit/source/use_case/noise_reduction
cp -r ./source/use_case/object_detection/include ./ml-embedded-evaluation-kit/source/use_case/object_detection
cp -r ./source/use_case/vww/include ./ml-embedded-evaluation-kit/source/use_case/vww
cp -r download_dependencies.py ./ml-embedded-evaluation-kit/
cp -r set_up_default_resources.py ./ml-embedded-evaluation-kit/
cp -r gen_rgb_cpp.py ./ml-embedded-evaluation-kit/scripts/py/
cp -r requirements.txt ./ml-embedded-evaluation-kit/scripts/py/
cd ml-embedded-evaluation-kit/
rm -rf ./dependencies
python3 ./download_dependencies.py
./build_default.py --npu-config-name ethos-u55-64
