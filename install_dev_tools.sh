#!/usr/bin/env bash
set -e

# Перевіряємо, чи встановлено Docker.
if command -v docker >/dev/null 2>&1; then
  # Якщо встановлено — показуємо його версію.
  echo "Docker уже встановлено: $(docker --version)"
else
  # Якщо Docker відсутній — оновлюємо список пакетів і встановлюємо його.
  sudo apt-get update
  sudo apt-get install -y docker.io
fi

# Перевіряємо, чи встановлено Docker Compose.
if docker compose version >/dev/null 2>&1; then
  # Якщо встановлено — показуємо його версію.
  echo "Docker Compose уже встановлено: $(docker compose version)"
else
  # Якщо Docker Compose відсутній — встановлюємо його.
  sudo apt-get update
  sudo apt-get install -y docker-compose-v2
fi

# Перевіряємо, чи встановлено Python версії 3.9 або новішої.
if command -v python3 >/dev/null 2>&1 && python3 -c 'import sys; sys.exit(0 if sys.version_info >= (3, 9) else 1)'; then
  # Якщо встановлено — показуємо його версію.
  echo "Python уже встановлено: $(python3 --version)"
else
  # Якщо Python відсутній або версія старіша за 3.9 — встановлюємо його.
  sudo apt-get update
  sudo apt-get install -y python3
fi

# Встановлюємо підтримку віртуальних середовищ Python.
sudo apt-get install -y python3-venv

VENV_DIR="${HOME}/.venvs/dev-tools"

# Створюємо віртуальне середовище, якщо його ще немає.
if [[ ! -x "${VENV_DIR}/bin/python" ]]; then
  mkdir -p "${HOME}/.venvs"
  python3 -m venv "${VENV_DIR}"
fi

# Перевіряємо, чи Django вже встановлено.
if "${VENV_DIR}/bin/python" -m django --version >/dev/null 2>&1; then
  echo "Django уже встановлено: $("${VENV_DIR}/bin/python" -m django --version)"
else
  # Якщо Django відсутній — встановлюємо його через pip.
  "${VENV_DIR}/bin/python" -m pip install Django
fi

