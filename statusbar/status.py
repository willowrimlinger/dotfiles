import requests
import os

DEVICES = [
    "Optiserv"
]

def main():
    connected_icon_path = "/home/willow/dotfiles/statusbar/check.svg"
    paused_icon_path = "/home/willow/dotfiles/statusbar/player-pause.svg"
    disconnected_icon_path = "/home/willow/dotfiles/statusbar/cloud-x.svg"

    api_key = None
    if not os.path.exists("/home/willow/dotfiles/statusbar/apikey"):
        print("No apikey file")
        return
    with open("/home/willow/dotfiles/statusbar/apikey", "r") as file:
        api_key = file.readline().replace("\n", "").strip()
    headers = {
        "Authorization": f"Bearer {api_key}"
    }

    device_name_to_id = dict()

    r = requests.get("http://localhost:8384/rest/config", headers=headers).json()
    for device in r["devices"]:
        device_name_to_id[device["name"]] = device["deviceID"]

    r = requests.get("http://localhost:8384/rest/system/connections", headers=headers).json()
    for name in DEVICES:
        connected = r["connections"][device_name_to_id[name]]["connected"]
        paused = r["connections"][device_name_to_id[name]]["paused"]
        if connected:
            icon = connected_icon_path
        elif paused:
            icon = paused_icon_path
        else:
            icon = disconnected_icon_path
        print(f"{name} USE_ICON:{icon}") 

if __name__ == "__main__":
    main()
