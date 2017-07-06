#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/joe/repos/GummiArm/orchestration/packages/src/gummi_interface"

# snsure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/joe/repos/GummiArm/orchestration/packages/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/joe/repos/GummiArm/orchestration/packages/install/lib/python2.7/dist-packages:/home/joe/repos/GummiArm/orchestration/packages/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/joe/repos/GummiArm/orchestration/packages/build" \
    "/usr/bin/python" \
    "/home/joe/repos/GummiArm/orchestration/packages/src/gummi_interface/setup.py" \
    build --build-base "/home/joe/repos/GummiArm/orchestration/packages/build/gummi_interface" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/joe/repos/GummiArm/orchestration/packages/install" --install-scripts="/home/joe/repos/GummiArm/orchestration/packages/install/bin"
