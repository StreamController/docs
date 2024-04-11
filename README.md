# StreamController Docs

## Developer Guide

### Using Make

1. Install mkdocs and dependencies: `make install`
2. Serve files locally `make serve` 
3. Make changes, and preview them on [http://localhost:8000](http://localhost:8000)
4. Once you are happy, commit, push and open pull request

### Manual
1. Create python venv
    ```bash
    python -m venv .venv
    ```
2. Install requirements via pip
    ```bash
    pip install -r requirements.txt
    ```
3. Activate venv
    ```bash
    source .venv/bin/activate
    ```
4. Serve docs locally
    ```bash
    mkdocs serve
    ```
5. Make changes, and preview them on [http://localhost:8000](http://localhost:8000)
6. Once you are happy, commit, push and open pull request
