import argparse
import subprocess


def s3_parallel_cp(source, dest, profile=None, num_processes=100, directories=False):
    # Construct the AWS command prefix
    aws_command = "aws s3"
    if profile:
        aws_command += f" --profile {profile}"

    field = 2 if directories else 4
    cp_or_sync = "sync" if directories else "cp"
    source = source.rstrip("/")
    dest = dest.rstrip("/")

    # Construct the full command with awk and xargs
    full_command = (
        f"{aws_command} ls {source}/ | "
        f"awk '{{print ${field}}}' | "
        f"xargs -P {num_processes} -I{{}} "
        f"{aws_command} {cp_or_sync} {source}/{{}} {dest}/{{}}"
    )

    # Execute the command
    try:
        print(full_command)
        subprocess.run(full_command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error executing command: {e}")


def main():
    parser = argparse.ArgumentParser(description="Copy files from a source S3 location to a destination S3 location in parallel.")
    parser.add_argument("source", help="Source S3 bucket and path")
    parser.add_argument("dest", help="Destination S3 bucket and path")
    parser.add_argument("--profile", help="AWS CLI profile to use", default=None)
    parser.add_argument("--num-processes", help="Number of parallel processes to use", type=int, default=100)
    parser.add_argument("--directories", action="store_true")

    args = parser.parse_args()

    s3_parallel_cp(args.source, args.dest, args.profile, args.num_processes, args.directories)

if __name__ == "__main__":
    main()

