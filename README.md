# AppApi

## Endpoints

This API provides the following endpoints:
- GET `/api/login`: signin/login and get a jwt back
- GET `/api/person/info`: get your personal user information
- GET PUT `/api/capture/{idCapture}`: create, update and show a text/capture item
- GET POST`/api/capture`: create a new item and get the list of items
- GET POST `/api/capture{idCapture/timers`: create a new timer linked to an item, list timers for an item
- PUT `/api/capture{idCapture/timers/{idTimer}`: update a timer, i.e. start or stop a timer


## JWT header

Except for the login endpoint, all the requests' header need to contain an `Authorization` jwt value.
This jwt is verified via the pipeline `person`:

```elixir
  pipeline :person do
    plug AppApi.Plugs.ValidateToken
  end
```
The `ValidateToken` function will then send the jwt to the dwyl
authentication service and will returns either a `401` unauthorized response
or the person information when valid.
