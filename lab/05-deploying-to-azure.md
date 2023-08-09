[01 Getting Started](./README.md) | [02 Examining the Project](./02-examining-project.md) | [03 Testing](./03-testing.md) | [04 Deploying Locally](./04-deploying-locally.md) | 05 Deploying to Azure | [06 Teardown](./06-teardown.md)

# Deploy your project to Azure

We've tested our project locally and now we are ready to deploy it to Azure.

## Sign up for Azure

If you haven't yet, you will need to create an Azure Account. If you don't have an account already you can sign up using <https://aka.ms/azurefree> to get up to $200 in credits. We've configured this application to use the minimal resources, but not all the resources used have a free tier. You can use the credits to pay for the resources used in this lab. 

## The Azure Developer CLI (AZD)

The [Azure Developer CLI](https://aka.ms/azd) is a command line tool that allows us to manage our project in Azure. It uses the [Bicep](https://aka.ms/bicep) configuration language.

We've already installed the Azure Developer CLI in our Dev Container, added some metadata in an `azure.yaml`, and provided our Bicep templates in the `infra` folder. We still need to add some information local to our individual deployments.

> **:book: Learn More**
> 
> To learn more about the Azure Developer CLI including how to install it outside of this project, visit <https://aka.ms/azd>

Run the following command to login to Azure:

> **:computer: Try It**
> ```shell
> azd auth login
> ```

> **Warning**
>
> Your `.azure` folder will contain information about your subscription as well as potentially host keys and should not be added to source control. We've already added `.azure` to the `.gitignore` file for this repo. 

## Deploying with AZD

To get our code into Azure Container Apps with AZD, we need to provision and deploy our application.

## Provisioning and Deploying (`azd up`)

For this first deploy, we need to first provision (create) all the necessary Azure resources, and only once those are created, we can deploy the containerized app code.

Use the `azd up` command to both provision and deploy:

> **:computer: Try It**
>
> ```shell
> azd up
> ```

When prompted, provide a unique environment name, select a subscription in your account (you may only have one, if you're new to Azure), and select a location for the resources.

https://user-images.githubusercontent.com/8632637/230491736-739b896e-1965-4707-8146-5a1e480ef344.mp4

Once the deployment is finished, visit your site by clicking the link in the output.

https://user-images.githubusercontent.com/8632637/230491846-84d2a979-fc65-4555-a6e8-824f7034c54e.mp4

## Redeploying (`azd deploy`)

You have deployed a Django application via Azure Container Apps! But what if we need to make changes?

If you are changing the Bicep templates you will need to reprovision (using `azd up` or `azd provision`), but if you are only making changes to your project code, it is significantly faster to redeploy. You can use the command `azd deploy` to skip the provisioning setup and redeploy your application.

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

Check out the [bonus section](./bonus-07-use-azd-template.md) which walks through those steps.
