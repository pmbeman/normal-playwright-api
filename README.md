# normal-playwright-api
a playwright API inside docker

note: it can run on local docker or container like heroku
```
sudo docker pull ghcr.io/eloco/normal-playwright-api:latest
sudo docker run --rm=True -p 8080:8080 ghcr.io/eloco/local-lambda-playwright
```
```
bs64=`echo "page.goto('http://whatsmyuseragent.org/',wait_until='commit'); result=page.content()" | base64 -w 0`
http -f POST http://127.0.0.1:8080/post  run=${bs64} browser="webkit" device="iphone 6" stealth="True" | jq . | html2text -utf8 
```

```
param = {
        run:"result='test'"; # base64 or normal diy code,
        browser:"chromium";  # browser name,
        device:"iPhone X";   # device for webkit
        stealth:true;        # if stealth mode
        }
```
