from requests_oauthlib import OAuth1Session
import json
import os

twitter = OAuth1Session(    client_key=os.environ['CLIENT_KEY'],
                            client_secret=os.environ['CLIENT_SECRET'],
                            resource_owner_key=os.environ['RESOURCE_KEY'],
                            resource_owner_secret=os.environ['RESOURCE_SECRET'] )


with open("ehsteve.png", mode='rb') as file: # b is important -> binary
    img = file.read()


url = "https://upload.twitter.com/1.1/media/upload.json?media_category=tweet_image"
r = twitter.post( url, files=dict(media=img))
data = json.loads(r.content);

url2 = 'https://api.twitter.com/1.1/statuses/update.json?status=%40thestobor hello from github&in_reply_to_status_id=' + os.environ["latest_id"] + '&media_ids=' + data["media_id_string"]
r2 = twitter.post(url2)
