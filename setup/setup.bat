@echo off
setlocal enableextensions

mklink "%userprofile%"\.vimrc "%cd%\..\vimfiles\.vimrc"
mklink "%userprofile%"\.gvimrc "%cd%\..\vimfiles\.gvimrc"

mklink "%userprofile%"\.gitconfig "%cd%\..\gitfiles\.gitconfig"
mklink "%userprofile%"\.gitignore_global "%cd%\..\gitfiles\.gitignore_global"
mklink "%userprofile%"\.inputrc "%cd%\..\.inputrc"
mklink "%userprofile%"\.bashrc "%cd%\..\.bashrc"
mklink "%userprofile%"\.bashrc_local "%cd%\..\local\.bashrc"
mklink "%userprofile%"\.inputrc "%cd%\..\.inputrc"
REM mklink "%userprofile%"\Documents\WindowsPowershell\Microsoft.Powershell_profile.ps1 "%cd%"\..\powershell\profile.ps1
