@echo off

cd %~dp0

call cleanup.bat
call build.bat
call cleanup.bat
