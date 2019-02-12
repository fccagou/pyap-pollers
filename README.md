# pyap-pollers
Pollers transforms collected datas to [pyap](https://github.comfccagou/pyap) event format


## Goal

The idea is to make a simple way to supervise systems and notify when something wrong happen.


## How

Using Unix philosophy, poller has to be simple and must do a single thing "well".

Pyap inputs are json data using the template `{"services":{ "ok":1, "warn":1, "crit":0, "unknown":0}}`.
The values are the sum of all services with the same state. Each poller's state changes the global status.
Because poller MUST be simple, it only feed the global status database but not the status itself. 

I chose the following architecture:
* poller products files as status
* filename contains the status
* no file means ok status
* a script aggregates all status and produce the json file
* a script runs all pollers and the json producer's script
* crontab is used to schedule all



