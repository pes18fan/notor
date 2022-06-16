EXEC_NAME = notor
DATA_FOLDER = $(HOME)/.notor
TARGET = ./bin/debug/notor
RELEASE = ./bin/release/notor
INSTALL = /usr/local/bin

.PHONY: all
all: debug

.PHONY: debug
debug: ./src/**
	@mkdir -p bin/debug/ || true
	@echo "Compiling..."
	@crystal build src/main.cr -o $(TARGET)
	@echo "Successfully compiled!"

.PHONY: clean
clean:
	@$(RM) bin/debug/** bin/release/**
	@echo "Binaries cleaned."

.PHONY: release
release:
	@mkdir -p bin/release/ || true
	@echo "Compiling..."
	@crystal build --release src/main.cr -o $(RELEASE)
	@echo "Finished compiling! Run 'sudo make install' to install."

.PHONY: install
install:
	@mv $(RELEASE) $(INSTALL)
	@echo '# This is an autogenerated uninstall script for the terminal app notor.\n# You may run this script to uninstall notor.\nINSTALL=$(INSTALL)' >> uninstall.sh
	@echo 'rm -rf $(DATA_FOLDER)\n$(RM) $$INSTALL/$(EXEC_NAME)\necho "Successfully uninstalled!"' >> uninstall.sh
	@echo "Successfully installed!"

.PHONY: uninstall
uninstall:
	@sh uninstall.sh
	@$(RM) uninstall.sh
