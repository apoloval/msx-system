TARGETS=jp us int uk fr de it es ar ko ru

sources=$(wildcard *.asm)
includes=$(wildcard *.inc)
roms=$(patsubst %,target/msx-%.rom,$(TARGETS))
symbols=$(patsubst %,target/msx-%.symbol,$(TARGETS))
hexes=$(patsubst %,target/msx-%.hex,$(TARGETS))

country_code_jp=0
country_code_us=1
country_code_int=2
country_code_uk=3
country_code_fr=4
country_code_de=5
country_code_it=6
country_code_es=7
country_code_ar=8
country_code_ko=9
country_code_ru=10

.PHONY: all
all: rom hex

.PHONY: rom
rom: $(roms)

.PHONY: hex
hex: $(hexes)

target/msx-%.rom: $(sources) $(includes)
	mkdir -p target/
	pasmo --equ CNTRY=$(country_code_$*) -I ../basekey/ -I ../basechr msx.asm target/msx-$*.rom target/msx-$*.symbol

%.hex: %.rom
	hexyl --color never $< > $@

.PHONY: clean
clean:
	rm -rf $(roms) $(symbols) $(hexes)
