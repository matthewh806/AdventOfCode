#!/usr/bin/env python
import argparse

def main():
    parser = argparse.ArgumentParser(description="Advent of code solutions")
    parser.add_argument('-d', '--day', 
                        help='display the solution for a specific day',
                        type=int,
                        choices=range(1, 26))
    args = parser.parse_args()

if __name__ == "__main__":
    main() 
