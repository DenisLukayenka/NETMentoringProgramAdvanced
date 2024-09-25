# Architectural Styles

## 1. What are the cons and pros of the Monolith architectural style?

### Cons

- **Tight coupling**  
  As the application grows, the components become too coupled, making it harder to modify or replace individual parts.

- **Scalability**  
  A monolith consists of multiple connected parts. Even if only one part experiences heavy load, the entire application must be scaled, even though other components may not require it.

- **Team Coordination**  
  When multiple teams work on large features within the same codebase, it can result in frequent merge conflicts and longer development cycles.

- **Longer regression testing**  
  Due to the tight coupling, new features can cause unexpected behavior in any part of the application, requiring QA teams to test the whole system to ensure stability.

- **Lack of Flexibility**  
  All teams must use the same technology stack and tools, limiting the ability to experiment with new technologies or frameworks.

- **Onboarding challenges**  
  As the application grows more complex, new developers face a steep learning curve, needing more time to understand the system's logic and architecture.

### Pros

- **Simpler Development**  
  For small to medium-sized projects, monolithic architecture is easier to develop and manage, requiring less setup compared to microservices.

- **Easier Deployment**  
  With a single, unified component, deploying the application is more straightforward, with fewer moving parts to manage.

- **Better Performance**  
  Since there are no calls to external services, the absence of network latency can result in improved overall performance.

## 2. What are the cons and pros of the Microservices architectural style?

### Cons

- **Network latency**  
  Microservices communicate over a network, which can introduce significant latency, especially when services call each other without strict coordination.

- **Data consistency**  
  Since each service may have its own database, maintaining data consistency across services becomes a significant challenge.

- **Single point of failure**  
  In a microservices architecture, certain services (e.g., API Gateway) can become critical points of failure, potentially affecting the entire application.

- **Team Coordination**  
  Managing multiple teams across different services to work together on a single feature can become difficult without proper planning and management.

### Pros

- **Independent Development**  
  Teams can focus on their individual services, each with its own codebase, allowing for parallel development and less cross-team interference.

- **Faster Deployment**  
  Individual services can be deployed independently, making it easier to release updates without impacting the entire system.

- **Flexibility**  
  Each service can use its own technology stack, chosen by the team, enabling innovation and experimentation with new tools or frameworks.

- **Scalability**  
  Services can be scaled independently, allowing for resource optimization by allocating more compute power to the parts of the system that need it.

- **Fault tolerance**  
  Since services are isolated, the failure of one service is less likely to bring down the entire application, improving overall resilience.

## 3. What is the difference between SOA and Microservices?

| Aspect           | SOA                                 | Microservices              |
| ---------------- | ----------------------------------- | -------------------------- |
| Communication    | Through ESB or SOAP                 | Lightweight, e.g. HTTP/RPC |
| Technology stack | Usually the same                    | Any for each service       |
| Coupling         | Tight coupled with ESB              | Loose coupled              |
| Scalability      | Low, services may affect each other | High                       |

## 4. What does hybrid architectural style mean?

A hybrid architectural style refers to combining multiple architectural styles within the same project, such as a core monolithic system with additional microservices, or a mix of SOA and microservices.

This may happen for various reasons, including:

- Legacy project update or refactoring.
- Governance or scalability requirements for a particular part of the application.

### My current project uses the following architectural styles

- **SOA**  
  Initially, the services were designed and built using this style. Services communicated with each other using SOAP protocol and message brokers, like MSMQ and RabbitMQ.

- **Microservices**  
  The Microservices style was chosen for new features and projects. Teams can implement their services without any technology restrictions, using HTTP protocols and moving to AWS.

## 5. Name several examples of distributed architectures. What do ACID and BASE terms mean?

- **Distributed Architectures**:
  - SOA
  - Microservices
  - Serverless
  - Peer-To-Peer
  - Event-driven

### ACID

- **Atomicity**: Guarantee that all operations in a transaction are either fully succeeded or none of them applied. There is no partial state.
- **Consistency**: Guarantee that the database data will be consistent with the scheme.
- **Isolation**: Guarantee that all transactions occur in isolation. One transaction cannot see data from another transaction.
- **Durability**: Guarantee that if a transaction is committed, then it will remain in the system.

### BASE

- **Basically Available**: Guarantee the availability of data, even if the data won't be the most recent.
- **Soft State**: The state of a system can change over time, even in the absence of new input.
- **Eventually Consistent**: The database should eventually converge to a consistent state, even if it takes some time.

## 6. Name several use cases where Serverless architecture would be beneficial

- **Inconsistent traffic**: When the workload of an application is unpredictable and can change unexpectedly.
- **Event-driven applications**: For tasks that need to be executed in response to triggers, such as scheduled events or IoT signals, using Function as a Service (FaaS) is more effective than maintaining a dedicated server.
- **Prototyping**: The low cost of FaaS solutions allows for experimentation with different approaches in a project, making it easier to validate ideas quickly.
