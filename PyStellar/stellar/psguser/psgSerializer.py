from rest_framework import serializers

class psgserializer(serializers.Serializer):
    channel = serializers.CharField(help_text='슬랙채널명')
    token = serializers.CharField(help_text='Slack토큰')