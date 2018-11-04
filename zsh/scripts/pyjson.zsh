script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts"
function pyjson() {
    # Launches ipython with JSON file loaded as the variable "data".
    if [[ "$#" != 1 ]] ; then
        echo "Usage: $0 <json_file>"
        return
    fi
    ipython -i ${script_dir}/pyjson_helper.py "$1"
}
