# Tearing Things Down

To tear down the cluster, run the following command:

```bash
azd down --purge
```

This will deprovision (remove) all of the resources that we created in this process (the `--purge` command ensures that the keyvault resources are deleted)