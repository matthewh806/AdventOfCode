from advent_of_code_2016.day_05 import generate_hash_with_n_leading_zeros,\
                                        get_door_code

test_door_id = 'abc'

def test_generate_hash_with_n_leading_zeros():
   res, idx = generate_hash_with_n_leading_zeros(test_door_id, 0, 5) 

   assert idx == 3231929
   assert res[5] == '1'

   res, idx = generate_hash_with_n_leading_zeros(test_door_id, idx+1, 5)

   assert idx == 5017308
   assert res[5] == '8'

   res, idx = generate_hash_with_n_leading_zeros(test_door_id, idx+1,5)

   assert idx == 5278568
   assert res[5] == 'f'

def test_get_door_code():
    door_code = get_door_code(test_door_id, 8)

    assert door_code == '18f47a30'

