.PHONY: all
all: swift typescript

.PHONY: swift
swift:
	quicktype -o Svadilfari/SharedTypes.swift --src-lang schema $(shell find Schema -type f)
.PHONY: typescript
typescript:
	quicktype -o Web/src/SharedTypes.ts --nice-property-names --src-lang schema $(shell find Schema -type f)
