POISSOLVE_ROOT ?= ../..

BDD = $(shell pwd)
BD = $(BDD)/tmp_build_dir
export BLDDIR=$(BD)

include $(POISSOLVE_ROOT)/Build/Makefile_Build

.DEFAULT_GOAL := all

TARGET = TestInitialization
all: $(TARGET)

$(TARGET): \
	$(POISSOLV_OBJ_ABS) \
	$(OBJDIR)/$(TARGET).o
	$(FC) $(FFLAGS) -o $@.ex \
	$(POISSOLVE_OBJ_ABS) \
	$(OBJDIR)/$(TARGET).o

clean:
	rm -rf src
	rm -rf obj
	rm -rf *o
	rm -rf *mod
	rm -rf *ex
	rm -rf tmp_build_dir
	rm -rf Makefile_Driver

#-include $(BD)/Makefile_driver

$(OBJDIR)/TestInitialization.o: \
  $(OBJDIR)/KindModule.o \
  $(OBJDIR)/InitializationModule.o \
  TestInitialization.f90
