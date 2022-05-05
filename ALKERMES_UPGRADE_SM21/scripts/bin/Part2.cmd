REM
REM  Alkermes 21 Upgrade Script
REM
REM  Inputs 1. A clean SM21.0 install with merged structure 
REM
REM         2. Database import complete from previous SM version
REM 
REM         2. A staged instance folder structure from where to retrieve other
REM            files to merge at upgrade time
REM
REM  MODIFICATION HISTORY
REM 
REM  Version Date            Name                    Description
REM  ------- --------------- ----------------------- -----------------------------------
REM  1.0     17-FEB-2021     Raphael Castro           Original
REM
REM ************************************************************************************
REM Starting SampleManager Upgrade Script
REM ************************************************************************************

echo on

date /t
time /t

set SM_INSTANCE=%1
set INSTANCE_ROOT=%2
set STAGE=%3
set SM_ROOT=%4
set EXE=%INSTANCE_ROOT:"=%\exe\
set SMP="%EXE:"=%smp"
set UPG="%INSTANCE_ROOT:"=%\Upgrade21\"


ECHO ************************************************************************************
ECHO
ECHO SampleManager Instance      : %SM_INSTANCE%
ECHO SampleManager Instance Root : %INSTANCE_ROOT%
ECHO Staging Directory           : %STAGE%
ECHO SampleManager Exe Directory : %EXE%
ECHO SMP Executable              : %SMP%
ECHO Upgrade Directory Path      : %UPG%
ECHO
ECHO ************************************************************************************


ECHO ************************************************************************************
ECHO   Ensure services stopped
ECHO ************************************************************************************

call %~dp0\StopSampleManagerServices %SM_INSTANCE%


ECHO ************************************************************************************
ECHO   Disable auditing during upgrade
ECHO ************************************************************************************

ren %INSTANCE_ROOT:"=%\data\audits.sec audits.tmp


ECHO ************************************************************************************
ECHO   Increment service required to run SampleManager
ECHO ************************************************************************************
      
net start smplock%SM_INSTANCE%
net start smp%SM_INSTANCE%


ECHO ************************************************************************************
ECHO   Load CSVs (Pre Upgrade)
ECHO ************************************************************************************

%SMP% -batch -instance %SM_INSTANCE% -report $table_loader "%INSTANCE_ROOT%\Upgrade21\Data\normal\upgrade_report.csv"


ECHO ************************************************************************************
ECHO   Compile the COMPILE utility to allow multiple compiles
ECHO ************************************************************************************

time /t

%EXE%compiler -instance %SM_INSTANCE% compile

ECHO ************************************************************************************
ECHO   Compile necessary VGL reports before running upgrade
ECHO ************************************************************************************

time /t

%EXE%compiler -instance %SM_INSTANCE% $UPGRADE_DATA

