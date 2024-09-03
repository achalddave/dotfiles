
import argparse
import inspect
import json

parser = argparse.ArgumentParser()
parser.add_argument("json_file")
args = parser.parse_args()


def load_json(json_file):
    with open(json_file) as f:
        return json.load(f)


if __name__ == "__main__":
    data = load_json(args.json_file)
    print("\n")
    print(inspect.getsource(load_json))
    print("\n###")
    print("Loaded JSON in variable `data`.")
    print("###")
