# Building GoogleTest and running exercise-gtest unit tests against
# all code in SOURCECODE subdirectory. This Makefile is based on the
# sample Makefile provided in the official GoogleTest GitHub Repo v1.7

# Points to the root of Google Test. Change it to reflect where your
# clone of the googletest repo is
GTEST_DIR = /usr/local/include/googletest/googletest

# Flags passed to the preprocessor and compiler
CPPFLAGS += --coverage -isystem $(GTEST_DIR)/include -std=c++11 -fno-exceptions
CXXFLAGS += -g -Wall -Wextra -pthread

# All tests produced by this Makefile.
TESTS = ConnectXTest

# All Google Test headers. Adjust only if you moved the subdirectory
GTEST_HEADERS = $(GTEST_DIR)/include/gtest/*.h \
                $(GTEST_DIR)/include/gtest/internal/*.h

# House-keeping build targets.

all : $(TESTS)

clean :
	rm -f $(TESTS) gtest.a gtest_main.a *.o *.gcov *.gcda *.gcno


# Builds gtest.a and gtest_main.a.
GTEST_SRCS_ = $(GTEST_DIR)/src/*.cc $(GTEST_DIR)/src/*.h $(GTEST_HEADERS)

gtest-all.o : $(GTEST_SRCS_)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) $(CXXFLAGS) -c \
            $(GTEST_DIR)/src/gtest-all.cc

gtest_main.o : $(GTEST_SRCS_)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) $(CXXFLAGS) -c \
            $(GTEST_DIR)/src/gtest_main.cc

gtest.a : gtest-all.o
	$(AR) $(ARFLAGS) $@ $^

gtest_main.a : gtest-all.o gtest_main.o
	$(AR) $(ARFLAGS) $@ $^

ConnectX.o : ConnectX.cpp ConnectX.h $(GTEST_HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c ConnectX.cpp

ConnectXTest.o : ConnectXTest.cpp \
                     ConnectX.h $(GTEST_HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c ConnectXTest.cpp

ConnectXTest : ConnectX.o ConnectXTest.o gtest_main.a
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -lpthread $^ -o $@
