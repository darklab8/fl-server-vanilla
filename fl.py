#!/usr/bin/env python3

from pathlib import Path
import subprocess
import sys

path_str = "/home/wineuser/.wine/drive_c/users/wineuser/Documents/My Games/Freelancer/Accts/MultiPlayer"
Path(path_str).mkdir(parents=True, exist_ok=True)

try:
    # This stuff is not working with Docker volumes anyway.
    # Rely onto Taskfile.yml `task init` instead
    # wrote only for people that tested launching Freelancer server without data persistance
    try:
        Path(path_str).chmod(0o777)
    except Exception as err:
        print("failed to chmod server folder", str(err))

    config_name = "FLServer.cfg"
    print("checking pressence of server config")
    if not (Path(path_str) / config_name).exists():
        print("server config does not exist. copying")
        subprocess.run(f"cp /app/{config_name} '{path_str}'", shell=True)
except Exception as err:
    print("failed to init default server config", str(err))
    

# We have to install directplay manually due to registrations not being done correctly within the dockerfile
process = subprocess.Popen(["xvfb-run", "winetricks", "-q", "--force", "directplay"], 
                           stdout=sys.stdout, stderr=sys.stderr)
process.wait()

process = subprocess.Popen(["xvfb-run", "wineconsole", "regedit", "/app/EULABypass.reg"], 
                           stdout=sys.stdout, stderr=sys.stderr)
process.wait()

# Run FLServer with the provided config
result = subprocess.Popen(["xvfb-run", "wine", "/app/EXE/FLServer.exe", "/c" ], 
                          cwd="/app/EXE", stdout=sys.stdout, stderr=sys.stderr)
result.wait()