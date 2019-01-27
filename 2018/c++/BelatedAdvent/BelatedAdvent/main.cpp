//
//  main.cpp
//  BelatedAdvent
//
//  Created by Matthew on 26/01/2019.
//  Copyright © 2019 Matthew. All rights reserved.
//

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <set>
#include <regex>

int caclulate_resulting_frequency(const std::vector<int> in_operations, int f_0 = 0) {
    for(auto o : in_operations) {
        f_0 += o;
    }
    
    return f_0;
}

int find_first_repeat_frequency(const std::vector<int> in_operations, int f_0 = 0) {
    
    std::set<int> frequencies;
    bool repeat = true;
    
    while(repeat) {
        for(auto o:in_operations) {
            f_0 += o;
            
            if(frequencies.find(f_0) != frequencies.end()) {
                repeat = false; // or just break?
                break;
            }
            frequencies.insert(f_0);
        }
    }
    
    // error
    return f_0;
}

int main(int argc, const char * argv[]) {
    std::vector<int> operations;
    
    int starting_freq = 0; // Hz <--- does it matter? xD
    std::string line;
    std::ifstream input("input_01.txt");
    
    // TODO: Abstract away reading the input
    if(!input.is_open()) {
        std::cout << "Error opening input file!" << std::endl;
        return 0;
    }
    
    int num_lines = 0;
    while(std::getline(input, line)) {
        operations.push_back(std::stoi(line, nullptr));
        num_lines++;
    }
    
    std::cout << "No. lines: " << num_lines << std::endl;
    std::cout << "Final frequency: " << caclulate_resulting_frequency(operations, starting_freq) << std::endl;
    std::cout << "First repeated: " << find_first_repeat_frequency(operations, starting_freq) << std::endl;
    
    // TODO: Remember to close the file!
    input.close();
    
    return 0;
}
