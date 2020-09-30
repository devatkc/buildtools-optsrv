# escape=`

# Use the latest Windows Server Core image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# Download the Build Tools bootstrapper.
ADD https://aka.ms/vs/16/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe

# Install Build Tools with workload
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
    --installPath C:\BuildTools `
    --add Microsoft.VisualStudio.Workload.VCTools `
    --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 `
    --add Microsoft.VisualStudio.Component.Windows10SDK.18362 `
 || IF "%ERRORLEVEL%"=="3010" EXIT 0

# Download odb
ADD https://www.codesynthesis.com/download/odb/2.4/odb-2.4.0-i686-windows.zip C:\

# Unzip odb
RUN cd C:\ && `
tar -xf odb-2.4.0-i686-windows.zip

# Download git for Windows
ADD https://github.com/git-for-windows/git/releases/download/v2.28.0.windows.1/Git-2.28.0-64-bit.exe C:\TEMP\Git-2.28.0-64-bit.exe

# Install git
RUN C:\TEMP\Git-2.28.0-64-bit.exe /VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"
