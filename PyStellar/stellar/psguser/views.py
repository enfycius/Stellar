from drf_yasg import openapi

from drf_yasg.utils import swagger_auto_schema
from rest_framework.generics import ListAPIView
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView

from psguser.psgSerializer import psgserializer
from psguser.service.psguser_service import PsgUserListService


class userList(ListAPIView):
    """
    '''
        PSG User List

    '''
    """
    permission_classes = [AllowAny, ]

    response_dict = {
        "200": openapi.Schema(
            type=openapi.TYPE_OBJECT,
            properties={
                "PsgUser": openapi.Schema(
                    type=openapi.TYPE_OBJECT,
                    properties={
                        "id": openapi.Schema(type=openapi.TYPE_STRING,
                                             description='Slack 고유 ID'),
                        "slackname": openapi.Schema(type=openapi.TYPE_STRING,
                                                    description='Slack 가입 ID'),
                        "slacknickname": openapi.Schema(type=openapi.TYPE_STRING,
                                                        description='Slack 닉네임'),
                        "kakaonickname": openapi.Schema(type=openapi.TYPE_STRING,
                                                        description='카카오톡 닉네임'),
                        "gitname": openapi.Schema(type=openapi.TYPE_OBJECT,
                                                  properties={

                                                  }),
                    }

                )
            }
        )
    }

    @swagger_auto_schema(
        # query_serializer=psgserializer,
        tags=['Psg User', ],
        responses=response_dict,
        operation_summary="PSG User List를 받아온다.",
        produces='application/json',
        operation_description=
        """
        Psg User List
        ---
                    Psg User 명단
    
        """

    )
    def get(self, request, *args, **kwargs):
        return self.list(self, request, *args, **kwargs)

    def list(self, request, *args, **kwargs):
        # return_json = []

        psg_user_json = PsgUserListService()
        return_json = psg_user_json.psguserlistservice()
        result = {'content': return_json}
        return Response(result)

    # def list(self, request, *args, **kwargs):
    #     return Response()


class psg_rest(ListAPIView):
    """
    '''
        PSG User Rest List

    '''
    """
    permission_classes = [AllowAny, ]

    @swagger_auto_schema(
        # query_serializer=psgserializer,
        tags=['Psg User', ],
        responses={'200': openapi.Schema(type=openapi.TYPE_STRING,
                                         description='성공')},
        operation_summary="PSG User Rest List",
        produces='application/json',
        operation_description=
        """
        Psg User List
        ---
                    Psg 회원들의 ID와 Rest 설정 목록조회

        """

    )
    def get(self, request, *args, **kwargs):
        restlist = PsgUserListService()
        return_rest = restlist.psguserrestlistservice()
        result = {'content': return_rest}
        return Response(result)
