FROM python:3.11-alpine

# Встановлення системних залежностей (Alpine використовує apk замість apt)
RUN apk add --no-cache --virtual .build-deps \
    gcc \
    musl-dev \
    python3-dev \
    && pip install --no-cache-dir --upgrade pip

# Встановлення робочої директорії
WORKDIR /app

# Копіюємо файли залежностей окремо
COPY requirements/requirements.txt ./requirements/requirements.txt

# Встановлення Python залежностей
RUN pip install --no-cache-dir -r requirements/requirements.txt \
    && apk del .build-deps  # Видаляємо тимчасові залежності

# Копіюємо лише необхідні файли проекту
COPY spaceship/ ./spaceship/

# Встановлення решти файлів
COPY build/ ./build/

# Відкриття порту
EXPOSE 8080

# Команда запуску
CMD ["uvicorn", "spaceship.main:app", "--host=0.0.0.0", "--port=8080"]
