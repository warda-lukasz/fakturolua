deps-install:
	@echo "Installing..."
	@echo "#########################"
	sudo apt install texlive
	sudo apt install texlive-lang-polish
	sudo apt install libyaml-dev
	sudo apt install luarocks
	sudo luarocks install lyaml
	sudo luarocks install inspect
	@echo "#########################"
	@echo "Done."

deps-check:
	@echo "Checking dependencies..."
	@dpkg -l | grep -q texlive || (echo "texlive is not installed"; exit 1)
	@dpkg -l | grep -q texlive-lang-polish || (echo "texlive-lang-polish is not installed"; exit 1)
	@dpkg -l | grep -q libyaml-dev || (echo "libyaml-dev is not installed"; exit 1)
	@dpkg -l | grep -q luarocks || (echo "luarocks nie is not installed"; exit 1)
	@luarocks list lyaml | grep -q lyaml  || (echo "lyaml is not installed"; exit 1)
	@luarocks list inspect |grep -q inspect || (echo "inspect in not installed"; exit 1)
	@echo "All dependenies are installed. All good."
