# Load environment variables
-include .env
export

# Verify required environment variables are set
check-env:
	@echo "Loading environment variables from .env"
	@if [ -z "$$SNOWFLAKE_ACCOUNT" ]; then echo "Error: SNOWFLAKE_ACCOUNT not set"; exit 1; fi
	@if [ -z "$$SNOWFLAKE_USER" ]; then echo "Error: SNOWFLAKE_USER not set"; exit 1; fi
	@if [ -z "$$SNOWFLAKE_PASSWORD" ]; then echo "Error: SNOWFLAKE_PASSWORD not set"; exit 1; fi
	@echo "Environment variables loaded successfully"

# Common dbt commands
run: check-env
	test: check-env
	seed: check-env
	docs: check-env
	debug: check-env
	debug-config: check-env
	debug-connection: check-env
	lint: check-env
	list: check-env
	run-model: check-env
	test-model: check-env
.PHONY: run test seed docs clean

run:
	dbt run

test:
	dbt test

seed:
	dbt seed

docs:
	dbt docs generate

clean:
	dbt clean

fresh: clean run test

# Debug commands
debug-config:
	dbt debug --config

debug-connection:
	dbt debug --connection

# Utility commands
lint:
	dbt run-operation lint_models

list:
	dbt ls

# Run specific model
run-model:
	dbt run --select $(model)

# Run specific test
test-model:
	dbt test --select $(model)