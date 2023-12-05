# Smoke tests

This directory contains smoke tests for the project.
These tests are meant to be run against a running instance of the project,
not against a local development server.

See azure-dev.yaml for an example of how to run these tests in GitHub actions.

```
python3 -m pytest --exitfirst src/tests/smoke/smoketests.py --live-server-url $URI
```