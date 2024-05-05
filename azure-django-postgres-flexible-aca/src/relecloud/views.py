from typing import Any, Dict

from django.contrib.messages.views import SuccessMessageMixin
from django.shortcuts import render
from django.urls import reverse_lazy
from django.views import generic

from . import models


# Create your views here.
def index(request):
    return render(request, "index.html")


def about(request):
    return render(request, "about.html")


def destinations(request):
    all_destinations = models.Destination.objects.all()
    return render(request, "destinations.html", {"destinations": all_destinations})


class DestinationDetailView(generic.DetailView):
    template_name = "destination_detail.html"
    model = models.Destination

    def get_context_data(self, **kwargs: Any) -> Dict[str, Any]:
        context = super().get_context_data(**kwargs)
        context["cruises"] = self.get_object().cruises.all()
        return context


class CruiseDetailView(generic.DetailView):
    template_name = "cruise_detail.html"
    model = models.Cruise


class InfoRequestCreate(SuccessMessageMixin, generic.CreateView):
    template_name = "info_request_create.html"
    model = models.InfoRequest
    fields = ["name", "email", "cruise", "notes"]
    success_url = reverse_lazy("index")
    success_message = "Thank you, %(name)s! We will email you when we have more information about %(cruise)s!"
