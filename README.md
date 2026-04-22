# Análise de Solicitações do NYC 311

Este projeto analisa as solicitações de serviço do NYC 311 referentes ao ano de 2025, com o objetivo de identificar padrões, avaliar a eficiência operacional e gerar insights relevantes.

---

## 📌 Autor

Mayara Reghin

---

## 🚀 Objetivos

- Identificar padrões nas solicitações de serviço  
- Analisar a eficiência operacional do sistema 311  
- Gerar insights para tomada de decisão  

---

## 📎 Fonte dos Dados

NYC Open Data:  
https://data.cityofnewyork.us/

---

## 🛠️ Tecnologias Utilizadas

- Python  
- SQL  
- DuckDB  
- Pandas  
- Seaborn / Matplotlib  
- REST API (NYC Open Data)  

---

## 📊 Estrutura do Projeto

- `scripts/` → Scripts de ingestão de dados e execução do pipeline  
- `sql/` → Queries de limpeza, transformação e análise  
- `graphs/` → Gráficos gerados com Seaborn
- `docs/` → Documento completo com análises e insights  

---

## 🔄 Pipeline de Dados

1. Ingestão de dados via API  
2. Armazenamento em formato Parquet  
3. Limpeza e transformação com SQL  
4. Análise e visualização dos dados  

---
## ▶️ Como rodar o projeto

Siga os passos abaixo para executar o projeto localmente:

### 1. Clonar o repositório

```bash
git clone https://github.com/mayarareghin/nyc-311-sql-analysis.git
cd nyc-311-sql-analysis
```

### 2. Criar e ativar um ambiente virtual

Windows:
```bash
git clone https://github.com/mayarareghin/nyc-311-sql-analysis.git
cd nyc-311-sql-analysis
```

Linux:
```bash
python3 -m venv venv
source venv/bin/activate
```
### 3. Instalar dependências
```bash
pip install -r requirements.txt
```
### 4. Executar a ingestão dos dados
Faz a requisição dos dados à API e salva os dados em formato Parquet na pasta "data/raw/"

```bash
python scripts/ingestion.py
```

### 5. Executar o pipeline de transformação
Cria o banco DuckDB, executa queries de limpeza e transformação e gera tabela final para análise

```bash
python scripts/ingestion.py
```
### Observações

- Os dados não estão versionados no repositório
- A ingestão pode levar alguns minutos devido ao alto volume de dados
  
---

## 📈 Principais Insights

- A maioria das reclamações está relacionada a problemas urbanos recorrentes  
- O departamento de polícia concentra aproximadamente 50% dos chamados  
- O volume de solicitações se mantém estável ao longo do ano  
- A taxa de resolução é de aproximadamente 98%, indicando alta eficiência  
- As reclamações mais frequentes são resolvidas, em média, em menos de 2 dias  

---

