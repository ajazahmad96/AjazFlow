#!/bin/sh
#
# Gradle start-up script for POSIX shells (standard wrapper launcher).
# Starts org.gradle.wrapper.GradleWrapperMain from gradle/wrapper/gradle-wrapper.jar,
# which downloads the distribution named in gradle/wrapper/gradle-wrapper.properties.

# Resolve links: $0 may be a link
app_path=$0
while [ -h "$app_path" ]; do
    ls=$( ls -ld "$app_path" )
    link=${ls#*' -> '}
    case $link in
        /*) app_path=$link ;;
        *) app_path=$( dirname "$app_path" )/$link ;;
    esac
done

APP_HOME=$( cd -P "$( dirname "$app_path" )" > /dev/null && pwd -P ) || exit 1
APP_BASE_NAME=${0##*/}

CLASSPATH=$APP_HOME/gradle/wrapper/gradle-wrapper.jar

if [ ! -f "$CLASSPATH" ]; then
    echo "ERROR: $CLASSPATH not found." >&2
    echo "Restore gradle-wrapper.jar (Gradle 8.10.2) from the official release or run:" >&2
    echo "    gradle wrapper --gradle-version 8.10.2" >&2
    exit 1
fi

# Determine the Java command to use to start the JVM.
if [ -n "$JAVA_HOME" ]; then
    if [ -x "$JAVA_HOME/jre/sh/java" ]; then
        JAVACMD=$JAVA_HOME/jre/sh/java
    else
        JAVACMD=$JAVA_HOME/bin/java
    fi
    if [ ! -x "$JAVACMD" ]; then
        echo "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME" >&2
        exit 1
    fi
else
    JAVACMD=java
    if ! command -v java > /dev/null 2>&1; then
        echo "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH." >&2
        exit 1
    fi
fi

# Default JVM options for the wrapper itself; JAVA_OPTS and GRADLE_OPTS may add more.
exec "$JAVACMD" -Xmx64m -Xms64m $JAVA_OPTS $GRADLE_OPTS \
    "-Dorg.gradle.appname=$APP_BASE_NAME" \
    -classpath "$CLASSPATH" \
    org.gradle.wrapper.GradleWrapperMain \
    "$@"
