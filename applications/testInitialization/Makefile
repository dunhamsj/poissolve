VPATH_LOCATIONS += $(shell pwd)

include $(POISSOLVE_ROOT)/build/Make.VPATH

SRCDIR := src
OBJDIR := obj

$(shell mkdir -p $(OBJDIR))
$(shell mkdir -p $(SRCDIR))
$(shell python ${POISSOLVE_ROOT}/build/buildDependencies.py)

TARGET = testInitialization

all: $(TARGET)

OBJ := $(shell cat $(OBJDIR)/objFiles)
SRC := $(shell cat $(SRCDIR)/srcFiles)

$(TARGET): $(OBJDIR)/$(OBJ)
	@echo "== LINKING EXECUTABLE $(TARGET)"
	@$(FC) $(FFLAGS) $< -o $@

$(OBJDIR)/$(OBJ): $(SRCDIR)/$(SRC)
	@echo "COMPILING SOURCE $< INTO OBJECT $@"
	$(FC) $(FFLAGS) -o $@ -c $<

clean:
	rm -rf $(SRCDIR)
	rm -rf $(OBJDIR)
	rm -rf *_$(POISSOLVE_MACHINE)
