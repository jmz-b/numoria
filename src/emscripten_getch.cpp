#ifdef __EMSCRIPTEN__

// Async keyboard input for the Emscripten build.
// Called by getKeyInput() in ui_io.cpp instead of PDCursesMod's getch().
// SDL2 still handles all rendering; only keyboard delivery is replaced.
//
// Uses emscripten_sleep(0) to yield to the browser between polls.

#include <emscripten.h>

// Non-blocking: returns next key from the JS buffer, or -1 if empty.
EM_JS(int, js_peek_key, (), {
    if (window._keyBuffer && window._keyBuffer.length > 0) {
        return window._keyBuffer.shift();
    }
    return -1;
});

extern "C" int js_getch() {
    while (true) {
        int key = js_peek_key();
        if (key >= 0) return key;
        emscripten_sleep(0); // yield to browser event loop, same as PDCursesMod
    }
}

#endif
