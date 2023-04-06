# Tearing Things Down

[01 Getting Started](./README.md) | [02 Examining the Project](./02-examining-project.md) | [03 Testing](./03-testing.md) | [04 Deploying Locally](./04-deploying-locally.md) | [05 Deploying to Azure](./05-deploying-to-azure.md) | 06 Teardown

To tear down the cluster, run the following command:

```bash
azd down --purge
```

This will deprovision (remove) all of the resources that we created in this process (the `--purge` command ensures that the keyvault resources are deleted)