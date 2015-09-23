SRCEXT := v
VCDEXT := vcd
SOURCES := $(shell find . -type f -name "*.$(SRCEXT)")
TARGETS := $(patsubst %.$(SRCEXT), %, $(SOURCES))
VCDS := $(patsubst %.$(SRCEXT), %.$(VCDEXT), $(SOURCES))

all: $(TARGETS)

%: %.$(SRCEXT)
	iverilog $< -o $@ 

test: $(VCDS)

%.$(VCDEXT): %
	vvp $<

clean: 
	rm -f $(TARGETS) $(VCDS)

.PHONY: clean
