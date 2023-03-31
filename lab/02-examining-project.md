# Examing the Project

Before we deploy our application, let's take a look at the project. 

## Project Structure

```shell
.
├── demo-code
│  ├── Dockerfile
│  ├── entrypoint.sh
│  ├── manage.py
│  ├── project
│  │  ├── __init__.py
│  │  ├── settings.py
│  │  ├── settings_local.py
│  │  ├── urls.py
│  │  └── wsgi.py
│  ├── pytest.ini
│  ├── relecloud
│  │  ├── __init__.py
│  │  ├── admin.py
│  │  ├── apps.py
│  │  ├── migrations
│  │  │  ├── ...
│  │  ├── models.py
│  │  ├── static
│  │  │  ├── css
│  │  │  │  ├── ...
│  │  ├── templates
│  │  │  ├── ...
│  │  ├── tests.py
│  │  ├── urls.py
│  │  └── views.py
│  ├── requirements.txt
│  ├── requirements_test.txt
│  └── seed_data.json
├── docker-compose.yml
├── infra
│  ├── core
│  │  ├── ...
│  ├── main.bicep
│  ├── main.parameters.json
│  ├── web.bicep
│  └── web.parameters.json
├── LICENSE.md
├── README.md
└── SECURITY.md

```

The code we will deploy exists in the `demo-code` folder. This is a [Django](https://djangoproject.com) project that is the base for a space tourism company called "Relecloud". 

