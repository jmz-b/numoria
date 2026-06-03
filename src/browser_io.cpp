// Called from browser_io.js before main() to set save/score paths
// into the IDBFS-mounted directory.

#ifdef __EMSCRIPTEN__

#include "headers.h"

extern "C" {
    void setSavePath(char *scores_path, char *save_path) {
        const_cast<std::string &>(config::files::scores) = scores_path;
        config::files::save_game = save_path;

        // Create the scores file if it doesn't exist.
        FILE *f = fopen(scores_path, "rb");
        if (f == nullptr) {
            f = fopen(scores_path, "wb");
        }
        if (f != nullptr) {
            fclose(f);
        }
    }
}

#endif
