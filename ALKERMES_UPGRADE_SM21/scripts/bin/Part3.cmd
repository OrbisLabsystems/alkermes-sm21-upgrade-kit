REM
REM  Alkermes 21 Upgrade Script
REM
REM  Inputs 1. A clean SM21 install with merged structure 
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
ECHO RUN $SETUP -upgrade 
ECHO Performs the steps required to upgrade from a specified version
ECHO ************************************************************************************

time /t

%SMP% -batch -instance %SM_INSTANCE% -report $setup upgrade


ECHO ************************************************************************************
ECHO Run $UPGRADE
ECHO ************************************************************************************

time /t

ECHO **** 12.2 to 12.3 ****
%SMP% -batch -instance %SM_INSTANCE% -report $upgrade 12.2

ECHO **** 12.3 to 21.0 ****
%SMP% -batch -instance %SM_INSTANCE% -report $upgrade 12.3

