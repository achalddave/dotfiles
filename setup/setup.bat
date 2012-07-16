@echo off
REM 64 bit machine
if exist "%programfiles(x86)%"\ (
	echo "64 bit"
	mklink "%programfiles(x86)%"\vim\.vimrc %cd%\..\vimfiles\.vimrc
	mklink "%programfiles(x86)%"\vim\.gvimrc %cd%\..\vimfiles\.gvimrc
	mklink /d "%programfiles(x86)%\vim\vimfiles\autoload" %cd%\..\vimfiles\.vim\autoload
	mklink /d "%programfiles(x86)%\vim\vimfiles\plugin" %cd%\..\vimfiles\.vim\plugin
) else (
	echo "32 bit"
	mklink "%programfiles%"\vim\.vimrc %cd%\..\vimfiles\.vimrc
	mklink "%programfiles%"\vim\.gvimrc %cd%\..\vimfiles\.gvimrc
	mklink /d "%programfiles%\vim\vimfiles\autoload" %cd%\..\vimfiles\.vim\autoload
	mklink /d "%programfiles%\vim\plugin" %cd%\..\vimfiles\.vim\plugin
)

