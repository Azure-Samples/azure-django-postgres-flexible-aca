# Deploying the Django Application to Azure Container Apps (Fast Track)

> **Warning**
>
> The fast track assumes that you understand all of the concepts discussed in the [Lab](lab/README.md). If you are not familiar with the concepts, please complete the lab before attempting the fast track.

This fasttrack will guide you through the process of deploying this application from zero.

## Prerequisites

- [Azure Developer CLI](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/install-azd)

## Deploying the Application

### Create a New Folder for your project

Replace `USERNAME` with your GitHub username.

```bash
mkdir USERNAME-django-pg-aca
cd USERNAME-django-pg-aca
```

### Use AZD to load the application as a template

```bash
azd init -t https://github.com/Azure-Samples/azure-django-postgres-aca
```

Give your project a unique name. Select location for your application. Note free resources may be restricted in some regions.

### Add POSTGRES ENVIRONMENT variables to the env

Add your `POSTGRES_DATABASE_NAME` and `POSTGREST_USER` in the file located in your `.azure/YOUR_PROJECT_NAME`.

For this demo your `POSTGRES_DATABASE_NAME` will be `relecloud` and your `POSTGREST_USER` will be `postgres`.

```bash
.azure
├── config.json
└── jm-django-pg-aca # Your Project Folder
   ├── .env # <-- Add your POSTGRES_DATABASE_NAME and POSTGREST_USER here
   └── config.json
```

Your env file should look similar to this.

```shell
AZURE_ENV_NAME="jm-django-pg-aca" # Provided by AZD init
AZURE_LOCATION="eastus" # Provided by AZD init
AZURE_PRINCIPAL_ID="YOUR-PRINCIPLE-ID" # Provided by AZD init
AZURE_SUBSCRIPTION_ID="YOUR-SUBSCRIPTION-ID" # Provided by AZD init
POSTGRES_DATABASE_NAME="relecloud"
POSTGRES_USER="postgres"
```

### Deploy your Application