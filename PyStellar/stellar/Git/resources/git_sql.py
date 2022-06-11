def git_user_owner_repo():
    sql = """
            SELECT 
                     username
                    ,github_name
                    ,github_token
                    ,github_repo
            FROM psg_github
            """
    return sql
