# MSX System 1.0

This directory contains the source code of the MSX System version 1.0.

## Dependencies

### z88dk

The code was adapted to be assembled by [z88dk](https://z88dk.org/site/). You can follow their [instructions to install in your system](https://github.com/z88dk/z88dk/wiki/installation). 

## Build

If you want to generate the ROM files for MSX System in every supported region, you can run:

```
make rom
```

This will assemble the source code one time per each supported region, and will save the output ROM in the `target/` directory with the name `target/msx-<lang>.rom`. It also generates object and listing files in `target/<lang>/` directory for each module of MSX System. 
