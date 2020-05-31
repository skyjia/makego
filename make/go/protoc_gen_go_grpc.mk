# Managed by makego. DO NOT EDIT.

# Must be set
$(call _assert_var,MAKEGO)
$(call _conditional_include,$(MAKEGO)/base.mk)
$(call _conditional_include,$(MAKEGO)/dep_protoc.mk)
$(call _conditional_include,$(MAKEGO)/dep_protoc_gen_go_grpc.mk)
# Must be set
$(call _assert_var,PROTO_PATH)
# Must be set
$(call _assert_var,PROTOC_GEN_GO_GRPC_OUT)
$(call _assert_var,CACHE_INCLUDE)
$(call _assert_var,PROTOC)
$(call _assert_var,PROTOC_GEN_GO_GRPC)

# Settable
PROTOC_GEN_GO_GRPC_OPT ?=

EXTRA_MAKEGO_FILES := $(EXTRA_MAKEGO_FILES) scripts/protoc_gen_plugin.bash

.PHONY: protocgengogrpc
protocgengogrpc: protocpre protocgengoclean $(PROTOC) $(PROTOC_GEN_GO_GRPC)
	bash $(MAKEGO)/scripts/protoc_gen_plugin.bash \
		"--proto_path=$(PROTO_PATH)" \
		"--proto_include_path=$(CACHE_INCLUDE)" \
		$(patsubst %,--proto_include_path=%,$(PROTO_INCLUDE_PATHS)) \
		"--plugin_name=go-grpc" \
		"--plugin_out=$(PROTOC_GEN_GO_GRPC_OUT)" \
		"--plugin_opt=$(PROTOC_GEN_GO_GRPC_OPT)"

pregenerate:: protocgengogrpc
