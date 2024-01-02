setlocal EnableDelayedExpansion

:: Setup directory structure
mkdir build
cd build
if errorlevel 1 exit 1

:: Configure 
cmake -G "NMake Makefiles" ^
         "%CMAKE_ARGS%" ^
         -DCMAKE_BUILD_TYPE=Release ^
         -DCMAKE_C_COMPILER=cl ^
         -DCMAKE_CXX_COMPILER=cl ^
         -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
         -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
         -DCMAKE_VERBOSE_MAKEFILE=ON ^
         -DUSE_SHARED_MBEDTLS_LIBRARY=ON ^
         -DENABLE_TESTING=OFF ^
         ..
if errorlevel 1 exit 1

:: Build and install
nmake
if errorlevel 1 exit 1
nmake install
if errorlevel 1 exit 1
