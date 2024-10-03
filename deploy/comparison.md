### Source solution

- **Cons**:
  - Accessible in [Task 1](https://github.com/DenisLukayenka/NETMentoringProgramAdvanced/blob/main/docs/Architectural%20Styles%20and%20Patterns/task1.md).
- **Pros**:
  - Faster development time.  
    Overall, the architecture is simple to implement initially. For small or medium-sized projects, it is not overly complex to maintain. However, adding new features could become difficult due to the high coupling between services.

### Proposed solution

- **Cons**:

  - **Development complexity**:  
    The solution requires numerous services, making implementation and establishing efficient communication between them challenging.
  - **Infrastructure overhead**:  
    The large number of components increases system complexity, requiring more effort for monitoring and maintenance.
  - **Distributed tax**:  
    Communication between services introduces network latency, which may increase over time.
  - **Team coordination**:  
    Managing communication between the teams can become more difficult as the system grows.

- **Pros**:
  - **Low coupling**:  
    Services are now independent and focus on specific tasks. Introducing Service Bus further reduces coupling by improving communication between services.
  - **Scalability**:  
    With less dependency on a single database, the system can be scaled more efficiently. Azure Functions make scaling easier and almost limitless. The catalog service has also been updated using the CQRS pattern, optimizing read operations for better scalability.
  - **Portability**:  
    Using CDN for static content, replicated databases for the catalog, and Azure Blob Storage for sharing static content greatly enhances the user experience and improves portability to new regions.
