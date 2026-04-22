import os
import time
import requests
import pandas as pd
from concurrent.futures import ThreadPoolExecutor, as_completed
import pyarrow

BASE_URL = "https://data.cityofnewyork.us/resource/erm2-nwe9.json"

query = "$where=created_date between '2025-01-01T00:00:00' and '2025-12-31T23:59:59'"
limit = 50000
offset = 0

headers = {
    "X-App-Token": "23ibZDaZufhx7zmXqeGKHwPTt"
}

OUTPUT_DIR = "data-311/year=2025"
MAX_WORKERS = 5
MAX_RETRIES = 5

os.makedirs(OUTPUT_DIR, exist_ok=True)

def fetch_with_retry(offset):
    url = f"{BASE_URL}?{query}&$limit={limit}&$offset={offset}"

    for attempt in range(MAX_RETRIES):
        try:
            print(f"[INFO] Baixando offset {offset} (tentativa {attempt+1})")

            response = requests.get(url, headers=headers, timeout=30)

            if response.status_code == 200:
                data = response.json()
                
                if not data:
                    return None

                df = pd.DataFrame(data)

                # salva incrementalmente
                file_path = os.path.join(OUTPUT_DIR, f"part_{offset}.parquet")
                df.to_parquet(file_path, index=False)


                print(f"[SUCCESS] Offset {offset} salvo")
                return offset

            else:
                print(f"[WARN] Status {response.status_code} | offset {offset}")

        except requests.exceptions.RequestException as e:
            print(f"[ERROR] {e} | offset {offset}")

        # backoff exponencial
        time.sleep(2 ** attempt)

    print(f"[FAIL] Offset {offset} falhou após retries")
    return None



def run_pipeline():
    # total aproximado
    total_rows = 3644006
    offsets = list(range(0, total_rows, limit))

    with ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
        futures = [executor.submit(fetch_with_retry, offset) for offset in offsets]

        for future in as_completed(futures):
            result = future.result()

            if result is not None:
                print(f"[DONE] Offset {result} concluído")

if __name__ == "__main__":
    run_pipeline()


