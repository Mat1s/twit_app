# README

## Before use

Before install this application you must create your application in twitter. Follow to https://apps.twitter.com. After you sign in and click **[Create new App](https://apps.twitter.com/app/new)**. You need to fill in the form include Callback URL. After in your twitter application you find *Keys and Access Tokens* and copy Consumer Key(API Key), Consumer Secret(API Secret). 

## Install

In console clone repository from
```
git clone git@github.com:Mat1s/twit_app.git
```
Download and install by running:
```
bundle install
```
Create database table:
```
rails db:migrate
```
## Configure your rails app
Replace in file twit_app/config/oauth.yml API Key and API Secret with yours.

Use the `rails s` command to run your application.

Use it!
