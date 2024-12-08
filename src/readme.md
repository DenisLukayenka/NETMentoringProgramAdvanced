How to run services via Docker:

1. Install and configure environment
2. Navigate to `src` folder from terminal
3. Run dependencies:
   docker compose -f docker-compose.dependencies.yml up

It will run MS SQL Database, MongoDB, Azure Message Bus Emulator

4. Wait till Azure Message Bus finish
5. Run services:
   docker compose -f docker-compose.services.yml up

Services can be run locally from Visual studio just with docker-compose.dependencies.yml file running.
