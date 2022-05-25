# Notor

A simple terminal-based app that you can use to take and store short notes.

## Installation

### Linux

Install [Crystal](https://crystal-lang.org/install/) first to build the app.

Then, clone the repo.

```bash
git clone https://www.github.com/pes18fan141/notor.git
```

Go into the directory and build and install as follows.

```bash
cd notor
shards install
make release
sudo make install
```

By default, the binary will install to the path `/usr/local/bin`. To change that, change the final `sudo make install` command to `sudo make INSTALL=<path> install` where you replace `<path>` with the install path of your choice.

### Windows

The Windows `.exe` file is available in the releases section of this repository.

## Usage

Type in `notor new` to create a new note. Enter a title first, which will be what your note will get saved as, and afterward whatever you wish to enter. Press `Ctrl+O` after you're done to save the note.

You can run `notor help` to get a guide to some basic commands usable in the app.

## Contributing

1. Fork it (<https://github.com/pes18fan141/notor/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [pes18fan](https://github.com/pes18fan141) - creator and maintainer
