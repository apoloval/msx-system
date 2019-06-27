roms=msx.rom

targets=$(patsubst %,target/%,$(roms))


all: $(targets)

target/msx.rom:
	mkdir -p target/
	pasmo -I ../basekey/ -I ../basechr msx.asm target/msx.rom target/msx.symbol
	hexyl --color never target/msx.rom > target/msx.rom.hex

clean:
	rm -rf $(targets)

.PHONY: all clean
