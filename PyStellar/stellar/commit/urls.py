from django.urls import path
from . import views

app_name = 'commit'

urlpatterns = [

    path('history/', views.commitMessageHistory.as_view(), name='commitList'),
    path('commitmessage/', views.CommitMessage.as_view(), name='commitMessage'),
    path('commitcheck/', views.commitcheck.as_view(), name='commitcheck'),

]
