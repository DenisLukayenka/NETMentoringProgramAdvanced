# Infrastructure Project

## How to Generate and Apply a New Migration:

1. Open terminal in the solution folder.
2. Generate migration:
    ```bash
    dotnet ef migrations add <MigrationName> --verbose --project Infrastructure --startup-project Catalog.Queries
    ```
3. Apply database changes:
    ```bash
    dotnet ef database update --project Infrastructure --startup-project Catalog.Queries
    ```
