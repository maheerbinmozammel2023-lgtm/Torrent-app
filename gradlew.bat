@REM
@REM Copyright 2015 the original author or authors.
@REM
@REM Licensed under the Apache License, Version 2.0 (the "License");
@REM you may not use this file except in compliance with the License.
@REM You may obtain a copy of the License at
@REM
@REM      https://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing, software
@REM distributed under the License is distributed on an "AS IS" BASIS,
@REM WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@REM See the License for the specific language governing permissions and
@REM limitations under the License.
@REM

@echo off

REM Determine if a "PWRSH" environment variable is set to "true". If so, then it is assumed
REM that the execution environment is PowerShell and that the calling script has configured
REM cmd.exe's code page to UTF-8. Otherwise, assume that the execution environment is cmd.exe
REM and that the calling script has not configured cmd.exe's code page to UTF-8.
if "%PWRSH%" == "true" (
    set "JAVA_OPTS=%JAVA_OPTS% -Dfile.encoding=UTF-8"
)

REM Use UTF-8 for `findstr` results if supported by the OS.
for /f "tokens=*" %%a in ('wmic os get version /value ^| find "Version="') do (
    if "%%a" geq "Version=10.0.17763" (
        set "FINDSTR_OPTS=/c:"" /encoding:UTF-8"
    )
)

REM Determine if a JRE/JDK is available.
set "JAVA_CMD=java"
if not defined JAVA_HOME (
    for %%i in ("%JAVA_CMD%") do (
        if "%%~$PATH:i" neq "" (
            set "JAVA_HOME=%%~dpi"
            set "JAVA_HOME=%JAVA_HOME:~0,-1%"
            if exist "%JAVA_HOME%\jre" (
                set "JAVA_HOME=%JAVA_HOME%\jre"
            )
            goto findJavaCmd
        )
    )
) else (
    if exist "%JAVA_HOME%\jre\sh\java.exe" (
        set "JAVA_CMD=%JAVA_HOME%\jre\sh\java.exe"
    ) else if exist "%JAVA_HOME%\bin\java.exe" (
        set "JAVA_CMD=%JAVA_HOME%\bin\java.exe"
    ) else (
        echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
        echo Please set the JAVA_HOME environment variable to the root directory of your Java installation.
        exit /b 1
    )
)

:findJavaCmd
if not exist "%JAVA_CMD%" (
    echo ERROR: No Java found. Please install a JRE/JDK and set JAVA_HOME environment variable.
    exit /b 1
)

set "CURRENT_DIR=%~dp0"
set "APP_HOME=%CURRENT_DIR%.."

set "GRADLE_HOME=%APP_HOME%\gradle"

REM Set the GRADLE_USER_HOME if not already set
if not defined GRADLE_USER_HOME (
    set "GRADLE_USER_HOME=%USERPROFILE%\.gradle"
)

REM Set the GRADLE_OPTS if not already set
if not defined GRADLE_OPTS (
    set "GRADLE_OPTS=-Xmx64m -Xms64m"
)

set "WRAPPER_JAR=%APP_HOME%\gradle\wrapper\gradle-wrapper.jar"

if not exist "%WRAPPER_JAR%" (
    echo ERROR: Cannot find wrapper jar, please ensure gradle-wrapper.jar is in %APP_HOME%\gradle\wrapper
    exit /b 1
)

REM Set the GRADLE_JVM_ARGS if not already set
if not defined GRADLE_JVM_ARGS (
    set "GRADLE_JVM_ARGS="
)

REM Set the GRADLE_COMPLETION_INIT_SCRIPT if not already set
if not defined GRADLE_COMPLETION_INIT_SCRIPT (
    set "GRADLE_COMPLETION_INIT_SCRIPT="
)

REM Set the GRADLE_CLI_OPTS if not already set
if not defined GRADLE_CLI_OPTS (
    set "GRADLE_CLI_OPTS="
)

REM Set the GRADLE_ARGS if not already set
if not defined GRADLE_ARGS (
    set "GRADLE_ARGS="
)

REM Collect all arguments for the Java command
set "CMD_LINE_ARGS="
:loop_args
if "%~1" neq "" (
    set "CMD_LINE_ARGS=%CMD_LINE_ARGS% "%~1""
    shift
    goto loop_args
)

"%JAVA_CMD%" %JAVA_OPTS% %GRADLE_OPTS% %GRADLE_JVM_ARGS% -Dorg.gradle.appname="gradlew" -classpath "%WRAPPER_JAR%" org.gradle.wrapper.GradleWrapperMain %CMD_LINE_ARGS%
