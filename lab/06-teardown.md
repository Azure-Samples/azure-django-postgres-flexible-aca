[01 Getting Started](./README.md) | [02 Examining the Project](./02-examining-project.md) | [03 Testing](./03-testing.md) | [04 Deploying Locally](./04-deploying-locally.md) | [05 Deploying to Azure](./05-deploying-to-azure.md) | 06 Teardown

# Tearing Things Down

Azure Container Apps are billed by usage and ours have been configured to scale all the way down to zero if not in active use.

That said we have created several resources and we should clean them up when we are done to avoid unnecessary charges.

To tear down the project, we can use azd to deprovision, or remove, all of our created resources. We can run `azd down --purge` to shut down and deprovision our resources. We use the purge command to free up the namespaces around our Key Vault resources.

```bash
azd down --purge
```

This will take a little bit of time to complete.

https://user-images.githubusercontent.com/8632637/231804244-f0454d8b-d4c0-4bc5-b26b-5575e94650e7.mp4


**Our resources and the associated resource group have been deleted.**
