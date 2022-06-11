def insert_commit():
    sql = """
                INSERT INTO commit_info(
                                        git_name,
                                        commit_text,
                                        commit_link
                                        )
                            VALUES(
                                    %s,
                                    %s,
                                    %s
                                  )
            """
