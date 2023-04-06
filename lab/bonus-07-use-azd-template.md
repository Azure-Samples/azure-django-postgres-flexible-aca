# Bonus: Using AZD + GitHub Actions to Manage your Deployment
If you want to use this as the starting point for your next django project, we have made this an template available directly in the Azure Developer CLI.

## Deploying AZD Via Template

Run the following command in a new folder outside of your existing project.

```
azd init -t https://github.com/Azure-Samples/azure-django-postgres-aca
```

This will:

- clone the repo with the devcontainer information included
- initialize a new resource group and resources for your based on the bicep templates

![azd init -t](video) # TODO Replace

## Using GitHub Actions

You can use GitHub Actions to handle redployments of your system. In order to do this, you will need to pass create secrets for the GitHub repo.

You will need to create the following secrets:
  - AZURE_CLIENT_ID
  - AZURE_TENANT_ID
  - AZURE_SUBSCRIPTION_ID
  - AZURE_CREDENTIALS

The `AZURE_CLIENT_ID` and `AZURE_SUBSCRIPTION_ID` can be be found in the .azure/YOUR_PROJECT/.env file onse you've initialized the application.

The 

![Adding the GitHub Secret](IMAGE) # TODO Replace

Once that is complete you can use the 
