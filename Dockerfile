FROM microsoft/windowsservercore:latest    
MAINTAINER klaus_schaeffer

ENV ChocolateyUseWindowsCompression false

# Set your PowerShell execution policy
RUN powershell Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

# Install Chocolatey
RUN powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

# Install Chocolatey packages
RUN choco install git.install -y 

# Install PowerShell modules
#RUN powershell Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
#RUN powershell Install-Module -Name 'posh-git'

# Install vs2015 build tool
RUN choco install vcbuildtools -y 

# Install Visual Leak Detector
RUN choco install visualleakdetector -y 

# Install NASM
RUN choco install nasm -y
ENV YASM_PATH="C:\Program Files\NASM\nasm.exe"

# Install CMake
RUN choco install cmake.install -y --installargs ADD_CMAKE_TO_PATH=System

# Install DXSDK
RUN git clone https://github.com/devKlausS/dxsdk.git C:\dev\dxsdk
ENV DXSDK_DIR="C:\dev\dxsdk"