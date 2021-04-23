# Work in Progress, don't use it yet.

# PUSHBOX

Pushbox is an open-source project created to centralize your push notifications. It provides an API to your devices register and subscribes and also provides an API to send notifications for this devices.

* Support device external reference
* Support device extra data and tags
* Support Topics and Subscribes

## How to Install

**To Do**

* Create docker tutorial
* Create osx tutorial
* Create linux tutorial

## Authentication

To create a apiKey run rails console and create a User. For a client user uses the role **client** and for admin user uses the role **admin**

> User.create(name: "App Client", role: :client)

> User.create(name: "Backend Client", role: :admin)

The api_key for user is generated automatically when user is created. Next you have to get it.

> User.where(role: :cliente).take.api_key

> User.where(role: :admin).take.api_key

Now that you has the api_key, send it in all of your requests using the header *PushBox-Api-Key*

### Providers supported

- Expo

**To Do**

* Create GCM Provider
* Create APNS Provider


# Documentation

Swagger API docs (https://app.swaggerhub.com/apis-docs/eduardolagares5/Pushbox/0.0.2)
