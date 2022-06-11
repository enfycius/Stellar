import datetime


def timecommitcheck(end_date):
    today = datetime.datetime.now()
    end_date = datetime.datetime(end_date.year, end_date.month, end_date.day)
    # end_date가 오늘날짜보다 나중이면 True를 반환
    if end_date > today:
        return True
    else:
        return False
