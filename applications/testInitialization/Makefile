POISSOLVE_ROOT ?= ../..
BD = $(shell pwd)
export BLDDIR=$(BD)

include $(POISSOLVE_ROOT)/build/Makefile_Build

.DEFAULT_GOAL := all

TARGET = testInitialization
all: $(TARGET)

$(TARGET): \
	$(POISSOLVE_OBJ) \
	$(TARGET).o
	$(FC) $(FFLAGS) -J $(OBJDIR) -o $@.ex \
	$(POISSOLVE_OBJ) \
	$(TARGET).o

clean:
	rm -rf src
	rm -rf obj
	rm -rf *o
	rm -rf *mod
	rm -rf *ex
	rm -rf tmp_build_dir
	rm -rf Makefile_Driver

#-include $(BD)/Makefile_driver

testInitialization.o: \
  KindModule.o \
  InitializationModule.o \
  testInitialization.f90
