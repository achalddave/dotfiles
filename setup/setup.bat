@echo off
setlocal enableextensions

mklink /H "%userprofile%"\.vimrc "%cd%\..\vimfiles\.vimrc"
mklink /H "%userprofile%"\.gvimrc "%cd%\..\vimfiles\.gvimrc"

mklink /H "%userprofile%"\.gitconfig "%cd%\..\gitfiles\.gitconfig"
mklink /H "%userprofile%"\.gitignore_global "%cd%\..\gitfiles\.gitignore_global"
mklink /H "%userprofile%"\.inputrc "%cd%\..\.inputrc"
mklink /H "%userprofile%"\.bashrc "%cd%\..\.bashrc"
mklink /H "%userprofile%"\.bashrc_local "%cd%\..\local\.bashrc"
mklink /H "%userprofile%"\.inputrc "%cd%\..\.inputrc"
REM mklink "%userprofile%"\Documents\WindowsPowershell\Microsoft.Powershell_profile.ps1 "%cd%"\..\powershell\profile.ps1
