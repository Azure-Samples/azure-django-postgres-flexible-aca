# ruff: noqa: F401

# Import only the tests that we want to run for smoke testing
from ..local.test_playwright import (
    test_about,
    test_destination_options_have_cruises,
    test_destinations,
    test_home,
    test_request_information,
)
