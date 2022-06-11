import datetime

import requests

from commit.dao.commit_dao import CommitDao
from commit.resources.commit_sql import insert_commit
from common.commonutil import timecommitcheck
from psguser.service.psguser_service import PsgUserListService
from stellar.settings import SLACKURL, BOTTOKEN, CHANNEL


class commithistory:

    def __init__(self, latest, oldest):
        self.latest = latest
        self.oldest = oldest

    def historyrequest(self):
        latest = self.latest
        oldest = self.oldest
        # 슬랙 api 호출
        r = requests.get(f"{SLACKURL}?token={BOTTOKEN}&channel={CHANNEL}&latest={latest}&oldest={oldest}&pretty=1")
        # 데이터를 json으로 받음
        data = r.json()
        return data

    def messagelist(self, data):
        attachments = []
        # data의 ok 키값이 True 일 때
        if data['ok']:
            message = data['messages']
            # message의 attachments 값 추출
            for i in message:
                if "attachments" in i:
                    attachments.append(i['attachments'])
        else:
            # data의 ok 키값이 False 일 때
            print('request 실패')
            result_json = {'result': 'False'}
            return result_json
        return attachments

    def commituserlist(self, attachments):
        commitlist = []
        commitList = set()
        for i in attachments:
            for j in i:
                # author_name 이 attachments에 존재할 때
                if 'author_name' in j:
                    # commitList에 author_name을 적재
                    commitlist.append(j['author_name'])
                    # 중복제거를 위해 집합(set)으로 적재한다.
                    commitList = set(commitlist)
        return commitList

    # 커밋 히스토리 기록 함수
    def insertcommit(self, attachments):
        # 커밋 히스토리 내역을 내부 디비에 저장
        insert_commit_json = CommitDao()
        return_json = insert_commit_json.insertcommit(attachments)

        return return_json

    def commitcheck(self, commitList):
        restlist = PsgUserListService()
        restuser = restlist.psgusergitlistservice()
        # 받아온 커밋리스트를 차례대로 반복문으로 검사할 것임
        for i in commitList:
            # psg 웹 사이트 회원 정보
            for j in restuser:
                # restuser의 첫번째 딕셔너리의 key : value
                for k, v in j.items():
                    # restuser가 키가 github_name 일 때
                    if k == 'github_name':
                        # github_name의 value값이 commitList의 i값과 같을 때
                        if i == v:
                            # 해당 유저를 restuser에서 삭제
                            restuser.remove(j)
                    # restuser의 키가 end_date 일 때
                    if k == 'end_date':
                        # end_date value값이 존재하지 않을 때
                        if v is None:
                            # 그냥 넘어감 자바의 continue와 같음
                            pass
                        # end_date value값이 존재할 때
                        elif v is not None:
                            # timecommitcheck 함수 값이 True일 때
                            if timecommitcheck(v):
                                # 해당 유저 삭제
                                restuser.remove(j)
                            # timecommitcheck 함수 값이 False일 때
                            else:
                                pass
        return restuser
