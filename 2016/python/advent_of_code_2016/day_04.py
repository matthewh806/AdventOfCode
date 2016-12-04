from definitions import INPUT_DIR

def is_room_real(data):
    return True

if __name__ == "__main__":
    with open(INPUT_DIR + 'day_04.txt') as f:
        input_data = [line.rstrip('\n') for line in f]

    print input_data
