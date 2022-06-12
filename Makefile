EXEC_NAME = notor
TARGET = ./bin/debug/notor
RELEASE = ./bin/release/notor
INSTALL = /usr/local/bin

all:
	crystal build src/main.cr -o $(TARGET)

clean:
	$(RM) bin/debug/* bin/release/*

release:
	@echo "Compiling..."
	@crystal build --release src/main.cr -o $(RELEASE)
	@echo "Finished compiling! Run 'sudo make install' to install!"

install:
	@mv $(RELEASE) $(INSTALL)
	@echo "Successfully installed!"

uninstall:
	@$(RM) $(INSTALL)/$(EXEC_NAME)
	@echo "Successfully uninstalled!"
