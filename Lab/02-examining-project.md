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
│  │  ├── asgi.py
│  │  ├── settings.py
│  │  ├── settings_local.py
│  │  ├── urls.py
│  │  └── wsgi.py
│  ├── pytest.ini
│  ├── relecloud
│  │  ├── __init__.py
│  │  ├── __pycache__
│  │  │  ├── __init__.cpython-311.pyc
│  │  │  ├── admin.cpython-311.pyc
│  │  │  ├── apps.cpython-311.pyc
│  │  │  ├── models.cpython-311.pyc
│  │  │  ├── urls.cpython-311.pyc
│  │  │  └── views.cpython-311.pyc
│  │  ├── admin.py
│  │  ├── apps.py
│  │  ├── migrations
│  │  │  ├── 0001_initial.py
│  │  │  ├── 0002_auto_20210330_2200.py
│  │  │  ├── 0003_auto_20210331_1932.py
│  │  │  ├── 0004_auto_20210331_2016.py
│  │  │  ├── __init__.py
│  │  │  └── __pycache__
│  │  │     ├── 0001_initial.cpython-311.pyc
│  │  │     ├── 0002_auto_20210330_2200.cpython-311.pyc
│  │  │     ├── 0003_auto_20210331_1932.cpython-311.pyc
│  │  │     ├── 0004_auto_20210331_2016.cpython-311.pyc
│  │  │     └── __init__.cpython-311.pyc
│  │  ├── models.py
│  │  ├── static
│  │  │  ├── res
│  │  │  │  ├── css
│  │  │  │  │  ├── theme.css
│  │  │  │  │  └── theme.css.map
│  │  │  │  └── img
│  │  │  │     ├── astronaut.jpeg
│  │  │  │     ├── bit_cosmos.png
│  │  │  │     ├── cosmos-db.jpeg
│  │  │  │     └── small-logo.png
│  │  │  └── scss
│  │  │     └── custom.scss
│  │  ├── templates
│  │  │  ├── about.html
│  │  │  ├── base.html
│  │  │  ├── cruise_detail.html
│  │  │  ├── destination_detail.html
│  │  │  ├── destinations.html
│  │  │  ├── index.html
│  │  │  └── info_request_create.html
│  │  ├── tests.py
│  │  ├── urls.py
│  │  └── views.py
│  ├── requirements.txt
│  ├── requirements_test.txt
│  └── seed_data.json
├── deployment-guide.md
├── docker-compose.yml
├── infra
│  ├── core
│  │  ├── database
│  │  │  ├── cosmos
│  │  │  │  ├── cosmos-account.bicep
│  │  │  │  ├── mongo
│  │  │  │  │  ├── cosmos-mongo-account.bicep
│  │  │  │  │  └── cosmos-mongo-db.bicep
│  │  │  │  └── sql
│  │  │  │     ├── cosmos-sql-account.bicep
│  │  │  │     ├── cosmos-sql-db.bicep
│  │  │  │     ├── cosmos-sql-role-assign.bicep
│  │  │  │     └── cosmos-sql-role-def.bicep
│  │  │  ├── postgresql
│  │  │  │  └── flexibleserver.bicep
│  │  │  └── sqlserver
│  │  │     └── sqlserver.bicep
│  │  ├── gateway
│  │  │  ├── apim-api-policy.xml
│  │  │  └── apim.bicep
│  │  ├── host
│  │  │  ├── appservice.bicep
│  │  │  ├── appserviceplan.bicep
│  │  │  ├── container-app.bicep
│  │  │  ├── container-apps-environment.bicep
│  │  │  ├── container-apps.bicep
│  │  │  ├── container-registry.bicep
│  │  │  ├── functions.bicep
│  │  │  └── staticwebapp.bicep
│  │  ├── monitor
│  │  │  ├── applicationinsights-dashboard.bicep
│  │  │  ├── applicationinsights.bicep
│  │  │  ├── loganalytics.bicep
│  │  │  └── monitoring.bicep
│  │  ├── security
│  │  │  ├── keyvault-access.bicep
│  │  │  ├── keyvault-secret.bicep
│  │  │  └── keyvault.bicep
│  │  └── storage
│  │     └── storage-account.bicep
│  ├── main.bicep
│  ├── main.parameters.json
│  ├── web.bicep
│  └── web.parameters.json
├── Lab
│  ├── 01-getting-started.md
│  ├── 02-examining-project.md
│  └── 03-deploying-locally.md
├── LICENSE.md
├── locust
│  └── locustfile.py
├── README.md
└── SECURITY.md

```