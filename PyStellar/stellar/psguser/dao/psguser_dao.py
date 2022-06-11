import pymysql
from stellar.settings import MYSQLUSER, MYSQLNAME, MYSQLPASSWORD, MYSQLHOST, MYSQLPORT


class PsgUserList:

    def psguserlistdao(self, sqluser):
        return_json = {}
        userList = []
        try:
            print('------try---------')
            connection = pymysql.connect(
                user=MYSQLUSER,
                password=MYSQLPASSWORD,
                host=MYSQLHOST,
                db=MYSQLNAME,
                charset='utf8'
            )
            cursor = connection.cursor()
            cursor.execute(sqluser)
        except Exception as e:
            print('-----UserListException-----', e)
        else:
            print('--------UserListSuccess------')
            columns = ('id', 'slack_name', 'slack_nickname', 'kakao_name', 'kakao_nickname', 'content', 'git_name')
            rows = cursor.fetchall()
            for i in rows:
                # return_json = {
                #     'id': i[0],
                #     'slack_name': i[1],
                #     'slack_nickname': i[2],
                #     'kakao_name': i[3],
                #     'kakao_nickname': i[4],
                #     'content': i[5]
                # }
                # userList.append(return_json)

                userList.append(dict(zip(columns, i)))
        finally:
            cursor.close()
            connection.close()


        return userList

    def usergitdao(self, sqlgit):
        return_git_json = {}
        gitList = []
        columns = ["username", "github_name", "kakao_name", "start_date", "end_date"]
        try:
            print('------try---------')
            connection = pymysql.connect(
                user=MYSQLUSER,
                password=MYSQLPASSWORD,
                host=MYSQLHOST,
                db=MYSQLNAME,
                charset='utf8'
            )
            cursor = connection.cursor()
            cursor.execute(sqlgit)
        except Exception as e:
            print('-------GitListException-------', e)
        else:
            print('--------GitListSuccess------')

            rows = cursor.fetchall()

            for i in rows:
                gitList.append(dict(zip(columns, i)))


        finally:
            cursor.close()
            connection.close()

        return gitList

    def userrest(self, sqlrest):
        restlist = []
        try:
            print('------try---------')
            connection = pymysql.connect(
                user=MYSQLUSER,
                password=MYSQLPASSWORD,
                host=MYSQLHOST,
                db=MYSQLNAME,
                charset='utf8'
            )
            cursor = connection.cursor()
            cursor.execute(sqlrest)
        except Exception as e:
            print('-------RestListException-------', e)
        else:
            print('--------RestListSuccess------')
            columns = ('username', 'kakao_name', 'start_date', 'end_date')
            rows = cursor.fetchall()
            for i in rows:
                restlist.append(dict(zip(columns, i)))
        finally:
            cursor.close()
            connection.close()
        return restlist



