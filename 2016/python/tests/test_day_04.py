from advent_of_code_2016.day_04 import is_room_real

def test_is_room_real():
    t1 = 'aaaaa-bbb-z-y-x-123[abxyz]'
    t2 = 'a-b-c-d-e-f-g-h-987[abcde]'
    t3 = 'not-a-real-room-404[oarel]'
    t4 = 'totally-real-room-200[decoy]'

    assert is_room_real(t1)
    assert is_room_real(t2)
    assert is_room_real(t3)
    assert is_room_real(t4)
