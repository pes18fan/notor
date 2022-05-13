# Notor

A simple terminal-based app that you can use to take and store short notes.

# Installation

## Linux

__ncurses and cmake required to build from source.__

First, clone the repo.

```bash
git clone https://www.github.com/pes18fan141/notor.git
```

Go into the directory, make a build folder, move to it and install using `cmake` and `make`.

```bash
cd notor && mkdir build && cd build
cmake ..
make
sudo make install
```
You might want to change your install path before installation. To do so, simply change the default path set as `/usr/local/bin` to whatever path you wish in line 14 of the `CMakeLists.txt` file and then install.

## Windows

The Windows `.exe` file is available in the releases section of this repository.

# Usage

Type in `notor create` to create a new note. Enter a title first, which will be what your note will get saved as, and afterward whatever you wish to enter. Press `Ctrl+O` after you're done to save the note.

You can run `notor help` to get a guide to some basic commands usable in the app.
