# Deploy your project to Azure

[01 Getting Started](./README.md) | [02 Examining the Project](./02-examining-project.md) | [03 Testing](./03-testing.md) | [04 Deploying Locally](./04-deploying-locally.md) | 05 Deploying to Azure | [06 Teardown](./06-teardown.md)

...



## Steps to deploy with AZD

We need to initialize, provision, and deploy


### Initialization (`azd init`)
Creates the `azure.yaml` and a `.azure` folder

Update our azure.yaml

!()[assets/azure.yaml.png] # TODO CHANGE

Update our .azure/DEPLOYMENT_NAME/.env

add our POSTGRES_USER and POSTGRES_DATABASE_NAME

> **Warning**
> Do not add your secretkey or POSTGRES_PASSWORD. They are generated and stored securely in Azure Key Vault. You [django settings](../demo-code/project/settings.py) have been modified to pull from your keyvault instance.


## Provisioning and Deploying (`azd up`)
Run the command to begin the provisioning process. This takes a few minutes.

![VIDEO of provisioning](VIDEO) # TODO REPLACE

Visit your site by clicking the link

![image of successful deployment](image) # TODO REPLACE

## Redeploying (`azd deploy`)

Congratulations, you have successfully deployed a Django Application via Azure Container Apps! But what if we need to make changes.

If you are changing the Bicep templates you will need to reprovision (Use `azd up`), but if you are only making changes to your project code, it is significantly faster to redploy.

Use this command to trigger a redeployment.

```
azd deploy
```


## Congratulations

Congratulations, you have successfully deployed a Django Application via Azure Container Apps!
