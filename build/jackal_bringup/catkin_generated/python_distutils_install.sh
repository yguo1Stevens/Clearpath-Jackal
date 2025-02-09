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
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/sunny/jackal_ws/src/jackal_robot/jackal_bringup"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/sunny/jackal_ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/sunny/jackal_ws/install/lib/python3/dist-packages:/home/sunny/jackal_ws/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/sunny/jackal_ws/build" \
    "/usr/bin/python3" \
    "/home/sunny/jackal_ws/src/jackal_robot/jackal_bringup/setup.py" \
     \
    build --build-base "/home/sunny/jackal_ws/build/jackal_robot/jackal_bringup" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/sunny/jackal_ws/install" --install-scripts="/home/sunny/jackal_ws/install/bin"
