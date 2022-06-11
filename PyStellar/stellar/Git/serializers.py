from rest_framework import serializers


class GitCommitCheckSerializer(serializers.Serializer):
    """ Github Commit Check Parameters """
    owner = serializers.CharField(max_length=50, help_text='Git Owner')
    repo = serializers.CharField(max_length=50, help_text='Repository')
    token = serializers.CharField(max_length=50, help_text='Token')
    since = serializers.CharField(max_length=20, help_text='Since', allow_null=True, default='')
    until = serializers.CharField(max_length=20, help_text='Until', allow_null=True, default='')
