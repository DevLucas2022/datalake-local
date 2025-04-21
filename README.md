# 🧠 Data Lake Local com Trino, Hive, Delta Lake e Superset

Este projeto é uma demonstração prática de como construir um **Data Lake local** utilizando ferramentas **open source** — tudo rodando na sua máquina, com Docker.

O objetivo é simular um ambiente real de engenharia de dados, onde você pode gravar dados em Delta Lake, catalogar com Hive Metastore, consultar com Trino e visualizar no Superset.

---

## 🔧 Stack Utilizada

- [MinIO](https://min.io/) - Armazenamento S3 local
- [Hive Metastore](https://cwiki.apache.org/confluence/display/Hive/Design) - Catálogo de metadados
- [Trino](https://trino.io/) - Engine de consulta distribuída
- [Superset](https://superset.apache.org/) - Visualização e dashboards
- [PostgreSQL](https://www.postgresql.org/) - Metastore do Hive e backend do Superset
- [PySpark + Delta Lake](https://delta.io/) - Escrita de dados em formato Delta
- [Docker Compose](https://docs.docker.com/compose/) - Orquestração dos containers

---

## 📂 Estrutura do Projeto

```
├── data
│   └── trino
│       └── etc
├── poc
│   ├── executar_trino.sh
│   ├── reinciar_docker.sh
│   ├── trino-cli-400-executable.jar
│   └── trino-hive-postgres-docker-compose.yaml
└── trino
    └── etc
        ├── catalog
        │   ├── delta.properties
        │   └── hive.properties
        ├── config.properties
        ├── jvm.config
        └── node.properties

```

---

## ⚙️ Como Rodar o Projeto

### 1. Clone o repositório
```bash
git clone https://github.com/seuusuario/data-lake-local.git
cd data-lake-local
```

### 2. Suba os serviços com Docker Compose (entre na pasta poc e execute o seguinte comando)
```bash
docker compose -f trino-hive-postgres-docker-compose.yaml up -d
```
Altere os caminhos de dentro do docker compose caso dê erro se necessário

### 3. Verifique os serviços
- Superset: [http://localhost:8088](http://localhost:8088)
- Trino UI: [http://localhost:8080](http://localhost:8080)
- MinIO Console: [http://localhost:9001](http://localhost:9001)
  - Acesso: `admin / admin123`

---
### 4. Crie um bucket e insira um csv de teste dentro do MinIO Console

## 🗂️ Registrando tabelas no Hive via Trino
Acesse o Trino CLI ou Web UI e execute:
```sql
CREATE SCHEMA IF NOT EXISTS hive.test_minio
WITH (
  location = 's3a://bronze/test_minio/'
);

CREATE TABLE IF NOT EXISTS hive.test_minio.vendas (
  data VARCHAR,
  produto VARCHAR,
  categoria VARCHAR,
  preco VARCHAR,
  quantidade VARCHAR,
  total VARCHAR
)
WITH (
  external_location = 's3a://bronze/vendas/',
  format = 'CSV',
  skip_header_line_count = 1
);
```
> Obs: CSV só aceita campos `VARCHAR` no Hive.

---

## 📊 Visualizando dados no Superset
1. Acesse o Superset em `http://localhost:8088`
2. Vá em `Data > Database` e crie uma nova conexão com:
   - Nome: Trino
   - String de conexão:
     ```
     trino://user@trino:8080/hive
     ```
3. Teste a conexão e salve
4. Agora vá em `Data > Dataset` e selecione a tabela `vendas` para começar a criar dashboards 🚀

---

## 🙋‍♂️ Por quê esse projeto?
Esse projeto nasceu da vontade de entender na prática como um ambiente de dados funciona sem depender da nuvem — ideal pra estudar, montar provas de conceito e criar portfólio.
Lembre-se: Esse projeto é feito apenas para estudos, não é um repositório oficial

---

## 📜 Créditos e Referências
- [Artigo do David Zbeda](https://david-dudu-zbeda.medium.com/setting-up-trino-with-hive-to-query-delta-lake-data-on-minio-a-scalable-big-data-solution-a7e2392e04f4)
- [Documentações oficiais do Trino, Hive, Delta e MinIO]

Armazene esse readme pra mim
