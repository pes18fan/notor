# Notor

A simple terminal-based app that you can use to take and store short notes.

# Installation

## Linux

First, clone the repo.

```shell
git clone https://www.github.com/pes18fan141/notor.git
```

Go into the directory and install using `cmake` and `make`.

```shell
cd notor
cmake .
make
sudo make install
```

### Termux

For termux users, after cloning the repo, comment out or erase the set install path in `CMakeLists.txt` and uncomment the line 3 lines below it that defines the path as the termux bin path. After that run `cmake` and `make` same as above.

## Windows

The Windows `.exe` file is available in the releases section of this repository.

# Usage

Type in `notor new` to create a new note. Enter a title first, which will be what your note will get saved as, and afterward whatever you wish to enter. Press `Ctrl+O` after you're done to save the note.

You can run `notor help` to get a guide to some basic commands usable in the app.
