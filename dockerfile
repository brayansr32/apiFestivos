FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Configurar el puerto en el que ASP.NET Core escuchará
ENV ASPNETCORE_URLS=http://+:5289

# Exponer el puerto que usará la aplicación
EXPOSE 5289

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=build /app .

ENTRYPOINT ["dotnet", "apiFestivos.Presentacion.dll"]