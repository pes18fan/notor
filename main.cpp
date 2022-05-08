#include <iostream>
#include <string>
#include <stdlib.h>
#include <string.h>
#include <ncurses.h>
#include "flags.h"

void endRun();

class Notes {
    public:
	std::string title;
	std::string subject;
};

int main(int argc, char** argv) {
    if (argv[1] != NULL) {
	flags(argc, argv);
	return 0;
    }

    initscr();
    raw();

    printw("Welcum to da notes manager! Currently there's no functionality here whatsoever so please come back later :)");

    endRun();

    return 0;
}

void endRun() {
    getch();
    endwin();
}
