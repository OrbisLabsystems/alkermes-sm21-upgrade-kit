rem compile_all_in_dir
@echo off
@set /A _tic=%time:~0,2%*3600^
            +%time:~3,1%*10*60^
            +%time:~4,1%*60^
            +%time:~6,1%*10^
            +%time:~7,1% >nul

for %%i in ($*.rpf) do (
	set arg1=%1 
	set arg2=%2 
	set fname=%%i & call :rename
)

@set /A _toc=%time:~0,2%*3600^
            +%time:~3,1%*10*60^
            +%time:~4,1%*60^
            +%time:~6,1%*10^
            +%time:~7,1% >nul

@set /A _elapsed=%_toc%-%_tic
@echo %_elapsed% seconds.

goto :eof

:rename
echo %fname%
..\exe\compiler %arg1% %arg2% %fname%
