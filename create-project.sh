#!/bin/bash

REPO_URL="https://github.com/edsuuu/template-laravel.git"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

read -p "Digite o nome do novo projeto: " PROJECT_NAME

if [ -z "$PROJECT_NAME" ]; then
    echo -e "${RED}Erro: Nome do projeto é obrigatório.${NC}"
    exit 1
fi

for cmd in git php composer; do
    if ! command -v $cmd &> /dev/null; then
        echo -e "${RED}Você não tem o comando $cmd instalado. Instale e por favor tente rodar o instalador novamente.${NC}"
        exit 1
    fi
done

PKG_MANAGER="npm"
if command -v pnpm &> /dev/null; then
    PKG_MANAGER="pnpm"
fi

git clone $REPO_URL $PROJECT_NAME || { echo -e "${RED}Falha ao clonar o repositório.${NC}"; exit 1; }

cd $PROJECT_NAME

cp .env.example .env

sedi() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i "" "$@"
    else
        sed -i "$@"
    fi
}

sedi "s/APP_NAME=.*/APP_NAME=\"$PROJECT_NAME\"/g" .env
DB_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr '-' '_')
sedi "s/DB_DATABASE=.*/DB_DATABASE=$DB_NAME/g" .env
sedi "s/\"name\": \".*\"/\"name\": \"laravel\/$PROJECT_NAME\"/g" composer.json

# Ajustar composer.json para usar pnpm se disponível
if [ "$PKG_MANAGER" = "pnpm" ]; then
    sedi "s/npm install/pnpm install/g" composer.json
    sedi "s/npm run build/pnpm run build/g" composer.json
fi

rm -rf .git
git init
composer setup

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Projeto ${PROJECT_NAME} criado com sucesso utilizando ${PKG_MANAGER}.${NC}"
else
    echo -e "${RED}Falha no setup do projeto.${NC}"
fi
