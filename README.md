# Deploy a Django Application via Azure Container Apps

This project will walkthrough the steps to deploy a Django application to Azure Container Apps. The Django application is a simple web application for a space travel agency. The application is built using the Django web framework and uses a PostgreSQL database. The application can be deployed to Azure using  [Azure Developer CLI](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/overview). With the command `azd up`.

![Visualization of Application](assets/bicep-visualization.png)

## Prerequisites

You'll need a GitHub account. If you don't have a GitHub account, create a [free account](https://github.com/signup)

If you're using VS Code we recommend that you develop in a dev container. This will ensure that you have all the tools you need to build and run the application. You will need docker installed and running. To learn more about dev containers, see [Developing inside a Container](https://code.visualstudio.com/docs/remote/containers).

If you would prefer not to use a local devcontainer, you can also use GitHub Codespaces. You get **60 hours FREE** each month. To learn more, see [GitHub Codespaces](https://github.com/features/codespaces).

You will also need an Azure subscription. If you don't have an Azure subscription, create a [free account](https://aka.ms/azure-pycon2023/) before you begin. # TODO: UPDATE LINK

## Deployment

1. Install your requirements
    `pip install -r demo-code/requirements.txt`
1. Create a database
    `psql -U postgres -c "CREATE DATABASE space_travel_agency"`
1. Migrate the database
    `python manage.py migrate`

### Deploy to Azure

You can deploy a version of this using the Deploy to Azure button below.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)]() # TODO: Add Link

## Resources

Check out the resources to Learn more about:

- [Deploy your First Container App](https://learn.microsoft.com/en-us/azure/container-apps/get-started?tabs=bash)
- [Deploy to Azure Container Apps using Visual Studio Code](https://learn.microsoft.com/en-us/azure/container-apps/deploy-visual-studio-code)
