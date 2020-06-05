cmake_minimum_required(VERSION 3.16)
project(nautilus_ext C)

set(CMAKE_C_STANDARD 11)

set(CMAKE_SHARED_LIBRARY_PREFIX "")

include_directories(. /usr/include/nautilus)

add_library(nautilus_ext SHARED
        plugin.c)

FIND_PACKAGE(PkgConfig REQUIRED)
if(NOT PKG_CONFIG_FOUND)
    message(FATAL_ERROR "pkg-config not found!" )
endif()

pkg_check_modules(NAUTILUS REQUIRED "libnautilus-extension")
target_link_libraries(nautilus_ext ${NAUTILUS_LIBRARIES})
target_include_directories(nautilus_ext PUBLIC ${NAUTILUS_INCLUDE_DIRS})
target_compile_options(nautilus_ext PUBLIC ${NAUTILUS_CFLAGS_OTHER})
