[01 Getting Started](./README.md) | 02 Examining the Project | [03 Testing](./03-testing.md) | [04 Deploying Locally](./04-deploying-locally.md) | [05 Deploying to Azure](./05-deploying-to-azure.md) | [06 Teardown](./06-teardown.md)

# Examining the Project

Before we deploy our application, let's take a look at the project. 

## Project Structure

```shell
.
├── .devcontainer
│  ├── Dockerfile_dev
│  ├── docker-compose_dev.yml
├── demo-code
│  ├── Dockerfile
│  ├── manage.py
│  ├── project
│  ├── relecloud
├── docker-compose.yml
├── infra
```

The code we will deploy exists in the `demo-code` folder. This is a [Django](https://djangoproject.com) project that is the base for a space tourism company called "Relecloud". Users can visit the site to learn about the tours taken around the solar system.

## Creating our Environment using Docker/Docker Compose

You may notice we have 2 Docker Compose files and 2 Dockerfiles. [docker-compose.yml](../docker-compose.yml) serves as the base configuration for all of the development environments. This ensures that your deployment environment is as close to your development environment as possible.

 [.devcontainer/docker-compose_dev.yml](../.devcontainer/docker-compose_dev.yml) and [.devcontainer/Dockerfile_dev](../.devcontainer/Dockerfile_dev) are used to configure the development environment when using [Dev Containers](https://code.visualstudio.com/docs/remote/containers) or [Codespaces](https://codespaces.github.com). `Dockerfile_dev` provides configuration changes specific to local testing to ensure that our testing database is configured correctly, while remaining separate from production.

> **:book: Learn More**
> 
> Learn more about [creating Dev Containers](https://containers.dev)

## Infrastructure as Code and Azure Developer CLI (AZD)

Finally, [demo-code/Dockerfile](../demo-code/Dockerfile) is used to build the image that will be deployed to Azure using the Azure Developer CLI (AZD).  We also have an [infra](../infra/) folder that contains the [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview) templates used to deploy the infrastructure to Azure using the [Azure Developer CLI](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/overview). We'll take a look at these files later in the lab, but this is key to being able to deploy our code rapidly and reliably.

We will talk more about AZD later in the lab.
## Next

Proceed to [03 Testing](./03-testing.md)
