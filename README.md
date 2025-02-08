# FAKTUROPLUJKA #
## This time in lua!

### Install the required packages
```bash
make install
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
