# Оптимізований Dockerfile з ефективним використанням шарів
FROM python:3.11-slim

# Встановлення системних залежностей, які рідко змінюються
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Встановлення робочої директорії
WORKDIR /app

# Копіюємо файли залежностей окремо
COPY requirements/requirements.txt ./requirements/requirements.txt

# Встановлення Python залежностей (рідко змінюються)
RUN pip install --no-cache-dir -r requirements/requirements.txt

# Копіюємо лише необхідні файли проекту
COPY spaceship/ ./spaceship/

# Встановлення решти файлів (які змінюються часто)
COPY build/ ./build/

# Відкриття порту
EXPOSE 8080

# Команда запуску
CMD ["uvicorn", "spaceship.main:app", "--host=0.0.0.0", "--port=8080"]
