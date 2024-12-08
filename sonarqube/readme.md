Run SonarQube:

1. Open folder sonarqube
2. Run sudo sysctl -w vm.max_map_count=262144
3. Run docker-compose up
4. Open http://localhost:9001/

Cart.Service:

1. Open WSL
2. Navigate into Cart.Service folder
3. Run
   dotnet sonarscanner begin /k:"Cart.Service" /d:sonar.host.url="http://localhost:9001" /d:sonar.login="<your_login>"

   dotnet build Cart.Service.sln

   dotnet sonarscanner end /d:sonar.login="<your_login>"

Catalog.Service:

1. Open WSL
2. Navigate into Catalog.Service folder
3. Run
   dotnet sonarscanner begin /k:"Catalog.Service" /d:sonar.host.url="http://localhost:9001" /d:sonar.login="<your_login>"

   dotnet build Catalog.Service.sln

   dotnet sonarscanner end /d:sonar.login="<your_login>"
