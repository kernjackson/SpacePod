## GET pod
curl "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=1995-06-16" | python -mjson.tool > get-pod.json

## GET video
curl "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2021-11-08&thumbs=true" | python -mjson.tool > get-video.json

## GET random pods
curl "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=2&thumbs=true" | python -mjson.tool > get-random-pods.json

## GET pods
curl "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&start_date=2021-11-07&end_date=2021-11-08&thumbs=true" | python -mjson.tool > get-pods.json

## 200 Empty Explanation
curl "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2021-07-28&thumbs=true" | python -mjson.tool > 200-empty-explanation.json

## 200 No Copyright
curl "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2021-07-28&thumbs=true" | python -mjson.tool > 200-no-copyright.json

## 400 BAD REQUEST 1
curl "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=1995-06-15" | python -mjson.tool > 400-bad-request-1.json

## 400 BAD REQUEST 2
curl "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&start_date=2021-11-08&end_date=2021-11-07&concept_tags=true&thumbs=true" | python -mjson.tool > 400-bad-request-2.json

## 404 No Data
curl "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=1995-06-17" | python -mjson.tool > 404-no-data.json

## 403 API_KEY_MISSING
curl "https://api.nasa.gov/planetary/apod" | python -mjson.tool > 403-api-key-missing.json

## 403 API_KEY_INVALID
curl "https://api.nasa.gov/planetary/apod?api_key=DEMO_KE" | python -mjson.tool > 403-api-key-invalid.json
