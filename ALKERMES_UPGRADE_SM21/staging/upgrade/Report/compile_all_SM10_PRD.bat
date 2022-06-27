rem compile_all_in_dir
@echo off
for %%i in (*.rpf) do ..\exe\compiler -instance SM10_PRD %%~ni
pause