from advent_of_code_2016.day_04 import is_room_real, parse_room_data,\
                                        get_n_most_common_chars, \
                                        get_sector_id_sum,\
                                        decrypt_cipher

t1 = 'aaaaa-bbb-z-y-x-123[abxyz]'
t2 = 'a-b-c-d-e-f-g-h-987[abcde]'
t3 = 'not-a-real-room-404[oarel]'
t4 = 'totally-real-room-200[decoy]'

def test_parse_room_data():
    encrypted_name, sector_id, checksum = parse_room_data(t1)

    assert encrypted_name == 'aaaaa-bbb-z-y-x'
    assert sector_id == 123
    assert checksum == 'abxyz'

def test_get_n_most_common_chars():
    assert get_n_most_common_chars('aaaaabbbzyx', 5) == 'abxyz'
    assert get_n_most_common_chars('notarealroom', 5) == 'oarel'

def test_is_room_real():
    assert is_room_real(t1)
    assert is_room_real(t2)
    assert is_room_real(t3)
    assert not is_room_real(t4)

def test_get_sector_id_sum():
    input = [t1, t2, t3, t4]
    assert get_sector_id_sum(input) == 1514

def test_decrypt_cipher():
    c = 'qzmt-zixmtkozy-ivhz'
    expected = 'very encrypted name'
    
    assert decrypt_cipher('abc', 1) == 'bcd'
    assert decrypt_cipher('-', 1000) == ' '
    assert decrypt_cipher('be-z', 5) == 'gj e'
    assert decrypt_cipher(c, 343) == expected
