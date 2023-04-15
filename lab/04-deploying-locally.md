# Deploy Your Project Locally
[01 Getting Started](./README.md) | [02 Examining the Project](./02-examining-project.md) | [03 Testing](./03-testing.md) | 04 Deploying Locally | [05 Deploying to Azure](./05-deploying-to-azure.md) | [06 Teardown](./06-teardown.md)

While running the tests checks for certain values, fields, and functionality, it is still wise to get a visual confirmation that you know and like what you're deploying.

We can give our Django application a test run using the `runserver` command. Since we're in a containerized environment, we will not use the default `127.0.0.1:8000` but instead `0.0.0.0:8000`.

> **💻 Try It**
> ```python
> cd demo-code
> python manage.py runserver 0.0.0.0:8000
> ```

https://user-images.githubusercontent.com/8632637/230239735-d702313b-58f4-4c54-bcb2-68ddd9440b17.mp4

This ensures that our application is connected to our database as expected and things are looking great.

Since we're using the DB build from our docker compose, we've pre-seeded the database with some data for you.

Our Dev Container has the ports forwarded so that even in a Codespace, you will be able to view your running project.

https://user-images.githubusercontent.com/8632637/230453383-fe762b5c-255b-4bfe-a690-128ba683ea70.mp4

---

## Next

Proceed to [05 Deploying to Azure](./05-deploying-to-azure.md)
