FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

COPY *.sln .
COPY Cart.Service/*.csproj ./Cart.Service/
COPY "NuGet.config" "NuGet.config"
COPY ".npmrc" ".npmrc"

RUN dotnet restore Cart.Service.sln

COPY . .
WORKDIR /Cart.Service
RUN dotnet publish --no-restore -c Release -o /app /p:RuntimeIdentifier=linux-x64 /p:SelfContained=true

FROM mcr.microsoft.com/dotnet/runtime-deps:8.0 AS runtime
WORKDIR /app
EXPOSE 8080
COPY --from=build /app .

ENTRYPOINT ["./Cart.Service"]