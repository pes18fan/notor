#include "options.h"
#include <iostream>
#include <string>
#include <string.h>
#include <stdlib.h>

void parseOptions(int argc, char** argv) {
    if (strcmp(argv[1], "ver") == 0) {
        std::cout << "Notor version 0.0.1" << std::endl;
        std::cout << "Written by pes18fan, 2022." << std::endl;
    } else if (strcmp(argv[1], "pog") == 0) {
        std::cout << "Poggers!" << std::endl;
    } else if (strcmp(argv[1], "help") == 0) {
	std::cout << "Usage: notor [OPTIONS]\n" << std::endl;
	std::cout << "These are the various usable commands for notor: \b" << std::endl;

	std::cout << "\tver\tPrint the version info and exit." << std::endl;
	std::cout << "\tpog\tPoggers!" << std::endl;
	std::cout << "\thelp\tDisplay this help message and exit.\n" << std::endl;

	std::cout << "Notor version 0.0.1" << std::endl;
	std::cout << "Written by pes18fan, 2022." << std::endl;
    } else {
        std::cout << "Invalid argument \"" << argv[1] << "\"" << std::endl;
    }  
}
