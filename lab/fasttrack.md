# Deploying the Django application to Azure Container Apps (Fast Track)

> **Warning**
>
> The fast track assumes that you understand all of the Python concepts discussed in the [Lab](lab/README.md). If you are not familiar with the concepts, please complete the lab before attempting the fast track.

This fast track will guide you through the process of deploying this application from scratch.

## Prerequisites

- [Azure Account - Create a Free Account Today](https://aka.ms/azurefree)
- [Azure Developer CLI](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/install-azd)

## Deploying the application

### Create a new folder for your project

Replace `USERNAME` with your GitHub username.

```bash
mkdir USERNAME-django-pg-aca
cd USERNAME-django-pg-aca
```

### Use AZD to load the application code

Use the following command to extract the code into the current folder:

```bash
azd init -t https://github.com/Azure-Samples/azure-django-postgres-aca
```

When prompted, enter a unique environment name. The name will become part of the Azure resource names deployed in the next step.

### Deploy your application

If not logged in already, use this command to login to Azure:

```bash
azd auth login
```

Use the following command to deploy your application:

```bash
azd up
```

When prompted, select an Azure subscription from your account and then select a location for your application. Note that free resources may be restricted in some regions.

Your application will provision and deploy. This will take some time to complete.

<https://user-images.githubusercontent.com/8632637/230491736-739b896e-1965-4707-8146-5a1e480ef344.mp4>

Once the deployment is finished, visit your site by clicking the link.

<https://user-images.githubusercontent.com/8632637/230491846-84d2a979-fc65-4555-a6e8-824f7034c54e.mp4>

## Teardown


> **Warning: **
> 
> **Teardown your project when finished with the lab to avoid recurring charges.**
> Though we've made an effort to utilize the cheapest and whenever possible free resources, leaving these resources running may accrue charges. Please completely de-provision your resources once no longer needed.

You can tear down your application by running the following command:

```bash
azd down --purge
```
