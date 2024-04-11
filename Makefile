install:
	python -m venv .venv
	. ./.venv/bin/activate 
	pip install -r requirements.txt

serve: 
	mkdocs serve
