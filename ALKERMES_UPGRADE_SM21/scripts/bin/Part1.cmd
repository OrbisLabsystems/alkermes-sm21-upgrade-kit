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
ECHO Upgrading SampleManager Instance %SM_INSTANCE%
ECHO ************************************************************************************

time /t

ECHO ************************************************************************************
ECHO Copy files from Staging folder
ECHO ************************************************************************************

xcopy /e "%STAGE:"=%\12.3\Calculation"            "%INSTANCE_ROOT:"=%\Calculation" /Y
xcopy /e "%STAGE:"=%\12.3\Limit_Calculation"      "%INSTANCE_ROOT:"=%\Limit_Calculation" /Y
xcopy /e "%STAGE:"=%\12.3\Resultfiles"            "%INSTANCE_ROOT:"=%\ResultFiles" /Y
xcopy /e "%STAGE:"=%\12.3\Sig_Figs"               "%INSTANCE_ROOT:"=%\Sig_Figs" /Y
xcopy /e "%STAGE:"=%\12.3\Syntax"                 "%INSTANCE_ROOT:"=%\Syntax" /Y
xcopy /e "%STAGE:"=%\12.3\Text"                   "%INSTANCE_ROOT:"=%\Text" /Y
xcopy /e "%STAGE:"=%\12.3\Textreport"             "%INSTANCE_ROOT:"=%\Textreport" /Y
xcopy /e "%STAGE:"=%\12.3\Userfiles"              "%INSTANCE_ROOT:"=%\Userfiles" /Y
xcopy /e "%STAGE:"=%\12.3\Resource\LabelTemplate" "%INSTANCE_ROOT:"=%\Resource\LabelTemplate" /Y
xcopy /e "%STAGE:"=%\12.3\Worksheet"              "%INSTANCE_ROOT:"=%\Worksheet" /Y
xcopy "%STAGE:"=%\12.3\Data\audits.sec"           "%INSTANCE_ROOT:"=%\Data" /Y

ECHO ************************************************************************************
ECHO Copy Upgrade folder from Staging folder to %INSTANCE_ROOT%\Upgrade21 folder
ECHO ************************************************************************************

xcopy /i /s "%STAGE:"=%\upgrade"          "%INSTANCE_ROOT:"=%\Upgrade21" /Y

ECHO ************************************************************************************
ECHO Copy upgrade files to their respective folders where required
ECHO ************************************************************************************

mkdir "%INSTANCE_ROOT:"=%\Imprint"
mkdir "%INSTANCE_ROOT:"=%\Exe\Forms\Overlay"

xcopy "%STAGE:"=%\upgrade\Data\structure.txt" "%INSTANCE_ROOT:"=%\Data" /Y
xcopy "%STAGE:"=%\upgrade\Data\audits.sec"    "%INSTANCE_ROOT:"=%\Data" /Y
xcopy /s "%STAGE:"=%\upgrade\Report"          "%INSTANCE_ROOT:"=%\Report" /Y
xcopy /s "%STAGE:"=%\upgrade\Message"         "%INSTANCE_ROOT:"=%\Message" /Y
xcopy "%STAGE:"=%\upgrade\Imprint"            "%INSTANCE_ROOT:"=%\Imprint" /Y
xcopy "%STAGE:"=%\upgrade\Exe\Forms\Overlay"  "%INSTANCE_ROOT:"=%\Exe\Forms\Overlay" /Y

ECHO ************************************************************************************
ECHO Make sure services are running
ECHO ************************************************************************************

call %~dp0\StartSampleManagerServices %SM_INSTANCE%

ECHO ************************************************************************************
ECHO Create Entity Definitions
ECHO ************************************************************************************

%EXE%CreateEntityDefinition -noschemabuild -instance %SM_INSTANCE%

ECHO ************************************************************************************
ECHO Rebuild Tables and Indexes
ECHO ************************************************************************************

%EXE%convert_table -instance %SM_INSTANCE% -mode convert -tables * -noconfirm

ECHO ************************************************************************************
ECHO Create Messages
ECHO ************************************************************************************

%EXE%create_message -instance %SM_INSTANCE% 

ECHO ************************************************************************************
ECHO   Ensure services stopped
ECHO ************************************************************************************

call %~dp0\StopSampleManagerServices %SM_INSTANCE%

