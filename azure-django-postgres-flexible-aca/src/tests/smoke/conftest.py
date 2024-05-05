import pytest


def pytest_addoption(parser):
    parser.addoption(
        "--live-server-url",
        action="store",
        default="http://localhost:8000",
        help="URL for the live server to test against",
    )


@pytest.fixture(scope="function")
def live_server_url(request):
    return request.config.getoption("--live-server-url")
