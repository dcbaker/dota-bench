REM Not nearly as fancy as the bash script which prints the relavent data, but
REM it's easier to just call notepad on windows. (patches welcome for a better
REM solution)

SET DOTA2_DIR=C:/Program Files (x86)/Steam/steamapps/common/dota 2 beta
SET DOTA2_BIN=%DOTA2_DIR%/game/bin/win64/dota2.exe
SET DOTA2_BENCH_CSV=%DOTA2_DIR%/game/dota/Source2Bench.csv

"%DOTA2_BIN%" -dx9  -autoconfig_level 3 +fps_max 0  -fs -w 1920 -h 1080 +cl_showfps 2 +timedemo 2203598540 +timedemo_start 80000 +timedemo_end 85000 -testscript_inline "Test_WaitForCheckPoint DemoPlaybackFinished; quit"
"%DOTA2_BIN%" -dx9  -autoconfig_level 3 +fps_max 0  -fs -w 1920 -h 1080 +cl_showfps 2 +timedemo 2203598540 +timedemo_start 80000 +timedemo_end 85000 -testscript_inline "Test_WaitForCheckPoint DemoPlaybackFinished; quit"
"%DOTA2_BIN%" -dx11  -autoconfig_level 3 +fps_max 0  -fs -w 1920 -h 1080 +cl_showfps 2 +timedemo 2203598540 +timedemo_start 80000 +timedemo_end 85000 -testscript_inline "Test_WaitForCheckPoint DemoPlaybackFinished; quit"
"%DOTA2_BIN%" -dx11  -autoconfig_level 3 +fps_max 0  -fs -w 1920 -h 1080 +cl_showfps 2 +timedemo 2203598540 +timedemo_start 80000 +timedemo_end 85000 -testscript_inline "Test_WaitForCheckPoint DemoPlaybackFinished; quit"
"%DOTA2_BIN%" -gl  -autoconfig_level 3 +fps_max 0  -fs -w 1920 -h 1080 +cl_showfps 2 +timedemo 2203598540 +timedemo_start 80000 +timedemo_end 85000 -testscript_inline "Test_WaitForCheckPoint DemoPlaybackFinished; quit"
"%DOTA2_BIN%" -gl  -autoconfig_level 3 +fps_max 0  -fs -w 1920 -h 1080 +cl_showfps 2 +timedemo 2203598540 +timedemo_start 80000 +timedemo_end 85000 -testscript_inline "Test_WaitForCheckPoint DemoPlaybackFinished; quit"

START "" "%SYSTEMROOT%\Notepad.exe" %DOTA2_BENCH_CSV%
