from advent_of_code_2016.day_16 import *

t1 = '110010110100'
t2 = '10000'

def test_generate_random_string():
    assert generate_random_string('1') == '100'
    assert generate_random_string('0') == '001'
    assert generate_random_string('11111') == '11111000000'
    assert generate_random_string('111100001010') == \
                '1111000010100101011110000'

def test_generate_data():
    assert generate_data('10000', 20) == '10000011110010000111'

def test_generate_checksum():
    assert generate_checksum('110010110100', 12) == '100'
    assert generate_checksum('10000', 20) == '01100'


