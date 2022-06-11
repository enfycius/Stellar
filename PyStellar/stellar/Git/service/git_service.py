from Git.dao.git_dao import GitOwnerRepo
from Git.resources import git_sql
import datetime

from Git.service.git_commit_service import GitCommitCheckService


class GitRepoService:
    """ Psg Git 유저 정보 서비스 """

    @classmethod
    def git_repo(cls):
        sql_git = git_sql.git_user_owner_repo()
        git = GitOwnerRepo()
        psg_user_git_list = git.select_github(sql_git)
        today = datetime.datetime.now()
        latesttoday = datetime.datetime(today.year, today.month, today.day, hour=23, minute=59, second=59)
        # GMT시간으로 변환되어 한국시간과 맞추기 위해 32400초를 더함.
        until = str(latesttoday.timestamp() + 32400)[0:10]
        oldesttoday = datetime.datetime(today.year, today.month, today.day, hour=0, minute=0, second=0)
        # GMT시간으로 변환되어 한국시간과 맞추기 위해 32400초를 더함.
        since = str(oldesttoday.timestamp() + 32400)[0:10]
        commit_list = []
        for i in psg_user_git_list:
            print('-----i-----', i)
            i.update({'since': since,
                      'until': until})
            commit = GitCommitCheckService()
            commit_json = commit.git_public_request(i)
            commit_list.append(commit_json)
        return commit_list

    # @classmethod
    # def git_commit(cls, psg_git_data, since, until):
    #     git_dao = GitOwnerRepo()
    #     git_sql = git_sql.git_user_owner_repo()
    #     git_list = git_dao.select_github()
