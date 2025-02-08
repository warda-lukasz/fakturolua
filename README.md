# FAKTUROPLUJKA #
## This time in lua!

## Prerequisites
- Lua 5.3
- LuaRocks
  - inspect
  - lyaml
- texlive
- texlive-lang-polish

### Chceck if you have dependencies installed
```bash
make deps-check
```

### Install the required packages
```bash
make deps-install
```
### Run the program
```bash
lua makeFv.lua

```
or

```bash
./makeFV.lua

```
#### Rendering inactive invoices

If you want to render inactive invoices, you can run the program with the `inactive` argument.
To make invoice active, you can change the `active` field in the invoice in `parameters.yaml` file.

```bash
./makeFV.lua inactive
```
