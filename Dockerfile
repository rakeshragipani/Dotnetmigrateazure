# Use the official .NET Core SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

# Set the working directory to /app
WORKDIR /app

# Copy the .csproj and restore any dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the remaining source code
COPY . ./

# Build the application
RUN dotnet publish -c Release -o out

# Use the official ASP.NET Core Runtime image as the base image
FROM mcr.microsoft.com/dotnet/aspnet:6.0

# Set the working directory to /app
WORKDIR /app

# Copy the published output from the build image to this image
COPY --from=build-env /app/out .

# Expose port 80 to the outside world
EXPOSE 80

# Set the entry point for the container to be the published .NET application
ENTRYPOINT ["dotnet", "Helloworld.dll"]
