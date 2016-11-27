.PHONY: help clean build lint isort test freeze-requirements docker-build docker-run

bin = .env/bin
python = $(bin)/python
pip = $(bin)/pip
tox = $(bin)/tox

help:
	@echo "build - build the distribution wheel"
	@echo "clean - remove build artifacts and python artifacts"
	@echo "test - run tox"

.env:
	virtualenv .env --clear
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

test: .env
	$(tox)
