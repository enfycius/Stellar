import re

import pymysql

from stellar.settings import MYSQLUSER, MYSQLPASSWORD, MYSQLHOST, MYSQLNAME


class CommitDao:

    def insertcommit(self, attachments):
        return_json = {}
        commit = []
        commit_json = {}

        sql = "INSERT INTO commit_info(git_name, commit_text, commit_link, commit_date) VALUES(%s, %s, %s, now())"
        for i in attachments:
            for j in i:
                if "author_name" and "text" in j:
                    commit_json = {
                        'git_name': j['author_name'],
                        'text': j['fallback'],
                        'link': j['author_link']
                    }
                    commit_tuple = tuple(commit_json.values())
                else:
                    pass
            commit.append(commit_tuple)
        print('------commit------', commit)

        try:
            print('-------try-----------')
            connection = pymysql.connect(
                user=MYSQLUSER,
                password=MYSQLPASSWORD,
                host=MYSQLHOST,
                db=MYSQLNAME,
                charset='utf8'
            )
            cursor = connection.cursor()
            cursor.executemany(sql, commit)
        except Exception as error:
            print('-----Exception-----', error)
        else:
            print('-------success-------')
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
