set(support_files_to_install scores.dat AUTHORS LICENSE)

list(TRANSFORM support_files_to_install PREPEND "${PROJECT_BINARY_DIR}/${build_dir}/")

foreach (support_file ${support_files_to_install})
    install(FILES "${support_file}" DESTINATION numoria)
endforeach ()

install(DIRECTORY "${PROJECT_BINARY_DIR}/${data_dir}" DESTINATION numoria)
install(TARGETS numoria RUNTIME DESTINATION numoria)
