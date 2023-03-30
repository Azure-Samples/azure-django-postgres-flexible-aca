from django.test import SimpleTestCase, TestCase
from django.urls import reverse

from .models import Cruise, Destination

# Create your tests here.


class IndexTest(SimpleTestCase):
    """Tests calling the index"""

    def test_index_status_code(self):
        """Tests fetching index by its url"""
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

    def test_index_url_by_name(self):
        """Tests fetching index by its name"""
        response = self.client.get(reverse("index"))
        self.assertEqual(response.status_code, 200)


class AboutTestCase(SimpleTestCase):
    """Tests calling the about"""

    def test_about_status_code(self):
        """Tests fetching about by its url"""
        response = self.client.get("/about")
        self.assertEqual(response.status_code, 200)

    def test_about_url_by_name(self):
        """Tests fetching about by its name"""
        response = self.client.get(reverse("about"))
        self.assertEqual(response.status_code, 200)


class DestinationsTest(TestCase):
    """Tests calling the destinations page"""

    def setUp(self):
        Destination.objects.create(name="Mars", description="make your way to the red planet")

    def test_destinations_status_code(self):
        """Tests fetching destinations by its url"""
        response = self.client.get("/destinations")
        self.assertIn(response.status_code, [200, 301])

    def test_destinations_url_by_name(self):
        """
        Tests fetching about by its name.
        """
        response = self.client.get(reverse("destinations"))
        self.assertIn(response.status_code, [200, 301])

    def test_destination_status_code(self):
        """Tests fetching destinations by its url"""
        dest = Destination.objects.get(name="Mars")
        response = self.client.get(f"/destination/{dest.pk}")
        self.assertContains(response, "Mars")


class CruisesTest(TestCase):
    cruise_name = "Contoso Cruises on the SS Marvin"

    def setUp(self):
        mars = Destination.objects.create(name="Mars", description="make your way to the red planet")

        cruise = Cruise.objects.create(
            name=self.cruise_name,
            description="Enjoy a ride on this Q36 luxurious space modulator",
        )

        cruise.destinations.set([mars])

    def test_cruise_status_code(self):
        """Tests fetching /cruises by its url"""
        cruise = Cruise.objects.get(name=self.cruise_name)
        response = self.client.get(f"/cruise/{cruise.pk}")
        self.assertContains(response, "Mars")


class InfoRequestTest(TestCase):
    cruise_name = "Contoso Cruises on the SS Marvin"

    def setUp(self):
        Destination.objects.create(name="Mars", description="make your way to the red planet")

        Cruise.objects.create(
            name=self.cruise_name,
            description="Enjoy a ride on this Q36 luxurious space modulator",
        )

    def tests_info_request_status_code(self):
        """Tests that the info request page loads"""
        response = self.client.get("/info_request")
        self.assertEqual(response.status_code, 200)

    def tests_info_request_form_fields(self):
        response = self.client.get("/info_request")
        fields = response.context["form"].fields.keys()

        self.assertIn("name", fields)
        self.assertIn("email", fields)
        self.assertIn("cruise", fields)
        self.assertIn("notes", fields)
