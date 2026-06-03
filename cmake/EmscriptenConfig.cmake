# Emscripten-specific link flags for the web build.
# Included by CMakeLists.txt when the Emscripten toolchain is detected.

set(NUMORIA_FONT_PATH "/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf"
    CACHE FILEPATH "Path to the TTF font to embed in the web build")

if (NOT EXISTS "${NUMORIA_FONT_PATH}")
    message(FATAL_ERROR
        "Font not found at '${NUMORIA_FONT_PATH}'.\n"
        "Install it with: sudo apt install fonts-dejavu-core\n"
        "Or set -DNUMORIA_FONT_PATH=<path> to a TrueType monospace font."
    )
endif ()

set(em_data_files
    "${PROJECT_BINARY_DIR}/${data_dir}/death_royal.txt"
    "${PROJECT_BINARY_DIR}/${data_dir}/death_tomb.txt"
    "${PROJECT_BINARY_DIR}/${data_dir}/help.txt"
    "${PROJECT_BINARY_DIR}/${data_dir}/help_wizard.txt"
    "${PROJECT_BINARY_DIR}/${data_dir}/rl_help.txt"
    "${PROJECT_BINARY_DIR}/${data_dir}/rl_help_wizard.txt"
    "${PROJECT_BINARY_DIR}/${data_dir}/splash.txt"
    "${PROJECT_BINARY_DIR}/${data_dir}/versions.txt"
    "${PROJECT_BINARY_DIR}/${data_dir}/welcome.txt"
)

set(em_embed_flags "")
foreach (f ${em_data_files})
    get_filename_component(fname "${f}" NAME)
    string(APPEND em_embed_flags " --embed-file ${f}@data/${fname}")
endforeach ()

# Embed font at the path PDCursesMod expects by default on Linux.
string(APPEND em_embed_flags
    " --embed-file ${NUMORIA_FONT_PATH}@/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf")

set(em_link_flags
    "-O2"
    "-lidbfs.js"
    "-sASYNCIFY"
    # ASYNCIFY serialises the C call stack when yielding to the browser.
    # 1MB is a safe ceiling; Emscripten's default is much smaller.
    "-sASYNCIFY_STACK_SIZE=1048576"
    "-sENVIRONMENT=web"
    "-sEXIT_RUNTIME=1"
    "-sEXPORTED_FUNCTIONS=_main,_setSavePath"
    "-sEXPORTED_RUNTIME_METHODS=ccall,callMain"
    "-sINVOKE_RUN=0"
    "-sSINGLE_FILE=1"
    "-sUSE_SDL=2"
    "-sUSE_SDL_TTF=2"
    "-sALLOW_MEMORY_GROWTH=1"
    "--pre-js ${PROJECT_SOURCE_DIR}/src/browser_io.js"
    "${em_embed_flags}"
)

string(JOIN " " em_link_flags_str ${em_link_flags})
set_target_properties(numoria PROPERTIES
    SUFFIX ".html"
    LINK_FLAGS "${em_link_flags_str}"
)
