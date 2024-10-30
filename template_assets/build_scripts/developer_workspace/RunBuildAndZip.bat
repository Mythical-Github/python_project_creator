@echo off

cd %~dp0

call cleanup.bat
call build.bat
call make_release.bat
call zip_release.bat
call cleanup.bat
