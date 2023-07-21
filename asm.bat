@echo off
goto init
:configs


::========================CONFIGS==========================::
::
:: ASM File option (optional)
set options=1
set file_name=main
set file_ext=asm
set entry=_start
::
:: Data Folder : (basic : .asm)
::set dat_folder=YOUR DATA FOLDER
::
:: Pause At The End :
::set pause=1
::
:: Removal of the exe file
::set remexe=1
::
:: Removal of the asm file
::set remasm=1
::
:: System (basic : x64)
::set system=32
:: Info : You have to delete the data folder
::
:: Dlls
::set dlls = kernel32.dll
:: Info : You have to delete the data folder
::
:: Don't delete .obj file
::set remobj=0
:: Info : You have to delete the data folder
::
::==========================INFOS==========================::
::
:: You can change the compilation setting in :
::/YOUR DATA FOLDER/compiler.bat
::
:: Basic compile options :
::nasm -f win%%system%% %file%.%ext% -o %file%.obj 
::golink %file%.obj /entry %entry% /console %%dlls%%
::del %file%.obj 
::
::=========================================================::

goto start

:data

if %options%==0 set /p file_name=File name : 
if %options%==0 set /p file_ext=ASM extension : 
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
   set /A "start=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100"
)
mkdir %dat_folder%
echo %file_name%>%dat_folder%/file.dat
echo %file_ext%>%dat_folder%/ext.dat
echo nasm -f win%%system%% %%file%%.%%ext%% -o %%file%%.obj >%dat_folder%/compile.bat
echo golink %%file%%.obj /entry %%entry%% /console %%dlls%% >>%dat_folder%/compile.bat
if %remobj% == 1 echo del %%file%%.obj >>%dat_folder%/compile.bat
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
   set /A "end=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100"
)
set /A elapsed=end-start
echo.
set /A hh=elapsed/(60*60*100), rest=elapsed%%(60*60*100), mm=rest/(60*100), rest%%=60*100, ss=rest/100, cc=rest%%100
if %mm% lss 10 set mm=0%mm%
if %ss% lss 10 set ss=0%ss%
if %cc% lss 10 set cc=0%cc%
echo DATA Wrote successfuly in %mm%:%ss%,%cc%
goto start

:start

if not exist %dat_folder%/file.dat goto data
if not exist %dat_folder%/ext.dat goto data

FOR /F %%i IN (%dat_folder%/file.dat) DO set file=%%i
FOR /F %%i IN (%dat_folder%/ext.dat) DO set ext=%%i

:: Time at the beginning of the compilation
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
   set /A "start=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100"
)

:: Compilator // You can change it with your tools
call .asm\compile.bat

:: Time at the end of the compilation
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
   set /A "end=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100"
)

:: Echo the time of the compilation
set /A elapsed=end-start
echo.
set /A hh=elapsed/(60*60*100), rest=elapsed%%(60*60*100), mm=rest/(60*100), rest%%=60*100, ss=rest/100, cc=rest%%100
if %mm% lss 10 set mm=0%mm%
if %ss% lss 10 set ss=0%ss%
if %cc% lss 10 set cc=0%cc%
echo Compiled in %mm%:%ss%,%cc%
echo.
echo #######################################
echo #             Lauching :              #
echo #######################################
echo.

:: Time at the beginning of the program
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
   set /A "start=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100"
)

:: Launch code
%file%.exe

:: Time at the end of the program
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
   set /A "end=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100"
)


:: Echo the time of the program
set /A elapsed=end-start
echo.
set /A hh=elapsed/(60*60*100), rest=elapsed%%(60*60*100), mm=rest/(60*100), rest%%=60*100, ss=rest/100, cc=rest%%100
if %mm% lss 10 set mm=0%mm%
if %ss% lss 10 set ss=0%ss%
if %cc% lss 10 set cc=0%cc%
echo Duration : %mm%:%ss%,%cc%
echo Started at : %start%, End at %end%

goto end

:init

set dat_folder=.asm
set options=0
set pause=0
set remexe=0
set remasm=0
set remobj=1
set system=64
set entry=_start
set dlls = kernel32.dll
goto configs

:end

if %pause% == 1 pause
if %remexe% == 1 del %file%.exe
if %remasm% == 1 del %file%.%ext%

exit
