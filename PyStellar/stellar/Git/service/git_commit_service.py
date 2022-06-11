import requests
import dateutil.parser
import pytz

from Git.dao.git_dao import GitOwnerRepo


class GitCommitCheckService:
    """Github Public 저장소 커밋 기록 가져오기"""

    @classmethod
    def git_public_request(cls, request):
        """Commit 기록 요청"""
        owner = request.GET['owner']
        repo = request.GET['repo']
        token = request.GET['token']

        if request.GET.get('since', '') and request.GET.get('until', ''):
            since = request.GET['since']
            until = request.GET['until']
            r = requests.get(f'https://api.github.com/repos/{owner}/{repo}/commits?my_client_id={owner}&since={since}&until={until}', headers={'Authorization': 'token '+token})
        elif request.GET.get('since', ''):
            since = request.GET['since']
            r = requests.get(f'https://api.github.com/repos/{owner}/{repo}/commits?my_client_id={owner}&since={since}', headers={'Authorization': 'token '+token})
        elif request.GET.get('until', ''):
            until = request.GET['until']
            r = requests.get(f'https://api.github.com/repos/{owner}/{repo}/commits?my_client_id={owner}&until={until}', headers={'Authorization': 'token '+token})
        else:
                r = requests.get(f'https://api.github.com/repos/{owner}/{repo}/commits?my_client_id={owner}', headers={'Authorization': 'token '+token})
            
        data = r.json()

        commit_json = None
        commit_info = [None] * 4
        if str(type(data)) == "<class 'list'>":
            if str(data) != '[]':
                local_timezone = pytz.timezone('Asia/Seoul')
                commit_json = []
                for i in data:
                    for k, v in i.items():
                        if k == 'commit':
                            commit_info[1] = v['message']
                            commit_info[2] = (dateutil.parser.parse(v['author']['date'])).replace(tzinfo=pytz.utc).astimezone(local_timezone)
                        elif k == 'author':
                            commit_info[0] = v['login']
                        elif k == 'html_url':
                            commit_info[3] = v
                            
                    commit_json.append({'username': commit_info[0],
                                                'message': commit_info[1],
                                                'date': commit_info[2],
                                                'url': commit_info[3]})
        else:
            commit_json = [{'username': owner, 'message': 'Fault Token Info OR Repo Info', 'date': None, 'url': None}]

        return commit_json

    @classmethod
    def git_commit_insert(cls, commit_list):
        """ 깃 커밋 리스트를 디비에 저장"""
        list_tuple = []
        for i in commit_list:
            list_tuple.append(tuple(i.values()))
        insert_commit = GitOwnerRepo()
        return_json = insert_commit.insert_git_commit(list_tuple)
        return return_json
