#!/bin/bash

set -ex

if [[ ${cuda_compiler_version} != "None" ]]; then
    export BUILD_CUDA_EXTENSIONS=1
    export USE_CUDA=1
    if [[ ${cuda_compiler_version} == 10.* ]]; then
        export TORCH_CUDA_ARCH_LIST="3.5;5.0;6.0;6.1;7.0;7.5+PTX"
    elif [[ ${cuda_compiler_version} == 11.0* ]]; then
        export TORCH_CUDA_ARCH_LIST="6.0;6.1;7.0;7.5;8.0+PTX"
    elif [[ ${cuda_compiler_version} == 11.1 ]]; then
        export TORCH_CUDA_ARCH_LIST="6.0;6.1;7.0;7.5;8.0;8.6+PTX"
    elif [[ ${cuda_compiler_version} == 11.2 ]]; then
        export TORCH_CUDA_ARCH_LIST="6.0;6.1;7.0;7.5;8.0;8.6+PTX"
    elif [[ ${cuda_compiler_version} == 11.8 ]]; then
        export TORCH_CUDA_ARCH_LIST="3.5;5.0;6.0;6.1;7.0;7.5;8.0;8.6;8.9+PTX"
        export CUDA_TOOLKIT_ROOT_DIR=$CUDA_HOME
    elif [[ ${cuda_compiler_version} == 12.0 ]]; then
        export TORCH_CUDA_ARCH_LIST="5.0;6.0;6.1;7.0;7.5;8.0;8.6;8.9;9.0+PTX"
        # $CUDA_HOME not set in CUDA 12.0. Using $PREFIX
        export CUDA_TOOLKIT_ROOT_DIR="${PREFIX}"
        if [[ "${target_platform}" != "${build_platform}" ]]; then
            export CUDA_TOOLKIT_ROOT=${PREFIX}
        fi
    else
        echo "unsupported cuda version. edit build_pytorch.sh"
        exit 1
    fi
fi

$PYTHON -m pip install . -vv
