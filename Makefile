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
	@echo '# This is an autogenerated uninstall script.\n# Please do not run this script manually.\nINSTALL=$(INSTALL)' >> uninstall.sh
	@echo "Successfully installed!"

uninstall:
	@echo 'rm -rf $(DATA_FOLDER)\n$(RM) $$INSTALL/$(EXEC_NAME)\necho "Successfully uninstalled!"' >> uninstall.sh
	@sh uninstall.sh
	@$(RM) uninstall.sh
