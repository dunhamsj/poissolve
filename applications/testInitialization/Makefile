VPATH_LOCATIONS += $(shell pwd)

include $(POISSOLVE_ROOT)/build/Make.VPATH

SRCDIR := $(shell pwd)/src
OBJDIR := $(shell pwd)/obj

$(shell mkdir -p $(OBJDIR))
$(shell mkdir -p $(SRCDIR))
$(shell python3 $(POISSOLVE_ROOT)/build/buildDependencies.py)

OBJ := $(shell cat $(OBJDIR)/objFiles)
SRC := $(shell cat $(SRCDIR)/srcFiles)

TARGET = testInitialization

all: $(TARGET)

include $(POISSOLVE_ROOT)/build/Makefile_Poissolve_ObjectFiles
include $(POISSOLVE_ROOT)/build/Makefile_Poissolve_Dependencies
include $(POISSOLVE_ROOT)/build/Makefile_rules

$(TARGET): $(POISSOLVE_OBJ)
	@echo
	@echo "== LINKING EXECUTABLE $(TARGET)"
	$(FC) $(FFLAGS) $< -o $@.ex $(POISSOLVE_OBJ)
	@echo

clean:
	rm -rf $(SRCDIR)
	rm -rf $(OBJDIR)
	rm -rf *mod
	rm -rf *ex
