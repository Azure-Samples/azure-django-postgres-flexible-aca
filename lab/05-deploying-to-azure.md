[01 Getting Started](./README.md) | [02 Examining the Project](./02-examining-project.md) | [03 Testing](./03-testing.md) | [04 Deploying Locally](./04-deploying-locally.md) | 05 Deploying to Azure | [06 Teardown](./06-teardown.md)

# Deploy your project to Azure

We've tested our project locally and now we are ready to deploy it to Azure.

## Sign up for Azure

If you haven't yet, you will need to create an Azure Account. If you don't have an account already you can sign up using <https://aka.ms/azurefree> to get up to $200 in credits. Also we've configured this application to use the minimal resources.

## The Azure Developer CLI (AZD)

The [Azure Developer CLI](https://aka.ms/azd) is a command line tool that allows us to manage our project in Azure. It uses the [Bicep](https://aka.ms/bicep) configuration language.

We've already installed the Azure Developer CLI in our Dev Container, added some metadata in an `azure.yaml`, and provided our bicep templates in the `infra` folder. We still need to add some information local to our individual deployments. We can run `azd init` to provide this infomation.

> **:book: Learn More**
> 
> To learn more about the Azure Developer CLI including how to install it outside of this project, visit <https://aka.ms/azd>

You will be prompted to login and provide some information about your project. You can also provide a template to pull code from GitHub if necessary. We will be using the code we have already cloned so the template we use will be `Empty`. Still, we'll need to provide our subscription, the region we want to deploy to, and the name of our deployment. These will be different for everyone.

> **Warning**
>
>Your .azure folder will container information about your subscription as well as potentially host keys and should not be added to source control.
> if not already please add `.azure` to your `.gitignore` file.
>
> **:computer: Try It**
> ```shell
> echo .azure >> .gitignore
> ```

## Deploying with AZD

To get our code into Azure Container Apps with AZD, we need to initialize, provision, and deploy our application.

### Initialization (`azd init`)

The initialization step looks for our `azure.yaml` file and creates a `.azure` folder with our deployment name. This folder contains our `.env` that will be used to provision our resources.

Let's create our `.azure` directory using `azd init`

> **:computer: Try It**
>
> ```shell
> azd init
> ```

https://user-images.githubusercontent.com/8632637/230492388-43da7171-f8c7-456e-ba08-ebe3d477d835.mp4

## Provisioning and Deploying (`azd up`)

After we've created our `.azure` folder, we can provision our resources and deploy our application. Before we do, we'll need to add some information to our `.azure/PROJECT_FOLDER/.env` file.

There will be information about your subscription and your deployment already present. **Do NOT remove this data**. Our production `settings.py` file will look for some environment variables. We'll add `POSTGRES_USERNAME` and `POSTGRES_DATABASE_NAME`

> **:computer: Try It**
>
> ```shell
> # add these values to the existing .env file in the azure folder
> 
> POSTGRES_USERNAME=postgres
> POSTGRES_DATABASE_NAME=relecloud
>```
>
> **Warning**
> 
> Do not add your django `secretkey` or `POSTGRES_PASSWORD`. They are generated and stored securely in Azure Key Vault. Your [django settings](../demo-code/project/settings.py) have been modified to pull from your deployed keyvault instance and values will be created on your first deployment.

Let's do that by running `azd up`. This takes a few minutes, as your resources will be created and configured and your

https://user-images.githubusercontent.com/8632637/230491736-739b896e-1965-4707-8146-5a1e480ef344.mp4

Once the deployment is finished Visit your site by clicking the link

https://user-images.githubusercontent.com/8632637/230491846-84d2a979-fc65-4555-a6e8-824f7034c54e.mp4

## Redeploying (`azd deploy`)

You have deployed a Django Application via Azure Container Apps! But what if we need to make changes.

If you are changing the Bicep templates you will need to reprovision (Use `azd up`), but if you are only making changes to your project code, it is significantly faster to redeploy. You can use the command `azd deploy` to skip the provisioning setup and redeploy your application.

> **:computer: Try It**
>
> ```shell
> azd deploy
> ```

https://user-images.githubusercontent.com/8632637/230491934-9e6d7f3a-3953-424b-abf8-4a71c87d5fc6.mp4

---

## Congratulations

Congratulations, you have successfully deployed a Django Application via Azure Container Apps!

You will likely want to tear down your resources to avoid incurring costs. Proceed to [06-Teardown](./06-teardown.md) to tear down your resources.

### Bonus

We've talked a lot about how we brought this project to life and how we can deploy it to Azure. We can simplify this deployment a lot by fully embracing the power of Azure Developer CLI and GitHub Actions.

Check out the bonus section which walks through those steps.
