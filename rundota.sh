# This is for non-debian distros, that put steam in the right place
#DOTA2_DIR="${HOME}/.local/share/Steam/steamapps/common/dota 2 beta"
DOTA2_DIR="${HOME}/.steam/steam/steamapps/common/dota 2 beta"
DOTA2_BIN="${DOTA2_DIR}/game/bin/linuxsteamrt64/dota2"
DOTA2_BENCH_CSV="${DOTA2_DIR}/game/dota/Source2Bench.csv"
if [ -z "$TRACE" ]; then
    TRACE='valve'
fi

# These are set in the shell script used to launch dota2 on Linux. Since that
# also messes with LD_LIBRARY_PATH and LD_PRELOAD we don't call that, but we
# want their thread settings
ulimit -n 2048
ulimit -Ss 1024

export STEAM_RUNTIME=0

# Force the use of two libraries that will either not be installed or will
# conflict with system installed versions
preload_libs_dir="${HOME}/.steam/bin32/steam-runtime/amd64/lib/x86_64-linux-gnu"
export LD_PRELOAD="${preload_libs_dir}/libudev.so.0 ${preload_libs_dir}/libpng12.so.0"

# Set the graphics to high
FLAGS="${FLAGS} -autoconfig_level 3"

# Don't limit the framerate
FLAGS="${FLAGS} +fps_max 0"

# Fullscreen 1920x1080
FLAGS="${FLAGS} -fs -w 1920 -h 1080"

# Show the framerate
FLAGS="${FLAGS} +cl_showfps 2"

# Don't run slower if we lose focus: this is a benchmark.
FLAGS="${FLAGS} +engine_no_focus_sleep 0"

# Run the time demo and quit as soon as finished
if [ $TRACE == "valve" ]; then
    DOTA2_TRACE_FILE=2203598540
    FLAGS="${FLAGS} +timedemo ${DOTA2_TRACE_FILE} +timedemo_start 80000 +timedemo_end 85000 -testscript_inline \"Test_WaitForCheckPoint DemoPlaybackFinished; quit\""
else  # PTS trace
    DOTA2_TRACE_FILE=1971360796
    FLAGS="${FLAGS} +timedemo ${DOTA2_TRACE_FILE} +timedemo_start 50000 +timedemo_end 51000 -testscript_inline \"Test_WaitForCheckPoint DemoPlaybackFinished; quit\""
fi

demo_file_path="${DOTA2_DIR}/game/dota/${DOTA2_TRACE_FILE}.dem"
if [ ! -e "$demo_file_path" ]; then
	echo "demo file '$demo_file_path' not found"
	exit 1
fi

# Make it work with APITrace
#FLAGS="${FLAGS} -gl_disable_buffer_storage -gl_disable_compressed_texture_pixel_storage"

# Start dota2 and set it to kill on shell exit
for api in gl vulkan; do
    for _ in `seq 1 5`; do
        "${DOTA2_BIN}" ${FLAGS} "-${api}"
        echo -n "${api}: "
        tail -1 "${DOTA2_BENCH_CSV}" | awk '{print $2}' | tr -d ','
    done
done
