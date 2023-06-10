#!/usr/bin/env --split-string=python -u

# fmt: off
import json  # isort:skip
import time
import gi

gi.require_version("Playerctl", "2.0")

from gi.repository import GLib, Playerctl

# fmt: on


DEFAULT_INFO = {
    "artist": "Unknown",
    "title": "Unknown",
    "album": "Unknown",
    "status": "Stopped",
    "player": "none",
    "volume": "0",
}

UNAVAILABLE = {
    "artist": "Unavailable",
    "title": "Unavailable",
    "ablum": "Unknown",
    "status": "Stopped",
    "player": "none",
    "volume": "0",
}


def prettify_list(listObj):
    prettified = ""

    if len(listObj) <= 2:
        # Artist1 and Artist2
        prettified = "and".join(listObj)
    else:
        # Artist1, Artist2 and Artist3
        prettified = ", ".join(listObj[:-1]) + "and" + listObj[-1]

    return prettified or "Unknown"


def player_metadata(player):
    # override default with metadata
    info = DEFAULT_INFO | {
        key.split(":")[-1]: value or "Unknown"
        for key, value in dict(player.props.metadata).items()
    }

    info["player"] = player.props.player_name or "none"
    info["status"] = player.props.status or "Stopped"
    info["volume"] = player.props.volume or "0"

    info["position"] = player.get_position()

    info["timestamp"] = int(time.time())

    # prettify artist list
    if type(info.get("artist")) == list:
        info["artist"] = prettify_list(info["artist"])
    if type(info.get("albumArtist")) == list:
        info["albumArtist"] = prettify_list(info["albumArtist"])

    return info


def print_metadata():
    print(
        json.dumps(
            [player_metadata(player) for player in manager.props.players]
            or [UNAVAILABLE]
        )
    )


def init_player(name):
    # choose if you want to manage the player based on the name
    player = Playerctl.Player.new_from_name(name)

    player.connect("playback-status::playing",
                   lambda *_: print_metadata(), manager)
    player.connect("playback-status::paused",
                   lambda *_: print_metadata(), manager)
    player.connect("metadata", lambda *_: print_metadata(), manager)
    player.connect("volume", lambda *_: print_metadata(), manager)

    manager.manage_player(player)


manager = Playerctl.PlayerManager()

manager.connect("name-appeared", lambda _, name: init_player(name))
manager.connect("player-vanished", lambda *_: print_metadata())

if manager.props.player_names:
    for name in manager.props.player_names:
        init_player(name)

print_metadata()

main = GLib.MainLoop()
main.run()
