// this file does all the parsing for the commandline arguments. 
// that will likely be replaced soon with a more effective solution like gflags or getopt
#include "options.h"
#include <iostream>
#include <string>
#include <string.h>
#include <stdlib.h>

void parseOptions(int argc, char** argv) {
    if (argc < 3) {
	if (strcmp(argv[1], "ver") == 0) {
	    ver();
	}  else if (strcmp(argv[1], "help") == 0) {
	    help();
	} else if (strcmp(argv[1], "create") == 0) {
	    create();
	} else {
	    std::cout << "Invalid argument \"" << argv[1] << "\"" << std::endl;
	}
    } 
}

void ver() {
    std::cout << "Notor version 0.0.1" << std::endl;
    std::cout << "Written by pes18fan, 2022." << std::endl;
}

void help() {
    std::cout << "Usage: notor [OPTIONS]\n" << std::endl;
    std::cout << "These are the various usable commands for notor: \b" << std::endl;

    std::cout << "\tver\tPrint the version info and exit." << std::endl;
    std::cout << "\thelp\tDisplay this help message and exit.\n" << std::endl;
    std::cout << "\tcreate\tCreate a new note.\n" << std::endl;

    std::cout << "Notor version 0.0.1" << std::endl;
    std::cout << "Written by pes18fan, 2022." << std::endl;
}

void create() {
    std::cout << "No functionality currently for reserved argument \"create\"" << std::endl;
}
