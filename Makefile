.PHONY: help install test lint format ingest assess evaluate demo serve docker-up docker-down clean

help:
	@echo "TerraTriage Makefile"
	@echo "  make install    - install deps"
	@echo "  make test       - run pytest"
	@echo "  make lint       - ruff check"
	@echo "  make format     - ruff format"
	@echo "  make demo       - terratriage assess --demo"
	@echo "  make evaluate   - terratriage evaluate"
	@echo "  make serve      - start API"
	@echo "  make docker-up  - docker compose up"
	@echo "  make docker-down- docker compose down"

install:
	pip install -e ".[dev]"

test:
	pytest -v

lint:
	ruff check terratriage apps tests

format:
	ruff format terratriage apps tests
	ruff check --fix terratriage apps tests

ingest:
	python -m terratriage.cli ingest data/raw

assess:
	python -m terratriage.cli assess --demo

demo: assess

evaluate:
	python -m terratriage.cli evaluate --dataset data/eval/sample

serve:
	python -m terratriage.cli serve

benchmark:
	python -m terratriage.cli benchmark

docker-up:
	docker compose up --build

docker-down:
	docker compose down -v

clean:
	rm -rf artifacts evaluation_results .pytest_cache __pycache__ .ruff_cache
	find . -type d -name "__pycache__" -exec rm -rf {} +
