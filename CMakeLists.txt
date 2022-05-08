cmake_minimum_required(VERSION 3.23.1)
set(PROJ_NAME notor)
project(${PROJ_NAME})

set(CMAKE_CXX_STANDARD 11)

add_compile_options(-Wall)

find_package(gflags REQUIRED)

add_executable(${PROJ_NAME} main.cpp options.cpp)

target_link_libraries(${PROJ_NAME} PUBLIC ncurses gflags::gflags)

set(${PROJ_NAME}_PATH_INSTALL "/usr/bin")

# For termux, comment out or erase the path setter above and uncomment the below line
# set(${PROJ_NAME}_PATH_INSTALL "/data/data/com.termux/files/usr/bin")

# install
install(TARGETS ${PROJ_NAME} DESTINATION  "${${PROJ_NAME}_PATH_INSTALL}/")
