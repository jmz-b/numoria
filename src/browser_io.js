// Pre-JS module for the Emscripten web build.
// Mounts IndexedDB for persistent save files, then starts the game.
// SDL2 handles all rendering and input via the HTML5 canvas.

// Key buffer for the Emscripten build.
// SDL2 handles all rendering; keyboard input goes through this buffer
// and is polled by emscripten_getch.cpp using emscripten_sleep(0).
window._keyBuffer = [];
document.addEventListener('keydown', function(e) {
    var key = e.key;
    var ch = null;

    if (e.ctrlKey && key.length === 1) {
        ch = key.toUpperCase().charCodeAt(0) - 64; // CTRL+A = 1
    } else if (key === 'Enter') {
        ch = 13;
    } else if (key === 'Escape') {
        ch = 27;
    } else if (key === 'Backspace' || key === 'Delete') {
        ch = 8;
    } else if (key === 'Tab') {
        ch = 9;
    } else if (key.length === 1) {
        ch = key.charCodeAt(0);
    }

    if (ch !== null) {
        e.preventDefault();
        window._keyBuffer.push(ch);
    }
});

// Extend the Module object set up by the Emscripten HTML shell rather
// than replacing it, so setStatus / monitorRunDependencies still work.
var Module = typeof Module !== 'undefined' ? Module : {};

Module.onRuntimeInitialized = function() {
        var savePath = '/numoria';

        FS.mkdir(savePath);
        FS.mount(IDBFS, {}, savePath);

        FS.syncfs(true, function(err) {
            if (err) {
                console.error('IDBFS sync failed:', err);
            }

            // Create scores file if it doesn't exist
            var scoresPath = savePath + '/scores.dat';
            try {
                FS.stat(scoresPath);
            } catch(e) {
                FS.writeFile(scoresPath, new Uint8Array(0));
            }

            Module.ccall('setSavePath', null,
                ['string', 'string'],
                [scoresPath, savePath + '/game.sav']
            );

            Module.callMain([]);

            // Ensure the SDL2 canvas has keyboard focus so input reaches the game.
            var canvas = document.getElementById('canvas');
            if (canvas) {
                canvas.focus();
                canvas.addEventListener('click', function() { canvas.focus(); });
            }
        });
};

Module.onExit = function() {
    FS.syncfs(false, function(err) {
        if (err) { console.error('IDBFS save failed:', err); }
    });
};

// Prevent accidental navigation away mid-game
window.addEventListener('beforeunload', function(e) {
    e.preventDefault();
    e.returnValue = '';
});
