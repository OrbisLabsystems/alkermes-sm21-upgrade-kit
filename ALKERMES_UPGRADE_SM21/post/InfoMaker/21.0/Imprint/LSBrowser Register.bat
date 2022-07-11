@setlocal enableextensions
@cd /d "%~dp0"

%WINDIR%\System32\regsvr32.exe lsbrowser.ocx
pause