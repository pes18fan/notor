# notor

A simple terminal-based app that you can use to take and store short notes.

## Installation

Follow the following instructions to build and install the app.

Install [Crystal and Shards (Crystal's package manager)](https://crystal-lang.org/install/) first to build the app.

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

## Uninstalling

If you installed the app using `make`, an uninstall script named `uninstall.sh` is created automatically. You can simply run that script to uninstall notor, or run `sudo make uninstall` in the source directory, both will do the same thing.

If you do not have the uninstall script, possibly due to installation without `make`, you can remove the binary named `notor` directly from the install path, and remove the hidden folder `.notor` in the home directory if you want to delete your notes as well.

## Usage

You can run `notor --help` to get a guide to the basic usage for the app. While using notor, you generally run the executable along with some subcommand, optional flags and arguments. A few common subcommands that you'll find yourself using include:

- `new`: Takes the title and content of the note as arguments and creates a new note.
- `cat`: Takes the title of an existing note as an argument and displays it's content.
- `del`: Takes the title of an existing note as an argument and deletes the note.
- `list`: Lists the notes currently existing.

## Contributing

1. Fork it (<https://github.com/pes18fan141/notor/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new pull request

## Contributors

- [pes18fan](https://github.com/pes18fan141) - creator and maintainer