import datetime
import time

from drf_yasg import openapi

from drf_yasg.utils import swagger_auto_schema
from rest_framework.generics import CreateAPIView, RetrieveAPIView, ListAPIView
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView

from commit.commitSerializer import commitHistory
from commit.service.commitservice import commithistory


class commitMessageHistory(ListAPIView):
    """
    '''
        Slack에서 CommitMessage 받아오기

    '''
    """
    permission_classes = [AllowAny, ]

    # response = {
    #     "200": openapi.Response(
    #         description="JSON",
    #         required=[],
    #         schema=openapi.TYPE_OBJECT,
    #         property={
    #             "commitList": openapi.Response(type=openapi.TYPE_OBJECT, description='String')
    #         }
    #     )
    # }

    @swagger_auto_schema(
        query_serializer=commitHistory,
        tags=['Slack Commit', ],
        responses={"200": 'success'},
        operation_summary="Slack에서 Message History를 받아온다.",
        produces='application/json',
        operation_description=
        """
        CommitList
        ---
                    SlackHistory
                    '''
                        #json
                        {
                            'latest': 1610582399,
                            'oldest': 1610496000
                        }
                        '''        
            """

    )
    # def get(self, request):
    def get(self, request, *args, **kwargs):
        print('------request----------', request.GET)
        latest = request.GET['latest']
        oldest = request.GET['oldest']
        r = commithistory(latest, oldest)
        data = r.historyrequest()
        attachments = r.messagelist(data)
        commitlist = r.commituserlist(attachments)

        print('----response-----', commitlist)
        result = {'result': commitlist}
        print('----result-----', result)
        attachments_json = {}
        hits = len(attachments)
        attachments_json.update({'hits': hits,
                                 'attachments': attachments})
        return Response(attachments_json)


class CommitMessage(CreateAPIView):
    """
    커밋 내역 디비 저장
    ---
        ```
        {
            "latest": "1610582399",
            "oldest": "1610496000"
        }
        '''
    """
    permission_classes = [AllowAny, ]
    request_dict = openapi.Schema(type=openapi.TYPE_OBJECT,
                                  required=['latest', 'oldest'],
                                  properties={
                                      'latest': openapi.Schema(type=openapi.TYPE_STRING, description='마지막시간'),
                                      'oldest': openapi.Schema(type=openapi.TYPE_STRING, description='최초시간')
                                  })
    response_dict = {
        "200": openapi.Schema(type=openapi.TYPE_OBJECT,
                              required=[],
                              properties={
                                  'result': openapi.Schema(type=openapi.TYPE_STRING, description='성공')
                              })
    }

    @swagger_auto_schema(
        tags=['Slack Commit', ],
        operation_summary="Slack에서 받아온 Message History를 DB에 저장",
        request_body=request_dict,
        responses=response_dict,
        produces='application/json',
    )
    def post(self, request, *args, **kwargs):
        print('------request.data-----', request.data)
        latest = request.data['latest']
        oldest = request.data['oldest']
        r = commithistory(latest, oldest)
        data = r.historyrequest()
        attachments = r.messagelist(data)
        result = r.insertcommit(attachments)
        return Response(result)


class commitcheck(ListAPIView):
    """
    커밋 체크 디비 저장
    """
    permission_classes = [AllowAny, ]

    @swagger_auto_schema(
        query_serializer=commitHistory,
        tags=['Psg User', ],
        responses={"200": openapi.Schema(type=openapi.TYPE_STRING,
                                         description='성공')},
        operation_summary="commit 체크",
        produces='application/json',
        operation_description=
        """
        CommitCheck
        ---
                        입력 없이 실행하면 오늘의 커밋 검사
                          
            """

    )
    def get(self, request, *args, **kwargs):
        # 오늘 커밋
        print('-------request------', request.GET)
        if request.GET:
            # 입력값 존재
            latest = request.GET['latest']
            oldest = request.GET['oldest']
        else:
            # 입력값 X
            today = datetime.datetime.now()
            latesttoday = datetime.datetime(today.year, today.month, today.day, hour=23, minute=59, second=59)
            # GMT시간으로 변환되어 한국시간과 맞추기 위해 32400초를 더함.
            latest = str(latesttoday.timestamp() + 32400)[0:10]
            oldesttoday = datetime.datetime(today.year, today.month, today.day, hour=0, minute=0, second=0)
            # GMT시간으로 변환되어 한국시간과 맞추기 위해 32400초를 더함.
            oldest = str(oldesttoday.timestamp() + 32400)[0:10]

        print('-----latest-----', latest)
        print('-----oldest-----', oldest)

        r = commithistory(latest, oldest)
        data = r.historyrequest()
        attachments = r.messagelist(data)
        uncommitjson = {}
        if len(attachments) > 0:
            commitlist = r.commituserlist(attachments)
            uncommitlist = r.commitcheck(commitlist)
            hits = len(uncommitlist)
            uncommitjson.update({'hits': hits,
                                 'uncommitlist': uncommitlist})
            return Response(uncommitjson)
        else:
            result = {'result': '커밋 기록 없음'}
            return Response(result)



