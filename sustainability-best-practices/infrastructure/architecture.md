# Architecture

## CDNs - cached assets, shorter travel time

**Content Delivery Networks** can deliver a significant performance boost by serving assets from nodes physically near users. This is particularly beneficial for services that have users that are spread out geographically.&#x20;

There can be challenges, particularly for highly dynamic/personalized websites. However all modern content delivery networks support ‘_edge computing_’ which enables a degree of dynamism while still retaining the big performance advantages.

## HTTP/2

**HTTP2** is a much more efficient way of transmitting data between servers and users, including parallel transmission of data, header compression, and binary transmission. It will make your website faster for users, and reduce the bandwidth required - better for the planet.

## Serverless (Azure Functions / Amazon Web Services (AWS) Lambdas / Edge Functions)

**Serverless functions** are great as they abstract away the underlying infrastructure from you and let you focus on the code itself. They’re designed to be short-lived and scalable. And they’re a good fit for things like API endpoints, processing tasks, and that kind of thing. It’s another example of technology where you don’t have to be worrying about maintaining servers/VMs.&#x20;

The cloud provider can worry about balancing the load behind the scenes - and they’re probably better at that than you are.
