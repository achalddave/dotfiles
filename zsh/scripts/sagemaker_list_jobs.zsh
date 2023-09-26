script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts"
function smjobs() {
    python ${script_dir}/sagemaker_list_jobs.py "$1"
}
