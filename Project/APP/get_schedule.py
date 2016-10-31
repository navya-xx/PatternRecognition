from quickstart import get_credentials
import httplib2
from apiclient import discovery
import datetime

def main():
    """Shows basic usage of the Google Calendar API.

    Creates a Google Calendar API service object and outputs a list of the next
    10 events on the user's calendar.
    """
    credentials = get_credentials()
    http = credentials.authorize(httplib2.Http())
    service = discovery.build('calendar', 'v3', http=http)

    #now = datetime.datetime.utcnow().isoformat() + 'Z' # 'Z' indicates UTC time
    # Find upcoming week i.e. one week from today, including today
    # Monday=1, Tuesday=2,..., Sunday=7
    # today's weekday
    now_weekday = datetime.datetime.utcnow().isoweekday()
    # number of days to look ahead
    time_now = datetime.datetime.utcnow()
    time_zero = datetime.time(0,0,0,0)
    time_end = datetime.time(23,59,59,0)
    date_min = datetime.date(time_now.year,time_now.month,(time_now.day))
    date_max = date_min + datetime.timedelta(days=6)
    time_min = datetime.datetime.combine(date_min,time_zero).isoformat() + 'Z'
    time_max = datetime.datetime.combine(date_max, time_end).isoformat() + 'Z'
    print(time_min)
    print(time_max)
    #print('Getting the upcoming 10 events')
    # get all calendars
    calResult = service.calendarList().list().execute()
    calEvents = calResult.get('items', [])

    complete_list = {}
    for event in calEvents:
        eventsResult = service.events().list(
            calendarId=event['id'],
            timeMin=time_min, timeMax = time_max).execute()
        events = eventsResult.get('items', [])
        complete_list.update({event['summary']:events})
    if not events:
        #print('0')
        return 0
    return complete_list


if __name__ == '__main__':
    main()