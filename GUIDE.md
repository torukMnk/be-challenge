Start time

- Reading documentation and looking at the api endpoints
- Testing endpoints with Postman
- Add httparty to handle http request
- Add Client to handle login authentication
- Add pry gem for debuging
- Add Report and Utils namespace Details, List, ReportStrategy
- Add ReportStrategyCsv and fixes
- Thinking about unique constraint external_id error
- Add sidekiq background processing
- Add TransactionJob and Rules for unique constraint processing
- Add Thread fetch_async to increase performance via parallel requests to get reports details

# Development
## Pre-requisites
- Install & Running Redis
```unix
~/p/be-challenge ❯❯❯ brew services info redis
redis (homebrew.mxcl.redis)
Running: ✔
Loaded: ✔
Schedulable: ✘
User: memo
PID: 4376
```
## Terminal 1 - Sidekiq
```unix
bundle exec sidekiq -r ./app.rb  -c 5 -q high
```
optional Sidekiq Dashboard browser

```unix
http://localhost:8080/sidekiq/
```
## Terminal 2 - IRB
```unix
~/p/f/be-challenge ❯❯❯ irb
2.7.8 :001 > require './app.rb'
=> true
2.7.8 :002 > puts Benchmark.measure { Report.fetch! }
  0.053386   0.008736   0.062122 (  2.818609)
 => nil
 2.7.8 :003> puts Benchmark.measure { Report.fetch_async! }
  0.035009   0.009612   0.044621 (  1.775210)
 => nil
```
Async has better times!
