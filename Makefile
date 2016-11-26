.PHONY: help clean build lint isort test freeze-requirements docker-build docker-run

bin = .env/bin
python = $(bin)/python
pip = $(bin)/pip
tox = $(bin)/tox

help:
	@echo "clean - remove build artifacts and python artifacts"
	@echo ".env - make a virtual environment"
	@echo "lint - check style with flake8"
	@echo "isort - check import order with isort"
	@echo "test - run tox"

.env:
ifeq ($(CI),TRUE)
		virtualenv -p /home/runner/.pyenv/3.5/bin/python .env --clear
else
		python3 -m venv .env --clear
endif
	$(pip) install --upgrade pip
	$(pip) install --upgrade wheel setuptools tox

clean:
	rm -rf .env/
	rm -rf .tox/
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info
	find . -name '__pycache__' -type d -exec rm -rf {} +
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +

build: clean .env
	$(python) setup.py bdist_wheel

lint: .env
	$(tox) -e lint

isort: .env
	$(tox) -e isort

test: .env
	$(tox)
