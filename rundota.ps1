# This script is basically equivalent to the bash script for linux, but is of
# course written in powershell. The one big difference between this script and
# the bash script is that the trace to run is passed as an argument instead of
# as an environment variable.
param([string]$benchmark = 'valve')

$DOTA2_DIR = "C:/Program Files (x86)/Steam/steamapps/common/dota 2 beta"
$DOTA2_BIN = "$DOTA2_DIR/game/bin/win64/dota2.exe"
$DOTA2_BENCH_CSV = "$DOTA2_DIR/game/dota/Source2Bench.csv"

if ($benchmark == 'valve') {
    $DOTA2_TRACE_FILE = 2203598540
    $START_TIME = 80000 
    $END_TIME = 85000
} else {
    $DOTA2_TRACE_FILE = 1971360796
    $START_TIME = 50000 
    $END_TIME = 51000
}

foreach (api in "dx9", "dx10", "gl", "vk") {
    for ($i = 0; $i < 5; $i++) {
        "$DOATA2_BIN" "-$api" -autoconfig_level 3 +fps_max 0 -fs -w 1920 -h 1080 +cl_showfps 2 +timedemo $DOTA2_TRACE_FILE +timedemo_start $START_TIME +timedemo_end $END_TIME -testscript_inline "Test_WaitForCheckPoint DemoPlaybackFinished; quit"
        Write-Host -nonewline "%api: "
        Get-Content $DOATA2_BENCH_CSV -Tail 1 | %{ $_.Split(" ",[StringSplitOptions]"RemoveEmptyEntries")[$columnToGet] }
    }
}
