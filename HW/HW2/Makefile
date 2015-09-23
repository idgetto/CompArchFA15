SRCEXT := v
SRCDIR := src
BUILDDIR := build
VCDEXT := vcd
SOURCES := $(shell find $(SRCDIR) -type f -name "*.$(SRCEXT)")
TARGETS := $(patsubst $(SRCDIR)/%.$(SRCEXT), $(BUILDDIR)/%, $(SOURCES))
VCDS := $(patsubst $(SRCDIR)/%.$(SRCEXT), $(BUILDDIR)/%.$(VCDEXT), $(SOURCES))

all: $(TARGETS)

$(BUILDDIR)/%: $(SRCDIR)/%.$(SRCEXT)
	mkdir -p $(BUILDDIR)
	iverilog $< -o $@ 

test: $(VCDS)

$(BUILDDIR)/%.$(VCDEXT): $(BUILDDIR)/%
	vvp $<

clean: 
	rm -f $(TARGETS) $(VCDS)

.PHONY: clean
