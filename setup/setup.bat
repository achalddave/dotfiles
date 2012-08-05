@echo off
if exist "%programfiles(x86)%"\ (
	mklink "%programfiles(x86)%"\vim\.vimrc "%cd%\..\vimfiles\.vimrc"
	mklink "%programfiles(x86)%"\vim\.gvimrc "%cd%\..\vimfiles\.gvimrc"
) else (
	echo "32 bit"
	mklink "%programfiles%"\vim\.vimrc %cd%\..\vimfiles\.vimrc
	mklink "%programfiles%"\vim\.gvimrc %cd%\..\vimfiles\.gvimrc
)

