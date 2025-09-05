# Projeto Completo — SQL (DTSA 5734)

Projeto prático alinhado ao curso *The Structured Query Language (SQL)* (CU Boulder/Coursera). Cobre **SELECT**, **agregações**, **subqueries**, **JOINs**, **DDL/constraints**, **índices** e **performance**.

## Estrutura
```
dtsa5734_sql_project/
├─ README.md
├─ schema.sql
├─ seed.sql
├─ tasks.md
├─ solutions.sql
├─ rubric.md
├─ COURSE_ALIGNMENT.md
├─ CITATIONS.md
├─ docker/
│  ├─ init/01_schema.sql
│  └─ init/02_seed.sql
├─ extras/
│  ├─ schema_postgres.sql
│  ├─ schema_mysql.sql
│  └─ schema_sqlite.sql
├─ notebooks/queries_template.ipynb
├─ er.mmd
├─ tests.sql
├─ Makefile
├─ .github/workflows/ci.yml
├─ .sqlfluff
├─ LICENSE
├─ CONTRIBUTING.md
├─ CODE_OF_CONDUCT.md
├─ GITHUB_DESCRIPTION_350.txt
└─ LINKEDIN_COMPETENCIAS.txt
```

## Como usar
1. `make db-up` (ou rode `docker compose up -d`).
2. Testes: `make test`.
3. Lint: `sqlfluff lint .`.
4. Resolva `tasks.md` e compare com `solutions.sql`.
