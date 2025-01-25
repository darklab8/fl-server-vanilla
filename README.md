# Description

Freelancer Vanilla game server in docker.

# For usage

- `mkdir data ; $(cd data && wget https://raw.githubusercontent.com/darklab8/fl-server-vanilla/master/FLServer.cfg)` // or put your own desired config
- `docker run -v $(pwd)/data:"/home/wineuser/.wine/drive_c/users/wineuser/Documents/My Games/Freelancer/Accts/MultiPlayer" -it -p 2302/udp darkwind8/fl-server-vanilla:v0.1.2`
    - check latest tags at [Docker hub](<https://hub.docker.com/r/darkwind8/fl-server-vanilla/tags>)

# Acknowledgements

- Achievement to do dockerization belongs to @Lazrius
- @dd84ai just tested it to work, formed repo, wrote CI and published this repo.
