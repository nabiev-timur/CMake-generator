# Current date in RPM CHANGELOG format
string(TIMESTAMP OPTION_CURRENT_DATE "%a %b %d %Y" UTC)
include("${CMAKE_CURRENT_LIST_DIR}/vars_functions.cmake")

if(NOT DEFINED OPTION_PROJECT_NAME_CAMEL_CASE)
    if(DEFINED OPTION_PROJECT_NAME_SNAKE_CASE)
        # Compute CamelCase from SnakeCase
        string_to_camel_case("${OPTION_PROJECT_NAME_SNAKE_CASE}" OPTION_PROJECT_NAME_CAMEL_CASE)
    else()
        # No SnakeCase either, use default
        message(WARNING "Neither OPTION_PROJECT_NAME_CAMEL_CASE nor OPTION_PROJECT_NAME_SNAKE_CASE is defined. Using default: TestProject")
        set(OPTION_PROJECT_NAME_CAMEL_CASE "TestProject")
    endif()
endif()

if(NOT DEFINED OPTION_PROJECT_NAME_SNAKE_CASE)
    # Compute SnakeCase from CamelCase (which is always defined now)
    string_to_snake_case("${OPTION_PROJECT_NAME_CAMEL_CASE}" OPTION_PROJECT_NAME_SNAKE_CASE)
endif()

if(NOT DEFINED OPTION_PROJECT_PREFIX_UNDER_CASE)
    # Compute from CamelCase
    generate_prefix_from_name("${OPTION_PROJECT_NAME_CAMEL_CASE}" temp_upper OPTION_PROJECT_PREFIX_UNDER_CASE)
endif()

if(NOT DEFINED OPTION_PROJECT_PREFIX_UPPER_CASE)
    if(DEFINED OPTION_PROJECT_PREFIX_UNDER_CASE)
        # Use under case as upper case
        string(TOUPPER "${OPTION_PROJECT_PREFIX_UNDER_CASE}" OPTION_PROJECT_PREFIX_UPPER_CASE)
    else()
        # Compute from CamelCase
        generate_prefix_from_name("${OPTION_PROJECT_NAME_CAMEL_CASE}" OPTION_PROJECT_PREFIX_UPPER_CASE temp_lower)
    endif()
endif()

# Output the resulting OPTION variables
message(STATUS "OPTION_CURRENT_DATE: ${OPTION_CURRENT_DATE}")
message(STATUS "OPTION_PROJECT_NAME_CAMEL_CASE: ${OPTION_PROJECT_NAME_CAMEL_CASE}")
message(STATUS "OPTION_PROJECT_NAME_SNAKE_CASE: ${OPTION_PROJECT_NAME_SNAKE_CASE}")
message(STATUS "OPTION_PROJECT_PREFIX_UPPER_CASE: ${OPTION_PROJECT_PREFIX_UPPER_CASE}")
message(STATUS "OPTION_PROJECT_PREFIX_UNDER_CASE: ${OPTION_PROJECT_PREFIX_UNDER_CASE}")
