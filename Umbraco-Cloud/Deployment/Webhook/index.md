# Deployment Webhook
You can now configure a deployment webhook to be triggered upon succesfull deployments to any of your environments (local -> development -> staging -> live).

## Configuration steps

1. Portal -> Settings -> Manage Webhooks.
2. Select the environment for which to register a webhook.
3. Fill in the url to which the information about a deployment should be posted to. Absolute url with http/https schema is an acceptable input to the field.
3. Add Webhook.

## Sample data
General information in json format about the deployment will be posted to the url configured in the previous section.

### Headers
The headers contains information about the payload being in json format as well as a version of the payload.

X-Umb-Webhook-Version: 1
Content-Type: application/json; charset=utf-8

### Contents
Contents of the payload contain general information about the current deployment with links to the project in the portal or the site.
Last part of the contents is a collection/enumeration of commits that were deployed to the environment, mentioning the author, the commit message and changed files. 

{
   "Id":"40810bf1bbbfc16dd273162509de297ad386fb4e",
   "Status":"success",
   "StatusText":"",
   "AuthorEmail":"laughing@unicorn.dk",
   "Author":"Laughing Unicorn",
   "Message":"Adding document type 'LaughingUnicornLaughs'",
   "Progress":"",
   "ReceivedTime":"2017-10-02T11:19:00.4984213Z",
   "StartTime":"2017-10-02T11:19:04.1328336Z",
   "EndTime":"2017-10-02T11:19:24.3470224Z",
   "LastSuccessEndTime":"2017-10-02T11:19:24.3470224Z",
   "Complete":true,
   "ProjectName":"laughingUnicorn",
   "ProjectUrl":"s1.umbraco.io/project/laughingunicorn",
   "SiteUrl":"laughingunicorn.s1.umbraco.io",
   "EnvironmentName":"Live",
   "Commits":[
      {
         "AuthorName":"Laughing Unicorn",
         "AuthorEmail":"laughing@unicorn.dk",
         "Message":"Adding document-type 'LaughingUnicornLaughs'\n",
         "Timestamp":"2017-10-02T07:16:39",
         "ChangedFiles":[
            "data\\revision\\document-type__9ac71ecba6d84344af4bcbf43ab6cd80.uda"
         ]
      },
      {
         "AuthorName":"Laughing Unicorn",
         "AuthorEmail":"laughing@unicorn.dk",
         "Message":"Adding template 'LaughingUnicornLaughs'\n",
         "Timestamp":"2017-10-02T07:16:38",
         "ChangedFiles":[
            "Views\\laughingunicornlaughs.cshtml",
            "data\\revision\\template__80d64e8172df46479ccf330bb9f63f2c.uda"
         ]
      }
   ]
}


