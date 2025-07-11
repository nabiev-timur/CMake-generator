# Include variables and functions
include("${CMAKE_CURRENT_LIST_DIR}/vars.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/options.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/layer_functions.cmake")

message(STATUS "Generating project: ${OPTION_PROJECT_NAME_CAMEL_CASE}")
message(STATUS "Output directory: ${OPTION_PROJECT_NAME_CAMEL_CASE}")

set(OUTPUT_DIR "${OPTION_PROJECT_NAME_CAMEL_CASE}")
file(MAKE_DIRECTORY "${OUTPUT_DIR}")

message(STATUS "Applying base layer...")
apply("${CMAKE_CURRENT_SOURCE_DIR}/template/00_base" "${OUTPUT_DIR}")

if(OPTION_GEN_APP_SUPPORT)
    message(STATUS "Applying C++ base layer...")
    apply("${CMAKE_CURRENT_SOURCE_DIR}/template/01_cxx_base" "${OUTPUT_DIR}")
endif()

if(OPTION_GEN_DOCS)
    message(STATUS "Applying C++ base layer...")
    apply("${CMAKE_CURRENT_SOURCE_DIR}/template/02_docs" "${OUTPUT_DIR}")
endif()

if(OPTION_GEN_STATIC_LIB)
    message(STATUS "Applying static library layer...")
    apply("${CMAKE_CURRENT_SOURCE_DIR}/template/05_static-lib" "${OUTPUT_DIR}")
endif()

if(OPTION_GEN_SHARED_LIB)
    message(STATUS "Applying shared library layer...")
    apply("${CMAKE_CURRENT_SOURCE_DIR}/template/10_shared_lib" "${OUTPUT_DIR}")
endif()

if(OPTION_GEN_APP_SUPPORT)
    message(STATUS "Applying C++ base layer...")
    apply("${CMAKE_CURRENT_SOURCE_DIR}/template/15_app_cxx" "${OUTPUT_DIR}")
endif()

if(OPTION_GEN_FUNCTIONAL_TESTS OR OPTION_GEN_UNIT_TESTS)
    message(STATUS "Applying presets layer...")
    apply("${CMAKE_CURRENT_SOURCE_DIR}/template/20_tests_base" "${OUTPUT_DIR}")
endif()

if(OPTION_GEN_UNIT_TESTS)
    message(STATUS "Applying unit tests layer...")
    apply("${CMAKE_CURRENT_SOURCE_DIR}/template/20_tests_base" "${OUTPUT_DIR}")
    apply("${CMAKE_CURRENT_SOURCE_DIR}/template/25_unit_tests" "${OUTPUT_DIR}")
endif()

if(OPTION_GEN_FUNCTIONAL_TESTS)
    message(STATUS "Applying functional tests layer...")
    apply("${CMAKE_CURRENT_SOURCE_DIR}/template/20_tests_base" "${OUTPUT_DIR}")
    apply("${CMAKE_CURRENT_SOURCE_DIR}/template/30_functional_tests" "${OUTPUT_DIR}")
endif()

message(STATUS "Project generation completed!")
message(STATUS "Generated project location: ${OUTPUT_DIR}") 