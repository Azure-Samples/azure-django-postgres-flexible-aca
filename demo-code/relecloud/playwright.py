import os

from django.contrib.staticfiles.testing import StaticLiveServerTestCase 
from playwright.sync_api import sync_playwright, Page, expect

class DemoCodeTests(StaticLiveServerTestCase):
    fixtures = ["seed_data.json"]

    @classmethod
    def setUpClass(cls):
        os.environ["DJANGO_ALLOW_ASYNC_UNSAFE"] = "true"
        super().setUpClass()
        cls.playwright = sync_playwright().start()
        cls.browser = cls.playwright.chromium.launch()

    @classmethod
    def tearDownClass(cls):
        super().tearDownClass()
        cls.browser.close()
        cls.playwright.stop()

    def test_request_info(self):
        page = self.browser.new_page()
        page.goto(self.live_server_url)
        page.get_by_role("link", name="Request Information").click()
        page.get_by_label("Name*").click()
        page.get_by_label("Name*").fill("pamela")
        page.get_by_label("Name*").press("Tab")
        page.get_by_label("Email*").fill("pammyla.fox@gmail.com")
        page.get_by_label("Email*").press("Tab")
        page.get_by_role("combobox", name="Cruise*").select_option("The Sun Tour")
        page.get_by_label("Notes*").click()
        page.get_by_label("Notes*").fill("more mars rovers pls")
        page.get_by_role("button", name="Save").click()
        page.get_by_role("alert").click()
        expect(page.locator("[role=alert]")).to_contain_text("Thank you, pamela! We will email you when we have more information about The Sun")
        page.close()

    def test_login(self):
        page = self.browser.new_page()
        page.goto(f"{self.live_server_url}/admin/")
        page.wait_for_selector('text=Django administration')
        page.fill('[name=username]', 'myuser')
        page.fill('[name=password]', 'secret')
        page.click('text=Log in')
        assert len(page.eval_on_selector(".errornote", "el => el.innerText")) > 0
        page.close()
