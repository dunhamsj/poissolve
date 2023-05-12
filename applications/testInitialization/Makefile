VPATH_LOCATIONS += $(shell pwd)

include $(POISSOLVE_ROOT)/build/Make.VPATH

SRCDIR := src
OBJDIR := obj

$(shell mkdir -p $(OBJDIR))
$(shell mkdir -p $(SRCDIR))
$(shell python3 $(POISSOLVE_ROOT)/build/buildDependencies.py)

OBJ := $(shell cat $(OBJDIR)/objFiles)
SRC := $(shell cat $(SRCDIR)/srcFiles)

TARGET = testInitialization

VPATH = . $(SRCDIR)

TARGET_DEPS = $(patsubst %, $(OBJDIR)/%, $(OBJ))

all: $(TARGET_DEPS) $(TARGET)

include $(OBJDIR)/Make.rules

$(TARGET): $(TARGET_DEPS)
	@echo
	@echo "== LINKING EXECUTABLE $(TARGET)"
	$(FC) $(FFLAGS) $< -o $@.ex $(TARGET_DEPS)
	@echo

clean:
	rm -rf $(SRCDIR)
	rm -rf $(OBJDIR)
	rm -rf *mod
	rm -rf *ex
