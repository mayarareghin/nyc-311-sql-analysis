import duckdb
import os

con = duckdb.connect("database/database-311.db")


def split_sql_statements(sql_text):
    statements = []
    current = []

    for line in sql_text.splitlines():
        line = line.strip()

        # ignora comentários
        if not line or line.startswith("--"):
            continue

        current.append(line)

        # fim de statement
        if line.endswith(";"):
            statements.append(" ".join(current))
            current = []

    # pega resto sem ;
    if current:
        statements.append(" ".join(current))

    return statements


def run_sql_file(filepath):
    print(f"\nExecutando: {filepath}")

    try:
        with open(filepath, "r", encoding="utf-8") as f:
            sql_text = f.read()

        statements = split_sql_statements(sql_text)

        for i, stmt in enumerate(statements, start=1):
            try:
                print(f"- Query {i}")
                con.execute(stmt)
            except Exception as e:
                print(f" Erro na query {i}")
                print(f"  {stmt[:120]}")
                print(f"  Erro: {e}")
                raise

    except Exception as e:
        print(f"Erro no arquivo {filepath}: {e}")
        raise


def run_folder(path):
    print(f"\nPasta: {path}")

    files = sorted([f for f in os.listdir(path) if f.endswith(".sql")])

    for file in files:
        run_sql_file(os.path.join(path, file))


# PIPELINE
try:
    print("Iniciando pipeline")

    con.execute("""
        CREATE OR REPLACE TABLE service_request AS
        SELECT * FROM 'data/raw/**/*.parquet'
    """)

    run_folder("sql/01_cleaning")
    run_folder("sql/02_transformations")

    print("\nPipeline finalizado com sucesso")

except Exception as e:
    print("\nPipeline falhou:", e)