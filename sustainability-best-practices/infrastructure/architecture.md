# Architecture

### CDNs - cached assets, shorter travel time
Content Delivery Networks can deliver a significant performance boost by serving assets from nodes physically near to users. This is particularly beneficial for services that have users that are spread out geographically. There can be challenges, particularly for highly dynamic / personalised websites, but all modern content delivery networks support ‘edge computing’ which enables a degree of dynamism while still retaining the big performance advantages.

### HTTP/2
HTTP2 is a much more efficient way of transmitting data between servers and users, including parallel transmission of data, header compression and binary transmission. It will make your website faster for users, and reduce the bandwidth required - better for the planet.

### Serverless e.g. Azure Functions / Amazon Web Services (AWS) Lambdas / Edge Functions
Serverless functions are great as they completely abstract away the underlying infrastructure from you and let you focus on the code itself. They’re designed to be short-lived and scalable, and they’re a good fit for things like API endpoints, processing tasks, and that kind of thing. It’s another example of technology where you don’t have to be worrying about maintaining servers / VMs. The cloud provider can worry about balancing load behind the scenes - and they’re probably better at that than you are.