import argparse
import json

parser = argparse.ArgumentParser()
parser.add_argument('json_file')
args = parser.parse_args()

if __name__ == '__main__':
    with open(args.json_file) as f:
        data = json.load(f)
        print '\n###'
        print 'Loaded JSON in variable `data`.'
        print '###'
