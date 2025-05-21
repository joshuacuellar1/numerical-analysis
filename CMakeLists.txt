cmake_minimum_required(VERSION 4.0)
project(numerical_analysis)

set(CMAKE_CXX_STANDARD 23)

find_package(fmt CONFIG REQUIRED)
find_package(CLI11 CONFIG REQUIRED)

add_executable(numerical_analysis
        source/main.cpp)

target_link_libraries(numerical_analysis PRIVATE fmt::fmt)
target_link_libraries(numerical_analysis PRIVATE CLI11::CLI11)
