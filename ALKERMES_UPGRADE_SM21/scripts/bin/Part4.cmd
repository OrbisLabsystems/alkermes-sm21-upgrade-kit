REM
REM  Alkermes 21 Upgrade Script
REM
REM  Inputs 1. A clean SM21.00 install with merged structure 
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


ECHO ************************************************************************************
ECHO RUN $ENTITY_NAMES
ECHO Creates default values for blank name fields
ECHO ************************************************************************************

time /t

%SMP% -batch -instance %SM_INSTANCE% -report $entity_names

ECHO ************************************************************************************
ECHO Run UPDATE_DATE
ECHO ************************************************************************************

time /t

%SMP% -batch -instance %SM_INSTANCE% -report UPDATE_DATE

ECHO ************************************************************************************
ECHO   Load CSVs (Post Upgrade)
ECHO ************************************************************************************

%SMP% -batch -instance %SM_INSTANCE% - report $table_loader "%INSTANCE_ROOT%\Upgrade21\Data\overwrite\master_menu.csv" overwrite_table
%SMP% -batch -instance %SM_INSTANCE% - report $table_loader "%INSTANCE_ROOT%\Upgrade21\Data\overwrite\menu_toolbar.csv" overwrite_table


ECHO ************************************************************************************
ECHO Delete all files from smp$code prior to recompile
ECHO ************************************************************************************

del /f /q %INSTANCE_ROOT:"=%\Code\*.*

ECHO ************************************************************************************
ECHO Recompile all VGL code
ECHO ************************************************************************************

%SMP% -batch -instance %SM_INSTANCE% -report compile CALCULATION
%SMP% -batch -instance %SM_INSTANCE% -report compile LIMIT_CALCULATION
%SMP% -batch -instance %SM_INSTANCE% -report compile LIST_RESULT_FORMAT
%SMP% -batch -instance %SM_INSTANCE% -report compile REPORT
%SMP% -batch -instance %SM_INSTANCE% -report compile SIG_FIGS
%SMP% -batch -instance %SM_INSTANCE% -report compile SYNTAX

time /t

ECHO ************************************************************************************
ECHO   Update lims driver table 
ECHO ************************************************************************************

%SMP% -batch -instance %SM_INSTANCE% -report $limsdrv_setup

time /t

ECHO ************************************************************************************
ECHO   Start all SM services
ECHO ************************************************************************************

call %~dp0\StartSampleManagerServices %SM_INSTANCE%

time /t

ECHO ************************************************************************************
ECHO RE-ENABLE AUDITING
ECHO ************************************************************************************

ren %INSTANCE_ROOT:"=%\data\audits.tmp audits.sec

ECHO ************************************************************************************
ECHO Create Entity Definitions
ECHO ************************************************************************************

%EXE%CreateEntityDefinition -noschemabuild -instance %SM_INSTANCE%

time /t

ECHO ************************************************************************************
ECHO Form Import 
ECHO ************************************************************************************

%EXE%SampleManagerCommand -instance %SM_INSTANCE% -batch -task FormImport -directory "%SM_ROOT:"=%\Form" -all

ECHO ************************************************************************************
ECHO Form Build Definitions
ECHO ************************************************************************************

%EXE%SampleManagerCommand -instance %SM_INSTANCE% -batch -task BuildFormDefinition -xmldoc -rebuild


date /t
time /t

ECHO ************************************************************************************
ECHO ************************************************************************************
ECHO **                                                                                **
ECHO **      Upgrade Script Completed - PLEASE REVIEW THE LOGS FOLDER FOR ANY ERRORS   **
ECHO **                                                                                **
ECHO ************************************************************************************
ECHO ************************************************************************************
