if ("${NUMORIA_CURSES}" STREQUAL "browser")
    set(support_files_to_install numoria.html AUTHORS LICENSE)
else ()
    set(support_files_to_install scores.dat AUTHORS LICENSE)
    install(DIRECTORY "${PROJECT_BINARY_DIR}/${data_dir}" DESTINATION numoria)
endif ()

list(TRANSFORM support_files_to_install PREPEND "${PROJECT_BINARY_DIR}/${build_dir}/")

foreach (support_file ${support_files_to_install})
    install(FILES "${support_file}" DESTINATION numoria)
endforeach ()

install(TARGETS numoria RUNTIME DESTINATION numoria)
