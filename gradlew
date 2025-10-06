#!/usr/bin/env sh

##############################################################################
##
##  Gradle start up script for UN*X
##
##############################################################################

# Determine the Java command to use to start the JVM.
if [ -n "" ] ; then
    JAVA_HOME=""
fi
if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
        # IBM's JDK on AIX uses "$JAVA_HOME/jre/sh/java" as the actual executable.
        JAVA_CMD="$JAVA_HOME/jre/sh/java"
    else
        JAVA_CMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVA_CMD" ] ; then
        die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME\n\nPlease set the JAVA_HOME environment variable to the root directory of your Java installation."
    fi
else
    JAVA_CMD="java"
fi

DIR="$(dirname "$0")"

APP_NAME="Gradle"
APP_BASE_NAME=$(basename "$0")

# Add default JVM options here. You can also use the GRADLE_OPTS environment variable.
DEFAULT_JVM_OPTS="-Xmx64m -Xms64m"

# Use Jansi for coloring if available
if [ -t 1 ]; then
    if [ -n "$GRADLE_HOME" ]; then
        if [ -f "$GRADLE_HOME/lib/jansi-*.jar" ]; then
            DEFAULT_JVM_OPTS="$DEFAULT_JVM_OPTS -Dorg.gradle.console.colored=true"
        fi
    fi
fi

# OS specific support (must be 'true' or 'false').
cygwin=false
darwin=false
os400=false
case "$(uname)" in
    CYGWIN*) cygwin=true ;;
    Darwin*) darwin=true
             if [ -z "$JAVA_HOME" ] ; then
                 JAVA_HOME=$(/usr/libexec/java_home)
             fi
             ;;
    OS400*) os400=true ;;
esac

# For Cygwin, ensure paths are in UNIX format before anything else
if $cygwin ; then
    [ -n "$JAVA_HOME" ] && JAVA_HOME=$(cygpath --unix "$JAVA_HOME")
    [ -n "$HOME" ] && HOME=$(cygpath --unix "$HOME")
    DIR=$(cygpath --unix "$DIR")
fi

# Attempt to set APP_HOME
APP_HOME="$(cd "$DIR"/.. && pwd)"

# Attempt to set GRADLE_HOME (if not already set)
if [ -z "$GRADLE_HOME" ] ; then
    GRADLE_HOME=$(cd "$DIR"/.. && pwd)
fi

# Attempt to find if GRADLE_USER_HOME is defined
# (usually the .gradle dir in the user's home dir) 
# If not found, use APP_HOME/gradle, not really the best
# default if a user just does 'gradle install'
# and does not have the .gradle dir defined.

# Fallback to the default GRADLE_USER_HOME if not defined
# This can be overridden with the GRADLE_USER_HOME env var
if [ -z "$GRADLE_USER_HOME" ] ; then
    GRADLE_USER_HOME="$HOME/.gradle"
fi

# If APP_BASE_NAME is gradlew, then assume it's a wrapper execution
if [ "$APP_BASE_NAME" = "gradlew" ] ; then
    if [ -f "$APP_HOME/gradle/wrapper/gradle-wrapper.jar" ] ; then
        WRAPPER_JAR="$APP_HOME/gradle/wrapper/gradle-wrapper.jar"
    else
        die "ERROR: Cannot find wrapper jar, please ensure gradle-wrapper.jar is in $APP_HOME/gradle/wrapper"
    fi
fi

# Attempt to find if GRADLE_OPTS is defined
# if not found, assume default
if [ -z "$GRADLE_OPTS" ] ; then
    GRADLE_OPTS="$DEFAULT_JVM_OPTS"
fi

# Set the GRADLE_JAVA_HOME if not already set
if [ -z "$GRADLE_JAVA_HOME" ] ; then
    GRADLE_JAVA_HOME="$JAVA_HOME"
fi

# Set the GRADLE_OPTS if not already set
if [ -z "$GRADLE_OPTS" ] ; then
    GRADLE_OPTS="$DEFAULT_JVM_OPTS"
fi

# Set the GRADLE_CMD_OPTS if not already set
if [ -z "$GRADLE_CMD_OPTS" ] ; then
    GRADLE_CMD_OPTS=""
fi

# Set the GRADLE_ARGS if not already set
if [ -z "$GRADLE_ARGS" ] ; then
    GRADLE_ARGS=""
fi

# Set the GRADLE_COMPLETION_INIT_SCRIPT if not already set
if [ -z "$GRADLE_COMPLETION_INIT_SCRIPT" ] ; then
    GRADLE_COMPLETION_INIT_SCRIPT=""
fi

# Set the GRADLE_CLI_OPTS if not already set
if [ -z "$GRADLE_CLI_OPTS" ] ; then
    GRADLE_CLI_OPTS=""
fi

# Set the GRADLE_JVM_ARGS if not already set
if [ -z "$GRADLE_JVM_ARGS" ] ; then
    GRADLE_JVM_ARGS=""
fi

# Set the GRADLE_COMPLETION_SCRIPT if not already set
if [ -z "$GRADLE_COMPLETION_SCRIPT" ] ; then
    GRADLE_COMPLETION_SCRIPT=""
fi

# Set the GRADLE_HOME if not already set
if [ -z "$GRADLE_HOME" ] ; then
    GRADLE_HOME="$APP_HOME/gradle"
fi

# Set the GRADLE_DEFAULT_JAVA_HOME if not already set
if [ -z "$GRADLE_DEFAULT_JAVA_HOME" ] ; then
    GRADLE_DEFAULT_JAVA_HOME="$JAVA_HOME"
fi

# Collect all arguments for the Java command
ALL_ARGS=(
    -Dorg.gradle.appname="$APP_BASE_NAME"
    -classpath "$WRAPPER_JAR"
    org.gradle.wrapper.GradleWrapperMain
    "$@"
)

# Execute Java command
exec "$JAVA_CMD" "$GRADLE_OPTS" "$GRADLE_JVM_ARGS" "${ALL_ARGS[@]}"
