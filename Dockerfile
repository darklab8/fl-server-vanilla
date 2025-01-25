# docker-wine is a compatability layer between Windows and Linux.  Allows you to run Windows programs on Linux machines.
FROM scottyhardy/docker-wine:stable-9.0

EXPOSE 2302/udp

ENV WINEARCH="win32"

WORKDIR /app

# Install dependencies
RUN /usr/bin/entrypoint xvfb-run winetricks -q --force vcrun2022 vcrun6sp6 riched30

COPY Freelancer .
COPY EULABypass.reg \
    fl.py \
    ./

RUN mkdir -p "/home/wineuser/.wine/drive_c/users/wineuser/Documents/My Games/Freelancer/Accts/MultiPlayer"
COPY --chmod=777 FLServer.cfg ./
RUN cp FLServer.cfg "/home/wineuser/.wine/drive_c/users/wineuser/Documents/My Games/Freelancer/Accts/MultiPlayer"
RUN chmod a+rw -R "/home/wineuser/.wine/drive_c/users/wineuser/Documents/My Games"

ENTRYPOINT [ "/usr/bin/entrypoint", "python3", "fl.py" ]
