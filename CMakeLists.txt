cmake_minimum_required(VERSION 3.23.1)
set(PROJ_NAME notor)
project(${PROJ_NAME})

set(CMAKE_CXX_STANDARD 11)

add_compile_options(-Wall)

add_executable(${PROJ_NAME} main.cpp options.cpp)

target_link_libraries(${PROJ_NAME} PUBLIC ncurses)

set(CMAKE_PREFIX_PATH "/usr/local/bin")

# For termux, comment out or erase the path setter above and uncomment the below line
# set(CMAKE_PREFIX_PATH "/data/data/com.termux/files/usr/bin")

# install
install(TARGETS ${PROJ_NAME} DESTINATION ${CMAKE_PREFIX_PATH})
