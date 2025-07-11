# Функция для конфигурирования файла с добавлением в конец существующего
# Если файл не существует, создает новый
# Если файл существует, добавляет конфигурируемый контент в конец
function(configure_file_append template_file output_file)
    if(EXISTS "${output_file}")
        file(READ "${output_file}" existing_content)
        
        configure_file("${template_file}" "${CMAKE_CURRENT_BINARY_DIR}/temp_configured" @ONLY)
        file(READ "${CMAKE_CURRENT_BINARY_DIR}/temp_configured" new_content)
        
        # Объединяем контент
        set(combined_content "${existing_content}\n${new_content}")
        file(WRITE "${output_file}" "${combined_content}")
        file(REMOVE "${CMAKE_CURRENT_BINARY_DIR}/temp_configured")
    else()
        configure_file("${template_file}" "${output_file}" @ONLY)
    endif()
endfunction()

# Функция для применения слоя
# Копирует папки из src в dest и конфигурирует файлы
function(apply src_dir dest_dir)
    # Проверяем, что исходная директория существует
    if(NOT EXISTS "${src_dir}")
        message(FATAL_ERROR "Исходная директория не существует: ${src_dir}")
    endif()
    
    # Создаем целевую директорию, если она не существует
    if(NOT EXISTS "${dest_dir}")
        file(MAKE_DIRECTORY "${dest_dir}")
    endif()
    
    # Получаем список всех файлов и папок в исходной директории
    file(GLOB_RECURSE src_items "${src_dir}/*")
    
    foreach(item ${src_items})
        # Получаем относительный путь от исходной директории
        file(RELATIVE_PATH relative_path "${src_dir}" "${item}")
        set(dest_item "${dest_dir}/${relative_path}")
        
        if(IS_DIRECTORY "${item}")
            # Если это директория, создаем её в целевом месте
            file(MAKE_DIRECTORY "${dest_item}")
        else()
            # Если это файл, сначала создаем родительскую директорию
            get_filename_component(dest_parent_dir "${dest_item}" DIRECTORY)
            if(NOT EXISTS "${dest_parent_dir}")
                file(MAKE_DIRECTORY "${dest_parent_dir}")
            endif()
            
            # Проверяем, является ли файл шаблоном (содержит @VAR@)
            file(READ "${item}" file_content)
            string(FIND "${file_content}" "@" has_vars)
            
            if(has_vars GREATER_EQUAL 0)
                # Файл содержит переменные для конфигурирования
                configure_file_append("${item}" "${dest_item}")
            else()
                # Обычный файл, копируем в правильное место с сохранением структуры
                file(COPY "${item}" DESTINATION "${dest_parent_dir}")
            endif()
        endif()
    endforeach()
    
    message(STATUS "Слой применен: ${src_dir} -> ${dest_dir}")
endfunction() 