from django.test import SimpleTestCase, TestCase
from django.urls import reverse
from .models import Destination, Cruise, InfoRequest
# Create your tests here.


class IndexTest(SimpleTestCase):
    """Tests calling the index"""

    def test_index_status_code(self):
        """Tests fetching index by its url"""
        response = self.client.get('/')
        self.assertEqual(response.status_code, 200)

    def test_index_url_by_name(self):
        """Tests fetching index by its name"""
        response = self.client.get(reverse('index'))
        self.assertEqual(response.status_code, 200)
    
class AboutTestCase(SimpleTestCase):
    """Tests calling the about"""

    def test_about_status_code(self):
        """Tests fetching about by its url"""
        response = self.client.get('/about')
        self.assertEqual(response.status_code, 200)

    def test_about_url_by_name(self):
        """Tests fetching about by its name"""
        response = self.client.get(reverse('about'))
        self.assertEqual(response.status_code, 200)

class DestinationsTest(TestCase):
    """Tests calling the destinations page"""
    def setUp(self):
        Destination.objects.create(
            name = "Mars",
            description = "make your way to the red planet"
        )

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
        response = self.client.get(f'/destination/{dest.pk}')
        self.assertContains(response, "Mars")

class CruisesTest(TestCase):
    cruise_name = "Contoso Cruises on the SS Marvin"

    def setUp(self):
        mars = Destination.objects.create(
            name = "Mars",
            description = "make your way to the red planet"
        )

        cruise = Cruise.objects.create(
            name = self.cruise_name,
            description = "Enjoy a ride on this Q36 luxurious space modulator",
        )
        
        cruise.destinations.set([mars])
    


    def test_cruise_status_code(self):
        """Tests fetching /cruises by its url"""
        cruise = Cruise.objects.get(name=self.cruise_name)
        response = self.client.get(f'/cruise/{cruise.pk}')
        self.assertContains(response, "Mars")

# # urlpatterns = [
# #     path('', views.index, name='index'),
# #     path('about', views.about, name='about'),
# #     path('destinations/', views.destinations, name='destinations'),
# #     path('destination/<int:pk>', views.DestinationDetailView.as_view(), name='destination_detail'),
# #     path('cruise/<int:pk>', views.CruiseDetailView.as_view(), name='cruise_detail'),
# #     path('info_request', views.InfoRequestCreate.as_view(), name='info_request'),
# # ]