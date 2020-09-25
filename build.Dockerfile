# escape=`

# Use the latest base image
FROM devatkc/buildtools-optsrv:base

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# Download vcpkg
ADD https://github.com/microsoft/vcpkg/archive/master.zip C:\TEMP\vcpkg-master.zip

# Install vcpkg packages
RUN cd C:\TEMP && `
tar -xf vcpkg-master.zip && `
cd vcpkg-master && `
bootstrap-vcpkg.bat && `
vcpkg.exe install boost-asio boost-date-time boost-property-tree boost-timer boost-ublas boost-uuid --triplet x64-windows --clean-after-build && `
vcpkg.exe install libmysql libodb libodb-mysql protobuf zeromq cppzmq log4cplus libsodium gtest --triplet x64-windows --clean-after-build && `
vcpkg.exe integrate install

# Starts the developer command prompt as entry point
ENTRYPOINT ["C:\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&"]
