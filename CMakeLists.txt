cmake_minimum_required(VERSION 3.15)

project(CMakeGenerator LANGUAGES NONE)

include(cmake/layer_functions.cmake)
include(cmake/vars.cmake)
include(cmake/options.cmake)

# Test scenario
if(CMAKE_PROJECT_NAME STREQUAL "CMakeGenerator")
    message(STATUS "Running CMake Generator test scenario...")
    
    # Generate project
    message(STATUS "Step 1: Generating test project...")
    include(cmake/generate_project.cmake)
    
    # Apply test patch with source files
    message(STATUS "Step 2: Applying test patch...")
    if(EXISTS "${CMAKE_SOURCE_DIR}/tests/template/full_test")
        apply("${CMAKE_SOURCE_DIR}/tests/template/full_test" "${CMAKE_BINARY_DIR}/TestProject")
        message(STATUS "Test patch applied successfully")
    else()
        message(WARNING "Test patch not found: ${CMAKE_SOURCE_DIR}/tests/template/full_test")
    endif()
    
    # Configure and build generated project
    message(STATUS "Step 3: Configuring and building generated project...")
    
    # Create build directory for generated project
    set(GENERATED_BUILD_DIR "${CMAKE_BINARY_DIR}/TestProject/build")
    file(MAKE_DIRECTORY "${GENERATED_BUILD_DIR}")
    
    # Configure generated project
    execute_process(
        COMMAND ${CMAKE_COMMAND} -B "${GENERATED_BUILD_DIR}" -S "${CMAKE_BINARY_DIR}/TestProject"
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/TestProject"
        RESULT_VARIABLE CONFIGURE_RESULT
        OUTPUT_VARIABLE CONFIGURE_OUTPUT
        ERROR_VARIABLE CONFIGURE_ERROR
    )
    
    if(NOT CONFIGURE_RESULT EQUAL 0)
        message(FATAL_ERROR "Failed to configure generated project:\n${CONFIGURE_ERROR}")
    endif()
    
    message(STATUS "Generated project configured successfully")
    
    # Build generated project
    execute_process(
        COMMAND ${CMAKE_COMMAND} --build "${GENERATED_BUILD_DIR}"
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/TestProject"
        RESULT_VARIABLE BUILD_RESULT
        OUTPUT_VARIABLE BUILD_OUTPUT
        ERROR_VARIABLE BUILD_ERROR
    )
    
    if(NOT BUILD_RESULT EQUAL 0)
        message(FATAL_ERROR "Failed to build generated project:\n${BUILD_ERROR}")
    endif()
    
    message(STATUS "Generated project built successfully")
    message(STATUS "Test scenario completed successfully!")
    message(STATUS "Generated project location: ${CMAKE_BINARY_DIR}/TestProject")
    message(STATUS "Build artifacts location: ${GENERATED_BUILD_DIR}")
endif()

