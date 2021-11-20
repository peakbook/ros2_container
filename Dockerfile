FROM osrf/ros:foxy-desktop

# install basic packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    fluxbox \
    net-tools \
    novnc \
    stterm \
    supervisor \
    tmux \
    vim \
    websockify \
    wget \
    x11vnc \
    xrdp \
    xvfb \
    && apt-get clean -y \
    && rm -r /var/lib/apt/lists/*

COPY ./supervisord.conf /etc/supervisord.conf
COPY ./xrdp.ini /etc/xrdp/xrdp.ini
COPY ./ros_entrypoint_with_display.sh /ros_entrypoint_with_display.sh
COPY ./menu /root/.fluxbox/menu

ENV DISPLAY=:0
ENV RESOLUTION=1920x1080
ENV VNC_PASSWD=password

# for vnc, novnc, rdp
EXPOSE 5901 6901 3389

WORKDIR /work
ENTRYPOINT ["/ros_entrypoint_with_display.sh"]
CMD ["/bin/bash"]

