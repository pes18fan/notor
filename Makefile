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
	mv $(RELEASE) $(INSTALL)

uninstall:
	$(RM) $(INSTALL)/$(EXEC_NAME)
