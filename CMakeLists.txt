cmake_minimum_required(VERSION 3.23.1)
set(PROJ_NAME notor)
project(${PROJ_NAME})

set(CMAKE_CXX_STANDARD 11)

add_compile_options(-Wall)

add_executable(notor main.cpp flags.cpp)

target_link_libraries(notor PUBLIC ncurses)

set(${PROJ_NAME}_PATH_INSTALL "/usr/bin")

# For termux, comment out or erase the path setter above and uncomment the below line
# set(${PROJ_NAME}_PATH_INSTALL "/data/data/com.termux/files/usr/bin")

# install
install(TARGETS ${PROJ_NAME} DESTINATION  "${${PROJ_NAME}_PATH_INSTALL}/")
