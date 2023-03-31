# Testing

[01 Getting Started](./README.md) | [02 Examining the Project](./02-examining-project.md) | 03 Testing | [04 Deploying Locally](./04-deploying-locally.md) | [05 Deploying to Azure](./05-deploying-to-azure.md)  


We need to test that our django application works as expected. We have provided some tests that ensure that you can visit all of the urls and that the data is being returned as expected.

navigate to the `demo-code` folder and run the following command:

```shell
python manage.py test
```

## Next

## Testing via GitHub Actions

This is great, however we don't want to need to remember to run these tests every time we make a change. We can use GitHub Actions to run these tests for us.

we've included a GitHub Action that will run our tests for us inside of a containerized environment.

> **:mag: Explore**
> You can use the GitHub Actions Extension in VS Code (Included in your DevContainer) to view the GitHub Action that is running our tests.

![The GitHub Actions Pane in VS Code](../assets/view%20Actions.png)

## Next

Proceed to [04 Deploying Lovally](./04-deploying-locally.md)
