# Architectural Style Determination

Determine the architectural style of the solution. Provide an explanation for your choice.

Based on the diagram and description, the solution has the following properties:

## High Coupling

Even though the services (Warehouse, BackOffice, and Shop) operate in different domains, they are all connected to the same database. This results in a shared data access layer (DAL), leading to a high degree of coupling between the services and the database. Any changes to the data schema could impact all services.

Additionally, each service depends on the presence of data from another service in the same database:

- "Orders Processing" requires data from "Orders Placement."
- "Storage/Delivery" requires data from "Orders Processing."
- "Couriers Mobile App" requires data from "Storage/Delivery."

As a result, these services cannot be considered independent; they function more as a single unit.

## Scalability Challenges

The entire system relies on the SQL database, making it the main point for scaling. The scalability of the database largely describes the scalability of the overall system.

### Database Scalability Challenges

Here are the problems:

- Vertical scaling is straightforward and safe, but it can become too expensive as the system grows.
- Horizontal scaling presents difficulties:
  - As all services can read and write to the database, we can use only master-master replication, but it is complex to implement and prone to conflicts.
  - Sharding could be a solution, but it would require updating all services, including the third-party reporting tool, which might not be possible.

## Portability Limitations

Since all services are tightly coupled and function as a single unit, it would be difficult to expand the system to new geographical regions. The only viable option would be to replicate the entire set of services for each new region.

## Conclusion

Considering these characteristics, I would classify the architectural style as a **Distributed Monolith**. Despite having separate services, they are highly coupled and function as a single unit. It seems like a monolithic architecture that is being refactored towards a Service-Oriented Architecture (SOA) and is still in progress.
