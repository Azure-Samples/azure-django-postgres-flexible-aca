# Deploy a Django Application via Azure Container Apps

This project will walkthrough the steps to deploy a Django application to Azure Container Apps. The Django application is a simple web application for a space travel agency. The application is built using the Django web framework and uses a PostgreSQL database. The application can be deployed to Azure using  [Azure Developer CLI](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/overview). With the command `azd up`.

![Visualization of Application](assets/bicep-visualization.png)

## Prerequisites

You'll need a GitHub account. If you don't have a GitHub account, create a [free account](https://github.com/signup)

If you're using VS Code we recommend that you develop in a dev container. This will ensure that you have all the tools you need to build and run the application. You will need docker installed and running. To learn more about dev containers, see [Developing inside a Container](https://code.visualstudio.com/docs/remote/containers).


### Deploy to Azure

You can deploy your application from your cloned repo using Azure Developer CLI.
1. Open a terminal, create a new empty folder, and change into it.
2. Initialize your project using the following command:

`azd init --template azure-django-postgres-aca`

This command will clone the code to your current folder and prompt you for the following information:

- Environment Name: This will be used as a prefix for the resource group that will be created to hold all Azure resources. This name should be unique within your Azure subscription.

3. Provision and deploy your project with the following command
`azd up`

This command will prompt you for the following information:

Azure Location: The Azure location where your resources will be deployed.
Azure Subscription: The Azure Subscription where your resources will be deployed.

## Resources

Check out the resources to Learn more about:

- [Deploy your First Container App](https://learn.microsoft.com/en-us/azure/container-apps/get-started?tabs=bash)
- [Deploy to Azure Container Apps using Visual Studio Code](https://learn.microsoft.com/en-us/azure/container-apps/deploy-visual-studio-code)
