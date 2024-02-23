#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts"
function s3_parallel_copy() {
    python ${script_dir}/s3_parallel_copy.py $@
}

