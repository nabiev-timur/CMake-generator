cmake_minimum_required(VERSION 3.15)

include(cmake/handle.cmake)
include(cmake/version.cmake)

project(${@OPTION_PROJECT_PREFIX_UPPER_CASE@_PROJECT_NAME} 
    VERSION ${@OPTION_PROJECT_PREFIX_UPPER_CASE@_VERSION} 
    LANGUAGES C CXX)

# Включаем базовые модули
include(cmake/compile.cmake)

# Базовая структура - только библиотека
add_subdirectory(src) 