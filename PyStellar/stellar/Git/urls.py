from django.urls import path
from . import views

app_name = 'Git'

urlpatterns = [

    path('gitcommithistory', views.GitCommitCheck.as_view()),
    path('gitrepo', views.GitRepo.as_view()),

]
