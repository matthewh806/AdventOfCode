from definitions import INPUT_DIR
import re

def parse_ip_address(data):
    pattern = '\[(.*?)\]'
    hypernet_substrings = re.findall(pattern, data)
    ip_stripped = re.sub(pattern, '', data)
    ip_substrings = re.split('\[.*?\]', data)

    return ip_substrings, hypernet_substrings

def check_ip_supports_tls(ip):
    ip_plain_substr, hypernet = parse_ip_address(ip)

    if sum([check_for_abba(h) for h in hypernet]) > 0:
        return False

    return sum([check_for_abba(ip) for ip in ip_plain_substr]) > 0 

def check_for_abba(input_str):
    for i in range(0, len(input_str), 1):
        if i+4 > len(input_str):
            break
        sub_str = input_str[i:i+4]
        if sub_str[0] == sub_str[1]:
            continue
        
        if is_palindrome(sub_str):
            return True

    return False

def is_palindrome(input_str):
    return input_str == input_str[::-1]

if __name__ == "__main__":
    with open(INPUT_DIR + "day_07.txt") as f:
        data = [line.rstrip('\n') for line in f]
    print sum([check_ip_supports_tls(d) for d in data])

    for d in data:
        if check_ip_supports_tls(d):
            print d

