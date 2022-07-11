# notor

A terminal app for taking notes.

## Installation

You can get the prebuilt binary for `linux_x86_64` in the releases section of this repository.

To build and install `notor`, follow the given steps:

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

## Uninstallation

If you built and installed the app using `make`, an uninstall script named `uninstall.sh` is created automatically. You can simply run that script to uninstall notor, or run `sudo make uninstall` in the source directory, both will do the same thing.

If you do not have the uninstall script, possibly due to installation without `make`, you can remove the binary named `notor` directly from the install path, and remove the hidden folder `.notor` in the home directory if you want to delete your notes and configuration as well.

## Usage

You can run `notor --help` to get a guide to the basic usage for the app. While using notor, you generally run the executable along with some subcommand, optional flags and arguments. The subcommands that you'll find yourself using include:

- `new`: Creates a new note with the specified title and content.

```bash
$ notor new foo bar # foo is the title and bar is the content
New note foo created!
$ notor new "foo bar" "baz thud" # use quotes if title and/or content have more than one word
New note foo bar created!
```

- `cat`: Displays the content of the specified note.

```bash
$ notor cat foo
NOTE TITLE: foo

bar
```

- `edit`: Opens the specified note for editing in the default text editor. Optionally, you can also specify the editor to use.

```bash
$ notor edit foo vim # opens foo in vim, where you can edit the title and content, then close the window to save changes.
$ notor edit "foo bar" # opens "foo bar" in default editor
```

- `del`: Deletes the specified note..

```bash
$ notor del foo
Note "foo" deleted.
$ notor del thud
Note "thud" not found.
```

- `list`: Lists the notes currently existing in a tabular form (kudos to [tablo](https://www.github.com/hutou/tablo/)).
```bash
$ notor list
2 notes present.
All notes:
+------+--------------------------------+----------------+
| S.N  | Created on                     | Title          |
+------+--------------------------------+----------------+
| 1    | 2022/07/11 04:43:27 PM Mon     | foo            |
| 2    | 2022/07/11 04:43:40 PM Mon     | foo bar        |
+------+--------------------------------+----------------+
```

- `reset`: Deletes all notes.
```bash
$ notor reset
All notes deleted.
```

## Configuration

`notor` provides a few configuration options:

- `editor`: Determines the default editor used in `notor edit` commands.
- `pager`: Determines the pager used to display content when `notor cat` is invoked with the `-p` flag.
- `paging`: Determines if paging is always used to display content. `false` by default.

These configuration options can be set to the user's liking using the `notor conf` subcommand. For example:

```bash
$ notor conf editor vim # sets vim as the default editor
$ notor conf pager less # sets less as the default pager
$ notor conf paging true # always use the pager
```

## Contributing

1. Fork it (<https://github.com/pes18fan141/notor/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new pull request

## Contributors

- [pes18fan141](https://github.com/pes18fan141) - creator and maintainer
