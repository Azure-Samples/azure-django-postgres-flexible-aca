---
page_type: sample
languages:
- azdeveloper
- python
- bicep
- html
products:
- azure
- azure-container-apps
- azure-database-postgresql
urlFragment: azure-django-postgres-flexible-aca
name: Deploy Django Application with PostgreSQL on Azure Container Apps (Python)
description: This project deploys a web application for a space travel agency using Django with Python, and is set up for easy deployment with the Azure Developer CLI.
---
<!-- YAML front-matter schema: https://review.learn.microsoft.com/en-us/help/contribute/samples/process/onboarding?branch=main#supported-metadata-fields-for-readmemd -->

# Deploy Django Application with PostgreSQL via Azure Container Apps

This project deploys a web application for a space travel agency using Django. The application can be deployed to Azure with Azure Container Apps using the [Azure Developer CLI](https://learn.microsoft.com/azure/developer/azure-developer-cli/overview).

## Opening the project

This project has [Dev Container support](https://code.visualstudio.com/docs/devcontainers/containers), so it will be setup automatically if you open it in Github Codespaces or in local VS Code with the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

If you're *not* using one of those options for opening the project, then you'll need to:

1. Start up a local PostgreSQL server, create a database for the app, and set the following environment variables according to your database configuration.

```shell
export POSTGRES_HOST=localhost
export POSTGRES_PORT=5432
export POSTGRES_DATABASE=<YOUR DATABASE>
export POSTGRES_USERNAME=<YOUR USERNAME>
export POSTGRES_PASSWORD=<YOUR PASSWORD>
```

1. Create a [Python virtual environment](https://docs.python.org/3/tutorial/venv.html#creating-virtual-environments) and activate it.

1. Install production requirements:

    ```sh
    python3 -m pip install -r src/requirements.txt
    ```


1. Apply database migrations and seed initial data:

    ```sh
    python3 src/manage.py migrate
    python3 src/manage.py loaddata src/seed_data.json
    ```

## Running locally

If you're running the app inside VS Code or GitHub Codespaces, you can use the "Run and Debug" button to start the app.

```sh
python3 src/manage.py runserver 8000
```

### Admin

This app comes with the built-in Django admin interface.

1. Create a superuser:

```
python3 src/manage.py createsuperuser
```

2. Restart the server and navigate to "/admin"

3. Login with the superuser credentials.

## Running tests

1. Install the development requirements:

    ```sh
    python3 -m pip install -r requirements-dev.txt
    python3 -m playwright install chromium --with-deps
    ```

2. Run the tests:

    ```sh
    python3 -m pytest
    ```

## Deployment

This repo is set up for deployment on Azure via Azure Container Apps.

Steps for deployment:

1. Sign up for a [free Azure account](https://azure.microsoft.com/free/) and create an Azure Subscription.
2. Install the [Azure Developer CLI](https://learn.microsoft.com/azure/developer/azure-developer-cli/install-azd). (If you open this repository in Codespaces or with the VS Code Dev Containers extension, that part will be done for you.)
3. Login to Azure:

    ```shell
    azd auth login
    ```

4. Provision and deploy all the resources:

    ```shell
    azd up
    ```

    It will prompt you to provide an `azd` environment name (like "myapp"), select a subscription from your Azure account, and select a location (like "eastus"). Then it will provision the resources in your account and deploy the latest code. If you get an error with deployment, changing the location can help, as there may be availability constraints for some of the resources.

5. When `azd` has finished deploying, you'll see an endpoint URI in the command output. Visit that URI, and you should see the front page of the app! 🎉

6. When you've made any changes to the app code, you can just run:

    ```shell
    azd deploy
    ```

### CI/CD pipeline

This project includes a Github workflow for deploying the resources to Azure
on every push to main. That workflow requires several Azure-related authentication secrets
to be stored as Github action secrets. To set that up, run:

```shell
azd pipeline config
```

