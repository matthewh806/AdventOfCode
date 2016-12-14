import advent_of_code_2016.day_14 as day_14

def test_get_first_repeated_substr_contains_none():
    o = day_14.get_first_repeated_substr('ABC', ['AAA', 'BBB'])
    assert o == None

def test_get_first_repeated_substr_contains_str():
    o = day_14.get_first_repeated_substr('dnasjhgdfgvAAAjhdasjhdga', ['AAA'])
    assert o == 'AAA'

def test_get_first_repeated_substr_contains_str_gets_first():
    o = day_14.get_first_repeated_substr('dnasjhgdfgvAAAjhdasjhCCCdga', ['AAA',
                                                                        'CCC'])
    assert o == 'AAA'

def test_get_first_repeated_substr_contains_str_correct_order():
    o = day_14.get_first_repeated_substr('dajhsdgaCCCjfgahgdaAAAdasjhdg',
                                         ['AAA', 'CCC'])
    assert o == 'CCC'

def test_get_first_repeated_substr_contains_str_gets_in_longer_str():
    o = day_14.get_first_repeated_substr('fkjhasdgaAAAAAsdkjfsdfg', ['AAA'])
    assert o == 'AAA'

def test_generate_md5_hashes_one():
    h, idx = day_14.generate_md5_hashes('abc', 1)
    assert idx==39 
    assert len(h) == 1

def test_generate_md5_hashes_two():
    h, idx = day_14.generate_md5_hashes('abc', 2)
    assert idx==92 
    assert len(h) == 2

def test_generate_md5_hashes_sixty_four():
    h, idx = day_14.generate_md5_hashes('abc', 64)
    assert len(h) == 64
    assert idx==22728 
