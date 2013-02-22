@echo off
setlocal enableextensions

if exist "%programfiles(x86)%"\ (
	mklink "%programfiles(x86)%"\vim\.vimrc "%cd%\..\vimfiles\.vimrc"
	mklink "%programfiles(x86)%"\vim\.gvimrc "%cd%\..\vimfiles\.gvimrc"
) else (
	mklink "%programfiles%"\vim\.vimrc "%cd%\..\vimfiles\.vimrc"
	mklink "%programfiles%"\vim\.gvimrc "%cd%\..\vimfiles\.gvimrc"
)

mklink "%userprofile%"\.gitconfig "%cd%\..\gitfiles\.gitconfig"
mklink "%userprofile%"\.gitignore_global "%cd%\..\gitfiles\.gitignore_global"
mklink "%userprofile%"\.bashrc "%cd%\..\.bashrc"
mklink "%userprofile%"\.inputrc "%cd%\..\.inputrc"
mklink "%userprofile%"\Documents\WindowsPowershell\Microsoft.Powershell_profile.ps1 "%cd%"\..\powershell\profile.ps1
