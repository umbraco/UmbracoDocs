# Security and bots

### Block requests from bad bots	
Use a robots.txt file to block parts of your site you don’t want bots to access, but also monitor access from bots using your logs and other tooling. They’ll be using up precious compute resources by browsing your site. If you see lots of traffic coming from unknown and obvious bots, block them.

### DDoS  protection
Distributed Denial of Service (DDoS) attacks range from annoying to planetary in terms of volume. They should be blocked as early up the chain as possible - use services like Cloudflare, Akamai, Azure Distributed Denial of Service (DDoS) Protection etc to black hole these types of quests before they get anywhere near your application stack. If you don’t, they’ll be using up precious bandwidth and computation resources - all of which use energy.