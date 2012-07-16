@echo off
REM 64 bit machine
if exist "%programfiles(x86)%"\ (
	echo "64 bit"
	echo %cd%
	mklink "%programfiles(x86)%"\vim\.vimrc "%cd%\..\vimfiles\.vimrc"
	mklink "%programfiles(x86)%"\vim\.gvimrc "%cd%\..\vimfiles\.gvimrc"
) else (
	echo "32 bit"
	mklink "%programfiles%"\vim\.vimrc %cd%\..\vimfiles\.vimrc
	mklink "%programfiles%"\vim\.gvimrc %cd%\..\vimfiles\.gvimrc
)

