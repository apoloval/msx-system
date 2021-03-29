TARGETS=jp us int uk fr de it es ar ko ru

includes=$(wildcard *.def) $(wildcard ../basekey/*.asm) $(wildcard ../basechr/*.asm)
sources=bios.asm basic1.asm basic2.asm # Order is relevant

objects=$(foreach target,$(TARGETS),$(patsubst %.asm,target/$(target)/%.o,$(sources)))
listings=$(patsubst %.o,%.lis,$(objects))
roms=$(patsubst %,target/msx-%.rom,$(TARGETS))

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

.PHONY: assembly
assembly: $(objects)

.PHONY: clean
clean:
	rm -rf $(roms) $(objects) $(listings) 

.SECONDEXPANSION:
$(objects): target/%.o: $$(word 2,$$(subst /, ,$$*)).asm $(includes)
	z80asm -I../basekey/ -I../basechr -DCNTRY=$(country_code_$(word 1,$(subst /, ,$*))) -Otarget/$(word 1,$(subst /, ,$*)) -l $<

$(roms): target/msx-%.rom: $(patsubst %.asm,target/$$*/%.o,$(sources))
	z80asm -o$@ -b $^
