from django.urls import path
from . import views

app_name = 'psguser'

urlpatterns = [

    path('user/', views.userList.as_view(), name='userlist'),
    path('user/rest/', views.psg_rest.as_view(), name='userrestlist'),
]
