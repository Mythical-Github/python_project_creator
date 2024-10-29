@echo off
setlocal EnableDelayedExpansion


:: Define paths
set "jq_path=%~dp0jq.exe"
set "json_file=%~dp0ProjectInfo.json"
set "jq_url=https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-win64.exe"


:: Check if JSON file exists
if not exist "%json_file%" (
    echo ProjectInfo.json file not found. Please ensure data.json is in the same directory.
    exit /b 1
)


:: Check if jq.exe is in the same directory as the batch file
if not exist "%jq_path%" (
    echo jq.exe not found. Downloading jq...
    powershell -command "Invoke-WebRequest -Uri %jq_url% -OutFile '%jq_path%'"
    
    if not exist "%jq_path%" (
        echo Failed to download jq. Exiting.
        exit /b 1
    )
    echo jq.exe downloaded successfully.
)


:: Parse JSON using jq and set variables
for /f "delims=" %%A in ('%jq_path% -r ".ProjectName" "%json_file%"') do set "ProjectName=%%A"
for /f "delims=" %%A in ('%jq_path% -r ".PythonVersion" "%json_file%"') do set "PythonVersion=%%A"


:: Parse Modules array and store each module in a variable
set i=0
for /f "delims=" %%A in ('%jq_path% -r ".Modules[]" "%json_file%"') do (
    set /a i+=1
    set "Module[!i!]=%%A"
)


:: Output values
echo ProjectName: %ProjectName%
echo PythonVersion: %PythonVersion%


:: List all modules
set j=1
:module_loop
if defined Module[%j%] (
    echo Module %j%: !Module[%j%]!
    set /a j+=1
    goto module_loop
)


:: Create project base directory
set "project_dir=%~dp0%ProjectName%"

if exist "%project_dir%" (
    rmdir /s /q "%project_dir%"
)


if not exist "%project_dir%" (
    mkdir "%project_dir%"
)


:: Copy base source files into the new project
set "src_src_files_dir=%~dp0template_assets\src"
set "dst_py_dir=%project_dir%\src\%ProjectName%"

robocopy "%src_src_files_dir%" "%dst_py_dir%" /MIR > NUL


:: Copy the build scripts over into the new project
set "src_build_scripts_dir=%~dp0template_assets\build_scripts"
set "dst_build_scripts_dir=%project_dir%\build_scripts"

robocopy "%src_build_scripts_dir%" "%dst_build_scripts_dir%" /MIR > NUL


:: Copy the ProjectInfo.json over into the new project
set "src_src_files_dir=%~dp0template_assets\src"
set "dst_py_dir=%project_dir%\src\%ProjectName%"

xcopy "%src_src_files_dir%" "%dst_py_dir%" /E /I /Y > NUL


:: Copy the images folder over into the new project
set "src_images_dir=%~dp0template_assets\images"
set "dst_images_dir=%project_dir%\images"

robocopy "%src_images_dir%" "%dst_images_dir%" /MIR > NUL


endlocal
