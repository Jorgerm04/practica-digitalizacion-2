
FROM python:3.12-slim AS base
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .


FROM base AS test
RUN pip install pytest
RUN pytest -v


FROM base AS dev
EXPOSE 5000
CMD ["flask", "--app", "run", "run", "--debug", "--host=0.0.0.0"]

FROM base AS production
RUN pip install gunicorn
EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "run:app"]