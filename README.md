# 🚀 FAKTUROLUA 🚀 #
It's just like [fakturoplujka](https://github.com/warda-lukasz/fakturoplujka), but this time in lua (and so much faster) 🧠!
## Prerequisites 
- make
- Lua 5.3
- LuaRocks
  - lyaml
- texlive
- texlive-lang-polish
### Chceck if you have dependencies installed 🔍
```bash
make deps-check
```
### Install the required packages 🎰
```bash
make deps-install
```
### Copy the parameters file 📄 
```bash
cp config/parameters.yaml.dist config/parameters.yaml
```
## Run the program 🚀
```bash
lua makeFV.lua
```
or
```bash
./makeFV.lua
```
#### Rendering inactive invoices or starting from a specific number 🤔
If you want to render inactive invoices, you can run the program with the `true` or `false` argument.
To make invoice active, you can change the `active` field in the invoice in `parameters.yaml` file.
```bash
./makeFV.lua true
```
If you want to start rendering from a specific number of invoice, you can run the program with the int in the second argument.
```bash
./makeFV.lua false 5
```
