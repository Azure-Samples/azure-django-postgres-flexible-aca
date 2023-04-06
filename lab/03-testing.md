# Testing

[01 Getting Started](./README.md) | [02 Examining the Project](./02-examining-project.md) | 03 Testing | [04 Deploying Locally](./04-deploying-locally.md) | [05 Deploying to Azure](./05-deploying-to-azure.md) | [06 Teardown](./06-teardown.md)


We need to test that our django application works as expected. We have provided some tests that ensure that you can visit all of the urls and that the data is being returned as expected.

## Testing via Django Tests
The first set of tests we'll run are the Django tests. These tests are run inside of the container and are a great way to ensure that your application is working as expected. Django does a fantastic job of setup and teardown of test resources 


navigate to the `demo-code` folder and run the following command:

> **:computer: Try It!**
>```shell
> cd demo-code
> python manage.py relecloud.test
> ```

https://user-images.githubusercontent.com/8632637/229249044-7c8b65d1-3fdc-46a1-9c72-09519452500d.mp4


## Testing the frontend of the Application with Playwright

There are somethings you can't test for without loading the website. For that we'll use [Playwright](https://playwright.dev/).

Playwright is a browser automation library that allows us to run tests against our website. We've included tests that will check for specific values are correct and that the websites functions as expected.

We're using pytest with the pytest-playwright extension. To run your playright tests, run pytest.

> **:computer: Try It**
```python
python -m pytest /path/to/pytest/tests
```

> **📖 Learn More**
> 
> Check out these Playwright Resources for More information
>
> - [Playwright](https://playwright.dev/)
> - [Playwright Python](https://playwright.dev/python/docs/intro/)
> - [Pytest Playwright](https://github.com/microsoft/playwright-pytest)




## Testing via GitHub Actions

This is great, however we don't want to need to remember to run these tests every time we make a change. We can use GitHub Actions to run these tests for us.

we've included a [GitHub Action](../.github/workflows/test.yml) that will run our tests for us inside of a containerized environment.

> **:mag: Explore**
> You can use the GitHub Actions Extension in VS Code (Included in your DevContainer) to view the GitHub Action that is running our tests.

![The GitHub Actions Pane in VS Code](../assets/view%20Actions.png)

## Next

Proceed to [04 Deploying Locally](./04-deploying-locally.md)
