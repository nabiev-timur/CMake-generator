# =============================================================================
# Generator Project Utilities - Functions for computing project name variables
# =============================================================================

# Function to convert string to snake_case
function(string_to_snake_case input_string output_var)
    # Convert to lowercase first
    string(TOLOWER "${input_string}" lower_string)
    
    # Replace spaces and special characters with underscores
    string(REGEX REPLACE "[^a-z0-9]" "_" snake_string "${lower_string}")
    
    # Remove multiple consecutive underscores
    string(REGEX REPLACE "_+" "_" snake_string "${snake_string}")
    
    # Remove leading and trailing underscores
    string(REGEX REPLACE "^_|_$" "" snake_string "${snake_string}")
    
    set(${output_var} "${snake_string}" PARENT_SCOPE)
endfunction()

# Function to convert string to CamelCase
function(string_to_camel_case input_string output_var)
    # Check if the string is already in CamelCase format
    string(REGEX MATCH "^[A-Z][a-zA-Z0-9]*([A-Z][a-zA-Z0-9]*)*$" is_camel_case "${input_string}")
    
    if(is_camel_case)
        # If already in CamelCase, return as is
        set(${output_var} "${input_string}" PARENT_SCOPE)
        return()
    endif()
    
    # Split by common separators and capitalize each word
    string(REGEX REPLACE "[^a-zA-Z0-9]+" ";" word_list "${input_string}")
    
    set(camel_string "")
    foreach(word ${word_list})
        if(word)
            # Capitalize first letter, lowercase the rest
            string(SUBSTRING "${word}" 0 1 first_char)
            string(SUBSTRING "${word}" 1 -1 rest_chars)
            string(TOUPPER "${first_char}" first_char)
            string(TOLOWER "${rest_chars}" rest_chars)
            set(camel_string "${camel_string}${first_char}${rest_chars}")
        endif()
    endforeach()
    
    set(${output_var} "${camel_string}" PARENT_SCOPE)
endfunction()

# Function to convert string to UPPER_CASE
function(string_to_upper_case input_string output_var)
    # Convert to snake_case first, then to uppercase
    string_to_snake_case("${input_string}" snake_string)
    string(TOUPPER "${snake_string}" upper_string)
    set(${output_var} "${upper_string}" PARENT_SCOPE)
endfunction()

# Function to convert string to lowercase
function(string_to_lower_case input_string output_var)
    string(TOLOWER "${input_string}" lower_string)
    # Remove spaces and special characters
    string(REGEX REPLACE "[^a-z0-9]" "" clean_string "${lower_string}")
    set(${output_var} "${clean_string}" PARENT_SCOPE)
endfunction()

# Function to generate prefix from project name
function(generate_prefix_from_name project_name output_var_upper output_var_lower)
    # Extract first letter of each word
    string(REGEX REPLACE "[^a-zA-Z0-9]+" ";" word_list "${project_name}")
    
    set(prefix_upper "")
    set(prefix_lower "")
    
    foreach(word ${word_list})
        if(word)
            # Get first character
            string(SUBSTRING "${word}" 0 1 first_char)
            string(TOUPPER "${first_char}" first_char_upper)
            string(TOLOWER "${first_char}" first_char_lower)
            set(prefix_upper "${prefix_upper}${first_char_upper}")
            set(prefix_lower "${prefix_lower}${first_char_lower}")
        endif()
    endforeach()
    
    set(${output_var_upper} "${prefix_upper}" PARENT_SCOPE)
    set(${output_var_lower} "${prefix_lower}" PARENT_SCOPE)
endfunction()

# Main function to compute all project variables from PROJECT_NAME
function(project_compute_all_variables)
    if(NOT PROJECT_NAME)
        message(FATAL_ERROR "PROJECT_NAME is not set. Cannot compute derived variables.")
    endif()
    
    # Compute name variations
    string_to_snake_case("${PROJECT_NAME}" PROJECT_NAME_SNAKE)
    string_to_camel_case("${PROJECT_NAME}" PROJECT_NAME_CAMEL)
    string_to_upper_case("${PROJECT_NAME}" PROJECT_NAME_UPPER)
    string_to_lower_case("${PROJECT_NAME}" PROJECT_NAME_LOWER)
    
    # Compute prefixes
    generate_prefix_from_name("${PROJECT_NAME}" PROJECT_PREFIX_UPPER PROJECT_PREFIX_LOWER)
    
    # Set variables in parent scope
    set(PROJECT_NAME_SNAKE "${PROJECT_NAME_SNAKE}" PARENT_SCOPE)
    set(PROJECT_NAME_CAMEL "${PROJECT_NAME_CAMEL}" PARENT_SCOPE)
    set(PROJECT_NAME_UPPER "${PROJECT_NAME_UPPER}" PARENT_SCOPE)
    set(PROJECT_NAME_LOWER "${PROJECT_NAME_LOWER}" PARENT_SCOPE)
    set(PROJECT_PREFIX_UPPER "${PROJECT_PREFIX_UPPER}" PARENT_SCOPE)
    set(PROJECT_PREFIX_LOWER "${PROJECT_PREFIX_LOWER}" PARENT_SCOPE)
endfunction()

# Function to set project name and compute all variables
function(set_project_name_and_compute name)
    set(PROJECT_NAME "${name}" PARENT_SCOPE)
    project_compute_all_variables()
endfunction()

# Function to validate project variables
function(validate_project_variables)
    set(required_vars 
        PROJECT_NAME
        PROJECT_NAME_SNAKE
        PROJECT_NAME_CAMEL
        PROJECT_NAME_UPPER
        PROJECT_NAME_LOWER
        PROJECT_PREFIX_UPPER
        PROJECT_PREFIX_LOWER
    )
    
    foreach(var ${required_vars})
        if(NOT ${var})
            message(WARNING "Project variable ${var} is not set")
        endif()
    endforeach()
endfunction()

# Function to print all project variables
function(print_project_variables)
    message(STATUS "=== Project Variables ===")
    message(STATUS "PROJECT_NAME: ${PROJECT_NAME}")
    message(STATUS "PROJECT_NAME_SNAKE: ${PROJECT_NAME_SNAKE}")
    message(STATUS "PROJECT_NAME_CAMEL: ${PROJECT_NAME_CAMEL}")
    message(STATUS "PROJECT_NAME_UPPER: ${PROJECT_NAME_UPPER}")
    message(STATUS "PROJECT_NAME_LOWER: ${PROJECT_NAME_LOWER}")
    message(STATUS "PROJECT_PREFIX_UPPER: ${PROJECT_PREFIX_UPPER}")
    message(STATUS "PROJECT_PREFIX_LOWER: ${PROJECT_PREFIX_LOWER}")
    message(STATUS "PROJECT_VERSION: ${PROJECT_VERSION}")
    message(STATUS "PROJECT_DESCRIPTION: ${PROJECT_DESCRIPTION}")
    message(STATUS "PROJECT_AUTHOR: ${PROJECT_AUTHOR}")
    message(STATUS "PROJECT_LICENSE: ${PROJECT_LICENSE}")
    message(STATUS "PROJECT_HOMEPAGE: ${PROJECT_HOMEPAGE}")
    message(STATUS "=========================")
endfunction() 