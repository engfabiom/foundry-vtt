# Foundry VTT — Ambiente Dockerizado

Este repositório fornece um ambiente **Docker** completo para executar o **Foundry Virtual Tabletop (VTT)** em modo **headless** (sem interface gráfica), ideal para servidores e automação de campanhas.

> Licença: Unlicense — domínio público  
> Autor: Fabio Marques
> Foundry Virtual Tabletop é © Foundry Gaming LLC.  
> Este projeto **não distribui** o binário do Foundry; o usuário deve inserir seu próprio `FoundryVTT.zip`.

## 📦 Requisitos

Instale, antes de começar:

- [Docker](https://docs.docker.com/get-docker/) ≥ 24  
- [Docker Compose](https://docs.docker.com/compose/install/) ≥ v2  
- Acesso e Licensa FoundryVTT válida
- Arquivo de instalação do **FoundryVTT** (baixe e renomeie para `FoundryVTT.zip`)  

## ✅ Ambiente de Teste
- Windows 11 Pro 24H2
- Node.js 22 (Alpine)
- Docker Desktop 4.48.0 (207573)
- FoundryVTT-Node-13.350

## 📁 Estrutura do Projeto

```bash
.
├── data/               # dados persistentes (mundos, usuários, módulos)
│       └── .gitignore
├── .gitignore
├── Dockerfile
├── docker-compose.yml
├── FoundryVTT.zip      # depois do download do servidor
└── README.md
```

A pasta local `data/` é persistente e montada dentro do container como `/home/foundry/data` .

## ⚙️ Construção da Imagem

Crie a imagem `foundryvtt:latest` usando o Dockerfile.

Execute o comando na raiz do projeto:
```bash
docker compose build
```

## 🚀 Execução

Inicie o servidor:

```bash
docker compose up -d
```

O Foundry estará disponível em: `http://localhost:30000`


A primeira execução criará a estrutura padrão dentro de `./data`.

## 💾 Persistência de Dados

Os mundos, usuários e configurações são salvos no diretório local: `./data`

Esse volume é mapeado no container em `/home/foundry/data`.

Os dados permanecem mesmo após reiniciar ou recriar o container.

## 🔧 Parar e Atualizar

Pare o servidor:

```bash
docker compose down
```

Recrie após atualizar o Foundry (substituindo o ZIP):

```bash
docker compose build --no-cache
docker compose up -d
```

## 🧹 Limpeza (opcional)

Remover containers e volumes:

```bash
docker compose down -v
```

## ⚠️ Observações

- Use o FoundryVTT apenas com licença válida.
- `FoundryVTT.zip` não é versionado (.gitignore cobre o arquivo).

Se desejar logs em tempo real: 

```bash
docker compose logs -f
```
