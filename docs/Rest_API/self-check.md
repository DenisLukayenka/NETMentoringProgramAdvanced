# REST and RESTful

1. **Explain the difference between terms: REST and RESTful. What are the six constraints?**

REST is an architectural style for building scalable and maintainable services. It is based on six principles:

- Uniform Interface
- Client-Server
- Stateless
- Cacheable
- Layered architecture
- Code on Demand

"RESTful" refers to a service that closely follows these REST principles.

---

2. **HTTP Request Methods (the difference) and HTTP Response codes. What is idempotency? Is HTTP the only protocol supported by the REST?**

**Request Methods:**

- GET - Retrieve a resource
- POST - Perform an action on a resource
- PUT - Replace a resource
- PATCH - Update part of a resource
- HEAD - Retrieve metadata of a resource
- OPTIONS - Request available communication options
- DELETE - Remove a resource

**Idempotency of HTTP methods** means that a method can be called multiple times with the same result. The idempotent methods are: GET, PUT, PATCH, HEAD, OPTIONS, and DELETE.

REST does not define a specific protocol, so using HTTP is not mandatory.

---

3. **What are the advantages of statelessness in RESTful services?**

Statelessness enhances the following characteristics:

- Scalability
- Reliability
- Testability, debugging, and development
- Interoperability

---

4. **How can caching be organized in RESTful services?**

**HTTP headers for caching:**

- Cache-Control
- Expires
- ETag
- Last-Modified

**In-memory cache:**

- On the client side
- On the server side
- In-memory database (e.g., Redis)

---

5. **How can versioning be organized in RESTful services?**

Versioning can be specified in:

- **URL path**:
  `/api/v1.0/carts...`

- **URL query**:
  `/api/carts?version=1.0`

- **HTTP Headers**

---

6. **What are the best practices of resource naming?**

- Use plural nouns:
  `/carts`, `/catalogs`

- Use resource hierarchy when possible:
  `/catalog/{catalog}/products/{productId}`

- Avoid file extensions

- Use query parameters for specifying resources (e.g., filtering, sorting, pagination):
  `/products?sort=rating&order=desc`

---

7. **What are OpenAPI and Swagger? What implementations/libraries for .NET exist? When would you prefer to generate API docs automatically and when manually?**

The OpenAPI Specification (OAS) defines a standard, language-agnostic interface for HTTP APIs, enabling both humans and machines to discover and understand the service's capabilities without needing access to the source code, documentation, or inspecting network traffic.

Swagger refers to a set of tools in the OAS ecosystem, such as Swagger UI, Swagger Editor, and others.

**Implementation libraries include:**

- NSwag
- Swashbuckle

_.NET has deprecated Swashbuckle and introduced built-in OpenAPI middleware._

We may consider generating API documentation manually when:

- There are unique use cases that cannot be automatically generated.
- A public API document is required.

In other cases, automatic API documentation can be used.

---

8. **What is OData? When will you choose to follow it and when not?**

Another bicycle from Microsoft that will be deprecated in a few years.

---

9. **What is Richardson Maturity Model? Is it always a good idea to reach the 3rd level of maturity?**

RMM is a method for evaluating the maturity level of an API service. The third level of maturity introduces significant complexity. Public consumers of the API might not use HATEOAS, and it may be unnecessary for internal communication between services.

However, it could be a good option for public-facing BFF (Backend for Frontend) applications.

---

10. **What does pros and cons REST have in comparison with other web API types?**

**REST**

_Pros:_

- Statelessness
- Simplicity
- Discoverability
- Already a standard in web

_Cons:_

- **Fetching problems:** Can be difficult to load exactly what you need and usually causes over/under-fetching of data. May spawn multiple endpoints for almost identical data.
- **Non-Strict:** Different services may develop RESTful services in different ways, making integration more complex.
- **Versioning challenges**

---

**SOAP**

_Pros:_

- Reliability
- Strict

_Cons:_

- Complex
- Less flexible

---

**GraphQL**

_Pros:_

- Flexible Data Queries

_Cons:_

- Complex
- Caching

---

**gRPC**

_Pros:_

- High Performance
- Bidirectional Streaming for real-time
- Strongly Typed

_Cons:_

- Non Human-Readable
- Not for public API
