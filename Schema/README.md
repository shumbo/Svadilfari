# Schema

This directory contains schemas for communication between the Swift part and the JavaScript part of the extension.

## Prerequisite

We use [QuickType](https://quicktype.io/) to convert JSON Schemas to generate type definitions and serializers/deserializers.

## Build

From the root directory, run `make schema` to generate files from the latest schema.

It will update `Svadilfari/SharedTypes.swift` and `Web/packages/core/src/SharedTypes.ts`.
