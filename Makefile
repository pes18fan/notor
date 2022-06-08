EXEC_NAME = notor
TARGET = ./bin/debug/notor
RELEASE = ./bin/release/notor
INSTALL = /usr/local/bin

all:
	crystal build src/main.cr -o $(TARGET)

clean:
	$(RM) bin/debug/* bin/release/*

release:
	crystal build --release src/main.cr -o $(RELEASE)

install:
	mkdir $(HOME)/.notor
	mv $(RELEASE) $(INSTALL)
	echo "Successfully installed! If you got a cannot create directory error, don't worry, the program will work just fine. Enjoy!"

uninstall:
	$(RM) $(INSTALL)/$(EXEC_NAME)
