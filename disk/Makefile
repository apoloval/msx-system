drivers=\
	vy0010

roms=$(patsubst %,target/%.rom,$(drivers))


all: $(roms)

target:
	mkdir -p target/

target/vy0010.rom: drivers/vy0010/driver.asm bios/1.0/disk_840620.asm target/
	pasmo -I $(<D) bios/1.0/disk_840620.asm $@

clean:
	rm -rf target/

.PHONY: all clean
