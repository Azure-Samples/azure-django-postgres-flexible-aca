# Examing the Project

Before we deploy our application, let's take a look at the project. 

## Project Structure

```shell
.
├── demo-code
│  ├── Dockerfile
│  ├── entrypoint.sh
│  ├── manage.py
│  ├── project
│  │  ├── __init__.py
│  │  ├── settings.py
│  │  ├── settings_local.py
│  │  ├── urls.py
│  │  └── wsgi.py
│  ├── pytest.ini
│  ├── relecloud
│  │  ├── __init__.py
│  │  ├── admin.py
│  │  ├── apps.py
│  │  ├── migrations
│  │  │  ├── ...
│  │  ├── models.py
│  │  ├── static
│  │  │  ├── css
│  │  │  │  ├── ...
│  │  ├── templates
│  │  │  ├── ...
│  │  ├── tests.py
│  │  ├── urls.py
│  │  └── views.py
│  ├── requirements.txt
│  ├── requirements_test.txt
│  └── seed_data.json
├── docker-compose.yml
├── infra
│  ├── core
│  │  ├── ...
│  ├── main.bicep
│  ├── main.parameters.json
│  ├── web.bicep
│  └── web.parameters.json
├── LICENSE.md
├── README.md
└── SECURITY.md

```

The code we will deploy exists in the `demo-code` folder. This is a [Django](https://djangoproject.com) project that is the base for a space tourism company called "Relecloud". Users can visit the site to learn about the tours taken around the solar system.

We also have 2 docker-compose files and 2 dockerfiles. `docker-compose.yml` serves as the base configuration for all of the development environments. `.devcontainer/docker-compose.yml` and `devcontainer/Dockerfile_dev` are used to configure the development environment when using [Dev Containers](https://code.visualstudio.com/docs/remote/containers) or [Codespaces](https://codespaces.github.com). Finally, the `demo-code/Dockerfile` is used to build the image that will be deployed to Azure.

Lastly, there is an `infra` folder that contains the Bicep templates used to deploy the infrastructure to Azure using the [_Azure Developer CLI_](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/overview). We'll take a look at these files later in the lab.

>**Note**
> There is no completion step. Please proceed to [03-Deploying Locally](03-deploying-locally.md)