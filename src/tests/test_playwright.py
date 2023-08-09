import re

import pytest
from playwright.sync_api import Page, expect


def test_home(mock_functions_env, page: Page, live_server_url: str):
    """Test that the home page loads"""
    page.goto(live_server_url)
    expect(page).to_have_title("ReleCloud - Expand your horizons")
    page.close()


@pytest.mark.parametrize(
    "page_title, page_url",
    (
        ("Request Information", "info"),
        ("Destinations", "destinations"),
        ("About", "about"),
    ),
)
def test_header_has_request_info(mock_functions_env, page: Page, live_server_url: str, page_title, page_url):
    """Test that the header loads with links"""
    page.goto(live_server_url)
    header = page.locator("nav")

    # Request Info
    request_info = header.get_by_role("link", name=page_title)
    expect(request_info).to_have_attribute("href", re.compile(rf".*{page_url}.*"))
    page.close()


def test_request_information(mock_functions_env, page: Page, live_server_url: str):
    """Test that the request info form page loads"""
    page.goto(live_server_url)
    page.get_by_role("link", name="Request Information").click()
    expect(page).to_have_title("ReleCloud - Request information")
    page.close()


def test_destinations(mock_functions_env, page: Page, live_server_url: str):
    page.goto(live_server_url)
    page.get_by_role("link", name="Destinations").click()
    expect(page).to_have_title("ReleCloud - Destinations")


destinations = (
    "The Sun",
    "Mercury",
    "Venus",
    "Earth",
    "Mars",
    "Jupyter",
    "Saturn",
    "Uranus",
    "Neptune",
    "Pluto",
)

cruises = (
    "The Sun Tour",
    "The Hot Tour",
    "The Cold Tour",
    "The Central Tour",
    "The Big Tour",
)


@pytest.mark.parametrize(
    "destination",
    destinations,
)
def test_destination_options(
    page: Page,
    mock_functions_env,
    live_server_url: str,
    destination,
):
    """Test that the destinations page loads with seeded data"""

    # Create a destination
    page.goto(live_server_url)

    page.get_by_role("link", name="Destinations").click()
    expect(page).to_have_title("ReleCloud - Destinations")
    expect(page.get_by_text(destination)).to_be_visible()


@pytest.mark.parametrize(
    "destination",
    destinations,
)
def test_destination_options_have_cruises(page: Page, mock_functions_env, live_server_url: str, destination):
    page.goto(live_server_url)
    page.get_by_role("link", name="Destinations").click()
    page.get_by_role("link", name=destination).click()
    expect(page).to_have_url(re.compile(r".*destination/\d+", re.IGNORECASE))
    expect(page).to_have_title(f"ReleCloud - {destination}")
    expect(page.locator("#page-title")).to_have_text(destination)
    page_cruises = page.locator(".list-group-item").all()

    for page_cruise in page_cruises:
        assert page_cruise.text_content() in cruises
    page.close()


def test_about(mock_functions_env, page: Page, live_server_url: str):
    """Test that the request info form page loads"""
    page.goto(live_server_url)
    page.get_by_role("link", name="About").click()
    expect(page.locator("#page-title")).to_have_text(re.compile(r".*about.*", re.IGNORECASE))
    page.close()
