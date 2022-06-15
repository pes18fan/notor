EXEC_NAME = notor
DATA_FOLDER = $(HOME)/.notor
TARGET = ./bin/debug/notor
RELEASE = ./bin/release/notor
INSTALL = /usr/local/bin

all:
	@mkdir -p bin/debug/ || true
	@crystal build src/main.cr -o $(TARGET)
	@echo "Successfully compiled!"

clean:
	@$(RM) bin/debug/** bin/release/**
	@echo "Binaries cleaned."

release:
	@mkdir -p bin/release/ || true
	@echo "Compiling..."
	@crystal build --release src/main.cr -o $(RELEASE)
	@echo "Finished compiling! Run 'sudo make install' to install."

install:
	@mv $(RELEASE) $(INSTALL)
	@echo "Successfully installed!"

uninstall:
	@rm -rf $(DATA_FOLDER)
	@$(RM) $(INSTALL)/$(EXEC_NAME)
	@echo "Successfully uninstalled!"
