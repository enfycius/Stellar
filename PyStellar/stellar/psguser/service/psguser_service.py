from psguser.dao.psguser_dao import PsgUserList
from psguser.resources import psguser_sql


class PsgUserListService:

    def psguserlistservice(self):
        sqluser = psguser_sql.psgusersql()
        psguserdao = PsgUserList()
        return_json = psguserdao.psguserlistdao(sqluser)
        return return_json

    def psgusergitlistservice(self):
        sqlgit = psguser_sql.psgusergitsql()
        psguserdao = PsgUserList()
        return_git_json = psguserdao.usergitdao(sqlgit)
        return return_git_json

    def psguserrestlistservice(self):
        sqlrest = psguser_sql.psguserrest()
        psgrestdao = PsgUserList()
        return_rest = psgrestdao.userrest(sqlrest)
        return return_rest

