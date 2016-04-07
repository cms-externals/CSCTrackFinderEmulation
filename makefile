CXX:=c++
CXXFLAGS:=-Wall -fPIC -O1 -pthread -pipe -std=c++14 -ftree-vectorize -fvisibility-inlines-hidden -fno-math-errno -fipa-pta -felide-constructors
LDFLAGS:=-shared

UNAME_P := $(shell uname -p)
ifeq ($(UNAME_P),x86_64)
CXXFLAGS+=-msse3
endif

UNAME_S := $(shell uname -s)
SHAREDSUFFIX := so
ifeq ($(UNAME_S),Darwin)
SHAREDSUFFIX := dylib
endif

BASE_DIR:=L1Trigger/CSCTrackFinder
SOURCE_DIR:=$(BASE_DIR)/src
DATA_DIR:=$(BASE_DIR)/data
SOURCES:=$(shell find . -name '*.cpp')
OBJS:=$(addprefix objs/,$(patsubst %.cpp,%.o,$(SOURCES)))
INC_DIR:=$(CURDIR)/include
LOCAL_LIB:=lib64
TARGET:=$(LOCAL_LIB)/libCSCTrackFinderEmulation.$(SHAREDSUFFIX)
INSTALL_DIR:=installDir
LOCAL_MKDIRS:=$(shell mkdir -p $(LOCAL_LIB))

all: $(TARGET)

clean:
	rm -rf $(LOCAL_LIB) $(INSTALL_DIR)

install: all
	mkdir -p $(INSTALL_DIR) $(INSTALL_DIR)/include/$(BASE_DIR) $(INSTALL_DIR)/data/$(BASE_DIR)
	rsync -a $(LOCAL_LIB) $(INSTALL_DIR)
	rsync -a $(SOURCE_DIR) $(INSTALL_DIR)/include/$(BASE_DIR) --exclude *.cpp
	rsync -a $(DATA_DIR) $(INSTALL_DIR)/data/$(BASE_DIR)

objs/%.o : %.cpp
	@[ -d $(@D) ] || mkdir -p $(@D)
	$(CXX) -c -I$(INC_DIR) $(CXXFLAGS) -o $@ $^

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $(LDFLAGS) $(OBJS)
