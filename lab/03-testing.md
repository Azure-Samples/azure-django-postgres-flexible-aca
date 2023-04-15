[01 Getting Started](./README.md) | [02 Examining the Project](./02-examining-project.md) | 03 Testing | [04 Deploying Locally](./04-deploying-locally.md) | [05 Deploying to Azure](./05-deploying-to-azure.md) | [06 Teardown](./06-teardown.md)

# Testing

We need to test that our Django application works as expected. We have provided some tests to ensure that you can visit all of the urls and that the data is being returned as expected.

## Installing the prerequisites

The Dev Container already has the production requirements for the Django app installed,
but it doesn't have the development requirements yet: the linting and testing packages.

Install the development requirements via pip:

> **:computer: Try It!**
>```shell
> python -m pip install -r requirements-dev.txt
> ```

## Testing via Django tests

The first set of tests we'll run are the Django tests. These tests are run inside of the container and are a great way to ensure that your application is working as expected. Django does a fantastic job of setup and teardown of test resources.

Navigate to the `demo-code` folder and run the `test` command:

> **:computer: Try It!**
> ```shell
> cd demo-code
> python manage.py collectstatic
> python manage.py test relecloud.tests
> ```

https://user-images.githubusercontent.com/8632637/229249044-7c8b65d1-3fdc-46a1-9c72-09519452500d.mp4


## Testing the frontend of the application with Playwright

There are some things you can't test without loading the website. For that we'll use [Playwright](https://playwright.dev/), a browser automation library that allows us to run tests against our website. We've included tests that will navigate across multiple pages of the website, similar to how a user would.

First, install Playwright and its dependencies, the headless browser builds. ⚠️ If you're on an M1 Mac, it's not possible to run the browsers from inside the Dev Container. In that case, either use GitHub Codespaces or a local virtual environment.

> **:computer: Try It**
> ```shell
> playwright install --with-deps
> ```

Playwright tests can be written using either the `pytest` framework or the `unittest` framework. The tests we've included use the `unittest` framework by extending Django's `StaticLiveServerTestCase`. 

Navigate to the `demo-code` folder and run the `test` command:

> **:computer: Try It**
> ```shell
> cd demo-code
> python manage.py collectstatic
> python manage.py test relecloud.playwright
> ```

> **📖 Learn More**
> 
> Check out these Playwright resources for more information
>
> - [Playwright](https://playwright.dev/)
> - [Playwright Python](https://playwright.dev/python/docs/intro/)
> - [Pytest Playwright](https://github.com/microsoft/playwright-pytest)


## Testing via GitHub Actions

This is great, however we may forget to run these tests every time we make a change. We can use GitHub Actions to run these tests for us.

We've included a [GitHub Action](../.github/workflows/test.yml) that will run our tests for us inside of a containerized environment.

> **:mag: Explore**
> You can use the GitHub Actions Extension in VS Code (included in your Dev Container) to view the GitHub Action that is running our tests.

![The GitHub Actions Pane in VS Code](../assets/view%20Actions.png)

## Next

Proceed to [04 Deploying Locally](./04-deploying-locally.md)
