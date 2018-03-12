# Public Umbraco Cloud REST API

Umbraco Cloud has a REST API that you can use to automatically create new projects. This can come in really handy if you are going to create a lot of projects within a short period of time.

In this article you'll learn how to setup Umbraco Cloud projects using the REST API, and also how to invite and add users to these projects.

## Authentication

In order to start using the API you will need to have a **valid access token**. The token will be used in the **HTTP Authorization header** that you need to send along with every request you make to the API. Please contact our support about how to acquire a token, either through the chat on [Umbraco.io](https://www.s1.umbraco.io) or through contact@umbraco.com.

The scheme we use is called `token` and it's constructed by combining the email you are using with Umbraco.io and the provided token with a colon:

    user-email@example.com:6a5b0c687b7973db4b2568a59f2c446ee1ee9f9f06322f1bd6983718a48b5a6c

This then needs to be `base64` encoded (encoding should be UTF8):

    dXNlci1lbWFpbEBleGFtcGxlLmNvbTo2YTViMGM2ODdiNzk3M2RiNGIyNTY4YTU5ZjJjNDQ2ZWUxZWU5ZjlmMDYzMjJmMWJkNjk4MzcxOGE0OGI1YTZj

The resulting header should look like this:

    Authorization: token dXNlci1lbWFpbEBleGFtcGxlLmNvbTo2YTViMGM2ODdiNzk3M2RiNGIyNTY4YTU5ZjJjNDQ2ZWUxZWU5ZjlmMDYzMjJmMWJkNjk4MzcxOGE0OGI1YTZj

## Project endpoints

