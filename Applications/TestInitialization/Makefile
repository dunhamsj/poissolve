POISSOLVE_ROOT ?= ../..

BDD = $(shell pwd)
BD = $(BDD)/tmp_build_dir
export BLDDIR=$(BD)

include $(POISSOLVE_ROOT)/Build/Makefile_Build

.DEFAULT_GOAL := all

TARGET = TestInitialization
all: $(TARGET)

$(TARGET): \
	$(POISSOLV_OBJ) \
	$(OBJDIR)/$(TARGET).o
	@echo
	@echo "LINKING $@"
	$(FC) $(FFLAGS) -o $@.ex \
	$(POISSOLVE_OBJ) \
	$(OBJDIR)/$(TARGET).o
	@echo
	@echo "Executable $(TARGET).ex created successfully!"
	@echo

clean:
	rm -f *ex
	rm -rf tmp_build_dir/

$(OBJDIR)/TestInitialization.o: \
  $(OBJDIR)/KindModule.o \
  $(OBJDIR)/InitializationModule.o \
  TestInitialization.f90
