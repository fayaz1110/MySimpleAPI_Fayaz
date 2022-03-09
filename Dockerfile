#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

#get base image ,full dotnet core sdkk
FROM mcr.microsoft.com/dotnet/sdk:5.0 as build-env
WORKDIR /app

#copy csproj and restore
COPY *.csproj ./
RUN dotnet restore

#copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

#generate runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/out
ENTRYPOINT ["dotnet","MySimpleAPI_Fayaz.dll"]