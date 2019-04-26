roms=msx.rom

targets=$(patsubst %,target/%,$(roms))


all: $(targets)

target:
	mkdir -p target/

target/msx.rom: target
	pasmo -I ../basekey/ -I ../basechr msx.asm target/msx.rom

clean:
	rm -rf target/

.PHONY: all clean
