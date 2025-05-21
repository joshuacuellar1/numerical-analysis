
# Set compiler
set(CMAKE_CXX_COMPILER clang++)

# Add warning compiler flags
set(CMAKE_CXX_FLAGS_INIT "-Wall -Wextra")
set(CMAKE_CXX_FLAGS_DEBUG_INIT "-Wpedantic -Werror -Wconversion -Wdouble-promotion -Og -g3")

set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE clang-include-fixer)
set(CMAKE_CXX_LINK_WHAT_YOU_USE TRUE)

# Use clang-tidy
message(STATUS "Using clang-tidy")
set(CMAKE_CXX_CLANG_TIDY clang-tidy --header-filter=.* --config-file=${CMAKE_CURRENT_LIST_DIR}/../.clang-tidy)
set(CMAKE_CXX_CLANG_TIDY_ARGS "--header-filter=.* --config-file=${CMAKE_CURRENT_LIST_DIR}/../.clang-tidy")

# Use cpplint
message(STATUS "Using cpplint")
set(CMAKE_CXX_CPPLINT "cpplint")
set(CMAKE_CXX_CPPLINT_ARGS "--linelength=80 --verbose=0")

# Use cppcheck
message(STATUS "Using cppcheck")
set(CMAKE_CXX_CPPCHECK cppcheck)
set(CMAKE_CXX_CPPCHECK_ARGS "--enable=all --report-progress --verbose")
