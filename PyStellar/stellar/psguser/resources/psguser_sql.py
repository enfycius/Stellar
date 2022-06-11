def psgusersql():
    sql = """
SELECT user_info.id,user_info.slack_name, user_info.slack_nickname, user_info.kakao_name,
user_info.kakao_nickname, user_info.content, user_git.git_name
 FROM user_info, user_git WHERE user_info.id = user_git.id
          """

    return sql


def psgusergitsql():
    sql = """
            SELECT psg_info.username,
                   psg_github.github_name, 
                   psg_kakao.kakao_name, 
                   psg_rest.start_date,
                   psg_rest.end_date
            FROM psg_info 
            LEFT JOIN psg_github ON psg_info.username = psg_github.username
            LEFT JOIN psg_kakao ON psg_info.username = psg_kakao.username
            LEFT JOIN psg_rest ON psg_info.username = psg_rest.username
    """
    return sql


def psguserrest():
    sql = """
            SELECT 
                    psg_info.username, 
                    psg_kakao.kakao_name, 
                    psg_rest.start_date, 
                    psg_rest.end_date 
            FROM psg_info LEFT JOIN psg_rest ON psg_info.username = psg_rest.username
            LEFT JOIN psg_kakao ON psg_info.username = psg_kakao.username
            """
    return sql
