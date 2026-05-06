# GraphQL Link Analysis Skill

## Purpose

Treat GraphQL links, docs, screenshots, schema snippets, and playground examples as source documents.

## Procedure

1. Capture operation type, operation name, arguments, variables, selected fields, response wrapper, and nullable fields.
2. Identify existing GraphQL client, document location, model pattern, parser, error handling, and repository boundary.
3. Preserve old operations unless the task explicitly replaces them.
4. Map response fields to entity/model names using project conventions.
5. Record contract gaps such as missing nullability, enum values, pagination, authorization, or error codes.

## Output

- GraphQL source summary
- Operation contract
- Model/entity impact
- Repository/datasource impact
- Verification path
