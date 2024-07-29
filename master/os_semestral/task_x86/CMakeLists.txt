CMAKE_MINIMUM_REQUIRED(VERSION 3.0)

PROJECT(usertask CXX C ASM)

ADD_DEFINITIONS(-g)

# INCLUDE_DIRECTORIES("${CMAKE_CURRENT_SOURCE_DIR}/include/")
INCLUDE_DIRECTORIES("include")

# FILE(GLOB_RECURSE source_list "./*.cpp" "./*.c" "./*.h" "./*.hpp")

# ADD_EXECUTABLE(usertask ${source_list})

ADD_EXECUTABLE(usertask "main.cpp" "sources/chromosome.cpp" "sources/generation.cpp")