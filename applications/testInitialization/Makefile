VPATH_LOCATIONS += .

include $(POISSOLVE_ROOT)/build/Make.VPATH

TARGET = testInitialization

all: build $(TARGET)

SRCDIR := src
OBJDIR := obj

build:
	@echo ${VPATH}
	@mkdir -p $(OBJDIR)
	@mkdir -p $(SRCDIR)
	@python3 $(POISSOLVE_ROOT)/build/buildDependencies.py

ifneq ("$(wildcard $(OBJDIR)/objFiles)","")
  OBJ := $(shell cat $(OBJDIR)/objFiles)
endif
ifneq ("$(wildcard $(SRCDIR)/srcFiles)","")
  SRC = $(shell cat $(SRCDIR)/srcFiles)
endif

$(TARGET): $(OBJDIR)/$(OBJ)
	@echo "== LINKING EXECUTABLE $(TARGET)"
	@$(FC) $(FFLAGS) $< -o $@

$(OBJDIR)/%.o: $(SRC)
	@echo "COMPILING SOURCE $< INTO OBJECT $@"
	$(FC) $(FFLAGS) -o $@ -c $<

clean:
	rm -rf $(SRCDIR)
	rm -rf $(OBJDIR)
	rm -rf *_$(POISSOLVE_MACHINE)
