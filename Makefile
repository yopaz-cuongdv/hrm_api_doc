MODULE ?= auth
TSP_FILE := $(MODULE).tsp
OUT_DIR := ./openapi/$(MODULE)
OPENAPI_FILE := $(OUT_DIR)/openapi.(MODULE).yaml

openapi:
	tsp compile ./tsp

#ts_gen:
#	npx openapi-typescript-codegen --input ./tsp-output/schema/openapi.yaml --output ./api-client --client fetch