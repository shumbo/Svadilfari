.PHONY: all
all: swift typescript

.PHONY: swift
swift:
	quicktype -o Svadilfari/SharedTypes.swift --src-lang schema Schema/*.yml
.PHONY: typescript
typescript:
	quicktype -o SharedTypes.ts --nice-property-names --src-lang schema Schema/*.yml
