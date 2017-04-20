# This is for non-ubuntu distros, that put steam in the right place
#DOTA2_DIR="${HOME}/.local/share/Steam/steamapps/common/dota 2 beta"
DOTA2_DIR="${HOME}/.steam/steam/steamapps/common/dota 2 beta"
DOTA2_BIN="${DOTA2_DIR}/game/bin/linuxsteamrt64/dota2"
DOTA2_BENCH_CSV="${DOTA2_DIR}/game/dota/Source2Bench.csv"

# These are set in the shell script used to launch dota2 on Linux. Since that
# also messes with LD_LIBRARY_PATH and LD_PRELOAD we don't call that, but we
# want their thread settings
ulimit -n 2048
ulimit -Ss 1024

export STEAM_RUNTIME=0

# Force the use of two libraries that will either not be installed or will
# conflict with system installed versions
export LD_PRELOAD="${HOME}/.steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu/libudev.so.0 ${HOME}/.steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu/libpng12.so.0"

# Set the graphics to high
FLAGS="${FLAGS} -autoconfig_level 3"

# Don't limit the framerate
FLAGS="${FLAGS} +fps_max 0"

# Fullscreen 1920x1080
FLAGS="${FLAGS} -fs -w 1920 -h 1080"

# Show the framerate
FLAGS="${FLAGS} +cl_showfps 2"

# Run the time demo and quit as soon as finished
FLAGS="${FLAGS} +timedemo 2203598540 +timedemo_start 80000 +timedemo_end 85000 -testscript_inline \"Test_WaitForCheckPoint DemoPlaybackFinised; quit\""

# Start dota2 and set it to kill on shell exit
for api in "gl vulkan"; do
    for _ in `seq 1 5`; do
        "${DOTA2_BIN}" ${FLAGS} "-${api}"
        echo -n "${api}: "
        tail -1 "${DOATA2_BENCH_CSV}" | awk '{print $2}' | tr -d ','
    done
done
