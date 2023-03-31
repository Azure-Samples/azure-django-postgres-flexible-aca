# Deploy your project locally

Before we deploy our application to the web, we need to test it. In a production environment, we would want a staging area where we can test our application before deploying it to production. In this lab we are using our devcontainers/codespaces environment for this process. We also have a GitHub Action that will run our tests as well. This is a great way to ensure that our code is working as expected before we deploy it to production.

# Testing our django application

We need to test that our django application works as expected. We have provided some tests that ensure that you can visit all of the urls and that the data is being returned as expected. 

> **:pencil: Try It!**
> Run the following command to run the tests inside of our devcontainer/codespace:

> ```shell
> cd demo-code
> python manage.py test
> ```

../assets/testing%20your%20django%20code.mp4 # Replace in GitHub

## Testing via GitHub Actions

This is great, however we don't want to need to remember to run these tests every time we make a change. We can use GitHub Actions to run these tests for us.

we've included a GitHub Action that will run our tests for us inside of a containerized environment.

> **:mag: Explore**
> You can use the GitHub Actions Extension in VS Code (Included in your DevContainer) to view the GitHub Action that is running our tests.
****