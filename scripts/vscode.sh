#!/bin/bash
SCRDIR=$1

# settings.json
mkdir -p "$SCRDIR"/custom/vscode
cat >"$SCRDIR"/custom/vscode/settings.json <<EOF
{
    // --- general --- //
    // telemetry
    "telemetry.telemetryLevel": "off",
    // workbench
    "workbench.startupEditor": "none",
    "workbench.colorTheme": "Dark Material Dracula",
    "workbench.iconTheme": "vscode-icons",
    // editor
    "editor.fontLigatures": true,
    "editor.fontFamily": "JetBrains Mono",
    "editor.fontSize": 14,
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true,
    "editor.detectIndentation": false,
    "editor.lineNumbers": "relative",

    // --- extensions --- //
    //dev containers
    "dev.containers.dockerPath": "$HOME/.local/bin/podman-host",
    // git
    "git.autofetch": false,
    "git.autoStash": false,
    "git.allowForcePush": false,
    // python
    "python.analysis.typeCheckingMode": "strict",
    // prettier
    "prettier.htmlWhitespaceSensitivity": "strict",
    "prettier.singleAttributePerLine": true,
    "prettier.proseWrap": "always",
    "prettier.tabWidth": 4,
    // license
    "license.author": "toufy <ar.toufic@protonmail.com>",
    "license.year": "auto",
    "license.filename": "LICENSE",
    "license.default": "gpl-3.0",
    "license.extension": "",
    // vim
    "vim.ignorecase": false,
    "vim.useSystemClipboard": true,
    // shellcheck
    "shellcheck.enable": true,
    "shellcheck.enableQuickFix": true,
    "shellcheck.run": "onType",
    "shellcheck.useWorkspaceRootAsCwd": true,

    // --- languages --- //
    "[java]": {
        "editor.defaultFormatter": "redhat.java"
    },
    "[python]": {
        "editor.defaultFormatter": "ms-python.black-formatter"
    },
    "[shellscript]": {
        "editor.defaultFormatter": "foxundermoon.shell-format"
    },
    "[dockerfile]": {
        "editor.defaultFormatter": "foxundermoon.shell-format"
    },
    "[ignore]": {
        "editor.defaultFormatter": "foxundermoon.shell-format"
    },
    "[jvmoptions]": {
        "editor.defaultFormatter": "foxundermoon.shell-format"
    },
    "[hosts]": {
        "editor.defaultFormatter": "foxundermoon.shell-format"
    },
    "[bats]": {
        "editor.defaultFormatter": "foxundermoon.shell-format"
    }
}
EOF
read -r -p "press enter to open settings.json in vim, modify and save it"
vim "$SCRDIR"/custom/vscode/settings.json

# install vscode flatpak if it doesn't exist
if ! flatpak list | grep -q com.visualstudio.code; then
    echo "vscode flatpak not found, installing"
    flatpak install --assumeyes flathub com.visualstudio.code
fi

# create config dir if it doesn't exist and copy settings.json
mkdir -p "$HOME"/.var/app/com.visualstudio.code/config/Code/User
cp -f "$SCRDIR"/custom/vscode/settings.json "$HOME"/.var/app/com.visualstudio.code/config/Code/User/
mkdir -p "$HOME"/.local/bin

# podman host wrapper (for dev containers extension)
cp -f "$SCRDIR"/.local/bin/podman-host "$HOME"/.local/bin/
