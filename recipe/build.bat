@echo off
setlocal EnableDelayedExpansion

:: Mbed TLS declares no DLL exports, so export all symbols to get import
:: libraries for the DLLs, and do not build the static libraries, whose .lib
:: files would otherwise overwrite the import libraries of the same name.
:: Based on the fix by Matthew Feickert for the 3.6.x branch.
cmake -G "Ninja" -B build -S . ^
         %CMAKE_ARGS% ^
         -DCMAKE_BUILD_TYPE=Release ^
         -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
         -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
         -DCMAKE_VERBOSE_MAKEFILE=ON ^
         -DUSE_SHARED_MBEDTLS_LIBRARY=ON ^
         -DUSE_STATIC_MBEDTLS_LIBRARY=OFF ^
         -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON ^
         -DENABLE_PROGRAMS=OFF ^
         -DENABLE_TESTING=OFF
if errorlevel 1 exit 1

cmake --build build
if errorlevel 1 exit 1
cmake --install build
if errorlevel 1 exit 1
