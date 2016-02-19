CXX=g++
CXXFLAGS=-Wall -fPIC -O1
LDFLAGS=-shared
BASE_DIR=L1Trigger/CSCTrackFinder
SOURCE_DIR=$(BASE_DIR)/src
DATA_DIR=$(BASE_DIR)/data
SOURCES=$(shell find . -name '*.cpp')
INC_DIR=$(CURDIR)/include
LOCAL_LIB=lib64
TARGET=$(LOCAL_LIB)/libCSCTrackFinderEmulation.so
INSTALL_DIR=installDir
LOCAL_MKDIRS:=$(shell mkdir -p $(LOCAL_LIB))

all: $(TARGET)

clean:
	rm -rf $(LOCAL_LIB) $(INSTALL_DIR)

install: all
	mkdir -p $(INSTALL_DIR) $(INSTALL_DIR)/include/$(BASE_DIR) $(INSTALL_DIR)/data/$(BASE_DIR)
	rsync -a $(LOCAL_LIB) $(INSTALL_DIR)
	rsync -a $(SOURCE_DIR) $(INSTALL_DIR)/include/$(BASE_DIR) --exclude *.cpp
	rsync -a $(DATA_DIR) $(INSTALL_DIR)/data/$(BASE_DIR)

$(TARGET): $(SOURCES)
	$(CXX) -I$(INC_DIR) $(CXXFLAGS) -o $@ $(LDFLAGS) $^
