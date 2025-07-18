file(GLOB_RECURSE @OPTION_PROJECT_PREFIX_UPPER_CASE@_PUBLIC_HEADERS "include/*.h")
set(@OPTION_PROJECT_PREFIX_UPPER_CASE@_PUBLIC_INCLUDE "include")

set(@OPTION_PROJECT_PREFIX_UPPER_CASE@_COMPILE_OPTIONS 
    @OPTION_PROJECT_PREFIX_UNDER_CASE@_compile_options)
add_library(${@OPTION_PROJECT_PREFIX_UPPER_CASE@_COMPILE_OPTIONS} INTERFACE)
# Общие флаги компиляции
set(@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_FLAGS)
if(MSVC)
    set(@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_FLAGS 
        "${@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_FLAGS} 
        /W4 
        /WX")
else()
    set(@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_FLAGS 
        "${@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_FLAGS}
        -Wall 
        -Wextra 
        -Werror
        -fvisibility=hidden
        -fPIC")
    
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        set(@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_FLAGS 
            "${@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_FLAGS}
            -ggdb")
    endif()

    if(OPTION_TARGET_ARCH STREQUAL "x86")
        set(@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_FLAGS 
            "${@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_FLAGS}
            -m32")
    elseif(OPTION_TARGET_ARCH STREQUAL "x86_64")
        set(@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_FLAGS 
            "${@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_FLAGS}
            -m64")
    endif()
endif()

target_compile_options(${@OPTION_PROJECT_PREFIX_UPPER_CASE@_COMPILE_OPTIONS} INTERFACE 
	$<$<COMPILE_LANGUAGE:C>: ${@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_FLAGS}>)

set(@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_DEFINES)
if(WIN32)
    set(@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_DEFINES ${@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_DEFINES} 
        @OPTION_PROJECT_PREFIX_UPPER_CASE@_WINDOWS)
else()
    set(@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_DEFINES ${@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_DEFINES} 
        @OPTION_PROJECT_PREFIX_UPPER_CASE@_LINUX)
endif()

target_compile_definitions(${@OPTION_PROJECT_PREFIX_UPPER_CASE@_COMPILE_OPTIONS} INTERFACE 
    $<$<COMPILE_LANGUAGE:C>: ${@OPTION_PROJECT_PREFIX_UPPER_CASE@_C_DEFINES}>)