from advent_of_code_2016.day_07 import parse_ip_address, \
                                       check_ip_supports_tls, check_for_abba, \
                                       is_palindrome, \
                                       get_aba_sequences, check_ip_supports_ssl

t1 = 'abba[mnop]qrst'
t2 = 'abcd[bddb]xyyx'
t3 = 'aaaa[qwer]tyui'
t4 = 'ioxxoj[asdfgh]zxcvbn'
t5 = 'woofab[mnop]batyui'
t6 = 'lknaffpzamlkufgt[uvdgeatxkofgoyoi]ajtqcsfdarjrddrzo[bxrcozuxifgevmog]rlyfschtnrklzufjzm'

def test_parse_ip_address():
    t1_p, t1_h = parse_ip_address(t1)
    t2_p, t2_h = parse_ip_address(t2)
    t3_p, t3_h = parse_ip_address(t3)
    t4_p, t4_h = parse_ip_address(t4)

    t6_p, t6_h = parse_ip_address(t6)

    assert t1_p[0] == 'abba' and t1_p[1] == 'qrst' and t1_h[0] == 'mnop'
    assert t2_p[0] == 'abcd' and t2_p[1] == 'xyyx' and t2_h[0] == 'bddb'
    assert t3_p[0] == 'aaaa' and t3_p[1] == 'tyui' and t3_h[0] == 'qwer'
    assert t4_p[0] == 'ioxxoj' and t4_p[1] == 'zxcvbn' and t4_h[0] == 'asdfgh'
    
    assert t6_p[0] == 'lknaffpzamlkufgt' and t6_p[1] == 'ajtqcsfdarjrddrzo' \
            and t6_p[2] == 'rlyfschtnrklzufjzm'
    assert t6_h[0] == 'uvdgeatxkofgoyoi' and t6_h[1] == 'bxrcozuxifgevmog'

def test_is_palindrome():
    assert not is_palindrome('abc')
    assert is_palindrome('aaa')
    assert is_palindrome('abba')

def test_check_for_abba():
    assert not check_for_abba('mnop')
    assert not check_for_abba('woof')
    assert check_for_abba('abba')
    assert not check_for_abba('aaaa')
    assert check_for_abba('abbaqrst')
    assert check_for_abba('abcdxyyx')

def test_check_ip_supports_tls():
    assert check_ip_supports_tls(t1)
    assert not check_ip_supports_tls(t2)
    assert not check_ip_supports_tls(t3)
    assert check_ip_supports_tls(t4)
    assert not check_ip_supports_tls(t5)

def test_check_for_aba():
    assert get_aba_sequences('aba')[0] == 'aba'
    assert len(get_aba_sequences('aaa')) == 0 
    assert len(get_aba_sequences('a')) == 0
    assert len(get_aba_sequences('abba')) == 0
    assert len(get_aba_sequences('zazbz')) == 2
    
def test_check_ip_supports_ssl():
    assert check_ip_supports_ssl('aba[bab]xyz')
    assert not check_ip_supports_ssl('xyx[xyx]xyx')
    assert check_ip_supports_ssl('aaa[kek]eke')
    assert not check_ip_supports_ssl('aaa[aaa]eke')
    assert check_ip_supports_ssl('zazbz[bzb]cdb')
    assert not check_ip_supports_ssl('gdlrknrmexvaypu[crqappbbcaplkkzb]vhvkjyadjsryysvj[nbvypeadikilcwg]jwxlimrgakadpxu[dgoanojvdvwfabtt]yqsalmulblolkgsheo')
