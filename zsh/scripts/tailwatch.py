"""Watch the last K lines of a streaming input."""
import argparse
import time
import sys
from collections import deque


reset_lines = 0


def print_last_k_lines(lines):
    global reset_lines
    # Clear previously printed lines
    print("\033[F\033[K" * reset_lines, end="")
    # Print current buffer
    for line in lines:
        print(line)
    reset_lines = len(lines)


def main(num_lines, speed):
    # # Register SIGINT handler
    # signal.signal(signal.SIGINT, handle_sigint)

    lines = deque(maxlen=num_lines)
    last_update_time = 0
    t_update = 1 / speed

    try:
        while True:
            line = sys.stdin.readline()
            if not line:
                print_last_k_lines(lines)
                break
            lines.append(line.rstrip())
            current_time = time.time()
            if current_time - last_update_time >= t_update or len(lines) < num_lines:
                print_last_k_lines(lines)
                last_update_time = current_time
    except KeyboardInterrupt:
        sys.exit(1)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Display the last K lines from stdin, updating every T seconds.")
    parser.add_argument("-n", "--num-lines", type=int, default=5, help="Number of lines to display")
    parser.add_argument("-s", "--speed", type=int, default=10, help="Speed in frames per second")
    args = parser.parse_args()

    main(args.num_lines, args.speed)
