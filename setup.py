import json
import subprocess
import sys
from os import geteuid, path
from typing import Any

from misc import Colors

SCRDIR = path.dirname(path.abspath(__file__))
PROG = f"{SCRDIR}/prog.json"

if not path.exists(PROG):
    data = {
        "1": {
            "create configs": {
                "1": {"copy home configs": False},
                "2": {"nvidia setup": False},
                "3": {"plymouth setup": False},
                "4": {"secure boot setup": False},
                "5": {"refind setup": False},
                "6": {"regenerate initramfs": False},
            },
        },
        "2": {"install software": {"1": {"base tools": False}, "2": {"paru": False}}},
        "3": {
            "setup environment": {
                "1": {"copy shell configs": False},
                "2": {"copy kitty terminfo": False},
                "3": {"setup distrobox": False},
                "4": {"setup userdirs": False},
            }
        },
    }
    with open(PROG, "w") as json_file:
        json_file.write(json.dumps(data, indent=4))


def read_json(file: str):
    with open(file, "r") as data:
        json_dict = json.load(data)
    return json_dict


def write_json(file: str, data: Any):
    with open(file, "w") as json_file:
        json_file.write(json.dumps(data, indent=4))


def color(txt: str, mode: bool | None = None):
    return Colors().color(txt, mode)


def get_key(n: int, options: dict[str, Any]) -> str:
    return list(options[str(n)].keys())[0]


def get_item(n: int, options: dict[str, Any]):
    return list(options[str(n)].values())[0]


def run_script(script: str):
    x = ["bash", f"{SCRDIR}/scripts/{script}", SCRDIR]
    run = subprocess.run(x)
    return run.returncode


def action_script(actions: dict[str, dict[str, bool]], opt: str):
    while True:
        try:
            for i in range(1, len(actions) + 1):
                action = get_key(i, actions)
                state = get_item(i, actions)
                print(f"{color(f'{i}:')} {color(action, state)}")
            print(color("0: back"))
            n = int(input(color("option: ")))
            if n == 0:
                break
            elif n <= len(actions):
                action_key = get_key(n, actions)
                script = f'{opt.replace(" ", "-")}/{action_key.replace(" ", "_")}.sh'
                run = run_script(script)
                if run == 0:
                    actions.update({str(n): {action_key: True}})
                else:
                    print(
                        color(
                            f"something went wrong, return code for '{script}' was '{run}'",
                            False,
                        )
                    )
                return actions
            else:
                raise ValueError
        except ValueError:
            print(color("invalid option", False))
        except KeyboardInterrupt:
            print("")
            pass


def main_menu():
    prog = read_json(PROG)
    while True:
        try:
            for i in range(1, len(prog) + 1):
                action = get_key(i, prog)
                print(f"{color(f'{i}:')} {action}")
            print(color("0: quit"))
            n = int(input(color("option: ")))
            if n == 0:
                break
            elif n <= len(prog):
                opt = get_key(n, prog)
                actions = prog[str(n)][opt]
                actions = action_script(actions, opt)
                prog[str(n)][opt] = actions
                write_json(PROG, prog)
            else:
                raise ValueError
        except ValueError:
            print(color("invalid option", False))
        except KeyboardInterrupt:
            print("")
            pass


if geteuid() == 0:
    print(color("do not run this as root.\nwhen necessary, the scripts will use sudo.", False))
    sys.exit(1)

main_menu()
