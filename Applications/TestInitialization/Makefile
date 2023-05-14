POISSOLVE_ROOT ?= ../..
BD = $(shell pwd)
export BLDDIR=$(BD)

include $(POISSOLVE_ROOT)/Build/Makefile_Build

.DEFAULT_GOAL := all

TARGET = TestInitialization
all: $(TARGET)

$(TARGET): \
	$(POISSOLVE_OBJ) \
	$(TARGET).o
	$(FC) $(FFLAGS) -o $@.ex \
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

TestInitialization.o: \
  KindModule.o \
  InitializationModule.o \
  TestInitialization.f90
