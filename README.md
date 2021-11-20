# ROS2 container with VNC/NOVNC/RDP

Minimal ROS2 container with VNC, NOVNC, and RDP. 

## Base image

- [osrf/ros:foxy-desktop](https://hub.docker.com/r/osrf/ros)


## Build image

```bash
$ podman build -t myros:foxy-desktop-display . 
```

## Run 

- VNC (localhost:5901)
```bash
$ podman run -it -d --rm -p 5901:5901 -e VNC_PASSWD=password myros:foxy-desktop-display
```

- NOVNC (http://localhost:6901/vnc.html)
```bash
$ podman run -it -d --rm -p 6901:6901 -e VNC_PASSWD=password myros:foxy-desktop-display
```

- RDP (locahost:3389)
```bash
$ podman run -it -d --rm -p 3389:3389 -e VNC_PASSWD=password myros:foxy-desktop-display 
```

