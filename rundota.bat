REM Not nearly as fancy as the bash script which prints the relavent data, but
REM it's easier to just call notepad on windows. (patches welcome for a better
REM solution)

SET DOTA2_DIR=C:/Program Files (x86)/Steam/steamapps/common/dota 2 beta
SET DOTA2_BIN=%DOTA2_DIR%/game/bin/win64/dota2.exe
SET DOTA2_BENCH_CSV=%DOTA2_DIR%/game/dota/Source2Bench.csv

REM Use the valve trace
SET DOTA_TRACE_FILE=2203598540
SET START_FRAME=80000
SET STOP_FRAME=85000

REM Use the PTS trace
REM DOTA_TRACE_FILE=1971360796
REM START_FRAME=50000
REM STOP_FRAME=51000

for %%x in (dx9 dx11 gl vk) do (
    for /l %%_ in (1, 1, 5) do (
        "%DOTA2_BIN%" -%%x  -autoconfig_level 3 +fps_max 0  -fs -w 1920 -h 1080 +cl_showfps 2 +timedemo %DOTA2_TRACE_FILE% +timedemo_start %START_FRAME% +timedemo_end %STOP_FRAME% -testscript_inline "Test_WaitForCheckPoint DemoPlaybackFinished; quit"
    )
)

START "" "%SYSTEMROOT%\Notepad.exe" %DOTA2_BENCH_CSV%
