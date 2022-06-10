# Notor

A simple terminal-based app that you can use to take and store short notes.

## Installation

Follow the following instructions to build and install the app.

Install [Crystal](https://crystal-lang.org/install/) first to build the app.

Then, clone the repo.

```bash
git clone https://www.github.com/pes18fan141/notor.git
```

Go into the directory and build and install as follows.

```bash
cd notor
mkdir -p bin/release/
shards install
make release
sudo make install
```

By default, the binary will install to the path `/usr/local/bin`. To change that, change the final `sudo make install` command to `sudo make INSTALL=<path> install` where you replace `<path>` with the install path of your choice.

## Usage

You can run `notor --help` to get a guide to some basic commands usable in the app.

## Uninstalling

Go into the source directory that you cloned from GitHub while installing the app, and run the given command:

```bash
sudo make uninstall
```

If the source directory does not exist anymore, you can remove the binary named `notor` directly from the install path.

## Contributing

1. Fork it (<https://github.com/pes18fan141/notor/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [pes18fan](https://github.com/pes18fan141) - creator and maintainer
