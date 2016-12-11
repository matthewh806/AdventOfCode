from advent_of_code_2016.day_09 import decompress_string, parse_marker

t1 = 'ADVENT'
t2 = 'A(1x5)BC'
t3 = '(3x3)XYZ'
t4 = 'A(2x2)BCD(2x2)EFG'
t5 = '(6x1)(1x3)A'
t6 = 'X(8x2)(3x3)ABCY'
t7 = 'X(8x2)(3x3)AB(2x2)CY'

def test_parse_marker():
    c, r = parse_marker('(1x5)')   
    assert c == 1
    assert r == 5

def test_no_markers():
    o = decompress_string(t1)

    assert o == t1
    assert len(o) == 6

def test_one_marker_one_char():
    o = decompress_string(t2)

    assert o == 'ABBBBBC'
    assert len(o) == 7

def test_one_marker_3_chars():
    o = decompress_string(t3)

    assert o == 'XYZXYZXYZ'
    assert len(o) == 9

def test_two_markers():
    o = decompress_string(t4)

    assert o == 'ABCBCDEFEFG'
    assert len(o) == 11

def test_marker_within_data_section():
    o1 = decompress_string(t5)
    o2 = decompress_string(t6)
    o3 = decompress_string(t7)

    assert o1 == '(1x3)A'
    assert len(o1) == 6

    assert o2 == 'X(3x3)ABC(3x3)ABCY'
    assert len(o2) == 18

    assert o3 == 'X(3x3)AB((3x3)AB(2x2)CY'

