@echo off
setlocal enabledelayedexpansion

rem Run the build2 command and redirect output to a file
b -v clean update 2> build2_output.txt 

rem Temporary file for storing the commands
set "commands_file=commands.txt"
if exist "%commands_file%" del "%commands_file%"

rem Read the output file line by line
for /f "usebackq tokens=*" %%a in ("build2_output.txt") do (
    set "line=%%a"

    rem Replace backslashes with forward slashes
    set "line=!line:\=/%!"

    rem Check if the line starts with "clang++"
    if "!line:~0,7!"=="clang++" (
        rem Properly handle spaces and remove specific flags
        set "line=!line:-o = -o !"
        set "line=!line:-fdiagnostics-color =!"
        set "line=!line:-fansi-escape-codes =!"
        set "line=!line:-finput-charset=UTF-8 =!"

        rem Ensure proper spacing and add missing spaces
        set "line=!line:  = !"

        rem Check for any missing file names
        if not "!line!"=="clang++" (
            rem Echo the modified line for debugging purposes (optional)
            echo !line!

            rem Add the modified line to the commands file
            echo !line! >> "%commands_file%"
        )
    )
)

rem Check if the commands file was created and contains valid commands
if not exist "%commands_file%" (
    echo Error: Commands file was not created.
    exit /b 1
)

rem Run compiledb with the generated commands file
compiledb --parse "%commands_file%" --verbose

rem Clean up temporary files
del build2_output.txt
del "%commands_file%"
endlocal
