import os

import pytest
from django.core.management import call_command


@pytest.fixture(scope="function")
def django_db_setup(django_db_setup, django_db_blocker):
    """Overrides the default django_db_setup fixture to load the seed data
    https://pytest-django.readthedocs.io/en/latest/database.html#populate-the-test-database-if-you-use-transactional-or-live-server
    """
    with django_db_blocker.unblock():
        call_command("loaddata", "src/seed_data.json")


@pytest.fixture(scope="session", autouse=True)
def mock_functions_env():
    os.environ["DJANGO_ALLOW_ASYNC_UNSAFE"] = "true"


@pytest.fixture(scope="session")
def live_server_url(live_server):
    """Returns the url of the live server"""
    return live_server.url
