# Вихідний образ
FROM python:3.11-slim

# Встановлення робочої директорії
WORKDIR /app

# Копіюємо pinned-залежності
COPY requirements/requirements.txt ./requirements/requirements.txt

# Встановлення залежностей
RUN pip install --no-cache-dir -r requirements/requirements.txt

# Копіюємо весь проєкт
COPY . .

# Відкриття порту
EXPOSE 8080

# Команда запуску
CMD ["uvicorn", "spaceship.main:app", "--host=0.0.0.0", "--port=8080"]
