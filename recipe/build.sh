#!/bin/bash

set -ex

if [[ ${cuda_compiler_version} != "None" ]]; then
    export BUILD_CUDA_EXTENSIONS=1
    export USE_CUDA=1
    if [[ ${cuda_compiler_version} == 10.* ]]; then
        export TORCH_CUDA_ARCH_LIST="3.5;5.0;6.0;6.1;7.0;7.5"
    elif [[ ${cuda_compiler_version} == 11.0* ]]; then
        export TORCH_CUDA_ARCH_LIST="6.0;6.1;7.0;7.5;8.0"
    elif [[ ${cuda_compiler_version} == 11.1 ]]; then
        export TORCH_CUDA_ARCH_LIST="6.0;6.1;7.0;7.5;8.0;8.6"
    elif [[ ${cuda_compiler_version} == 11.2 ]]; then
        export TORCH_CUDA_ARCH_LIST="6.0;6.1;7.0;7.5;8.0;8.6"
    else
        echo "unsupported cuda version. edit build_pytorch.sh"
        exit 1
    fi
fi

$PYTHON -m pip install . -vv
