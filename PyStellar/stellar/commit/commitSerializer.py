from rest_framework import serializers


class commitHistory(serializers.Serializer):
    # channel = serializers.CharField(help_text='슬랙채널명')
    # token = serializers.CharField(help_text='Slack토큰')
    latest = serializers.CharField(max_length=10, help_text='마지막시간', allow_blank=True, default='')
    oldest = serializers.CharField(max_length=10, help_text='최초시간', allow_blank=True, default='')



