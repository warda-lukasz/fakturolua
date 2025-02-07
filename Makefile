install:
	@echo "Installing..."
	@echo "#########################"
	sudo apt install libyaml-dev
	sudo apt install luarocks
	sudo luarocks install lyaml
	sudo luarocks install inspect
	@echo "#########################"
	@echo "Done."

