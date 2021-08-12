.PHONY: all
all: swift typescript

.PHONY: swift
swift:
	quicktype -o Svadilfari/SharedTypes.swift --mutable-properties --src-lang schema $(shell find Schema -type f)
.PHONY: typescript
typescript:
	quicktype -o Web/src/SharedTypes.ts --nice-property-names --src-lang schema $(shell find Schema -type f)
.PHONY: extension
extension:
	cd Web && yarn build
