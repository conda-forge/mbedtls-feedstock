:: Setup directory structure
mkdir build
if errorlevel 1 exit 1

:: Configure 
cmake -B "build" -S . ^
         -DCMAKE_BUILD_TYPE=Release ^
         -DCMAKE_C_COMPILER=cl ^
         -DCMAKE_CXX_COMPILER=cl ^
         -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
         -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
         -DCMAKE_VERBOSE_MAKEFILE=ON ^
         -DUSE_SHARED_MBEDTLS_LIBRARY=ON ^
         -DENABLE_TESTING=Off
if errorlevel 1 exit 1

:: Build and install
cd build
cmake --build . --config Release --target install
if errorlevel 1 exit 1
