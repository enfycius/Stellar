import pymysql
from stellar.settings import MYSQLUSER, MYSQLNAME, MYSQLPASSWORD, MYSQLHOST, MYSQLPORT


class GitOwnerRepo:
    """ Psg 멤버들의 Github 정보를 가져옴 """

    @classmethod
    def select_github(cls, sql):
        git_list = []
        try:
            connection = pymysql.connect(
                user=MYSQLUSER,
                password=MYSQLPASSWORD,
                host=MYSQLHOST,
                db=MYSQLNAME,
                charset='utf8'
            )
            cursor = connection.cursor()
            cursor.execute(sql)
        except Exception as e:
            print('-----GitDaoException-----', e)
        else:
            print('--------GitDaoSuccess------')
            columns = ('username', 'github_name', 'github_token', 'github_repo')
            rows = cursor.fetchall()
            for row in rows:
                git_list.append(dict(zip(columns, row)))
        finally:
            cursor.close()
            connection.close()
        return git_list

    @classmethod
    def insert_git_commit(cls, request_data):
        sql = "INSERT INTO commit_info(git_name, commit_text, commit_link, commit_date) VALUES(%s, %s, %s, now())"
        try:
            connection = pymysql.connect(
                user=MYSQLUSER,
                password=MYSQLPASSWORD,
                host=MYSQLHOST,
                db=MYSQLNAME,
                charset='utf8'
            )
            cursor = connection.cursor()
            cursor.executemany(sql, request_data)
        except Exception as error:
            print('-----Exception-----', error)
        else:
            insert_count = cursor.rowcount
            return_json = {
                'count': insert_count,
                'result': 'success'
            }
            connection.commit()

        finally:
            cursor.close()
            connection.close()
        return return_json
