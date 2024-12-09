#!/bin/bash#!/bin/bash

# Ange sökvägen till din Restic lösenordsfil (den här filen ska innehålla ditt Restic-lösenord)
export RESTIC_PASSWORD_FILE="/home/sharre123/.restic_password"


export RESTIC_REPOSITORY="ssh://sharre123@192.168.44.3:/path/to/backup/directory"

# Kontrollera om lösenordsfilen finns
if [ ! -f "$RESTIC_PASSWORD_FILE" ]; then
  echo "Restic password file not found!"
  exit 1
fi

# Explicit definiera $HOME och $XDG_CACHE_HOME om de inte är definierade
export HOME="/home/sharre123"
export XDG_CACHE_HOME="$HOME/.cache"

# Ange lokala kataloger som du vill inkludera för backup (inklusive $HOME och $XDG_CACHE_HOME)
LOCAL_BACKUP_DIRECTORIES=(
    "$HOME"                          # Hela användarens hemkatalog
    "$XDG_CACHE_HOME"                # Cache-katalogen (om den är definierad)
    "/path/to/files/to/backup"       # Specifik mapp eller filer som ska säkerhetskopieras
)

# Initiera repositoriet (detta steg behöver bara göras en gång)
restic init

# Utför backupen med flaggan --insecure-no-password för att köra utan lösenord
# (bara för utvecklingsändamål - bör inte användas i produktion utan säker autentisering)
restic backup --insecure-no-password "${LOCAL_BACKUP_DIRECTORIES[@]}"

# Rensa gamla snapshots (här tar vi bort alla gamla backups och behåller de senaste 5)
restic forget --prune --keep-last 5
                                                                          
