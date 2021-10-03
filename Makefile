.PHONY: main
main: swift typescript extension

.PHONY: schema
schema: swift typescript

.PHONY: swift
swift:
	quicktype -o Svadilfari/SharedTypes.swift --mutable-properties --src-lang schema $(shell find Schema -type f)
.PHONY: typescript
typescript:
	quicktype -o Web/packages/core/src/SharedTypes.ts --nice-property-names --src-lang schema $(shell find Schema -type f)

.PHONY: extension
extension:
	cd Web && pnpm build:extension

# Generate toolbar icons
.PHONY: extension-toolbar-icon
extension-toolbar-icon:
	for size in 16 19 32 38; do \
		rsvg-convert -w $$size -h $$size -o SvadilfariExtension/Resources/images/toolbar-icon-$$size.png SvadilfariExtension/Resources/images/toolbar-icon.svg; \
	done
