---
description: Use .NET health probe endpoints to monitor whether your Umbraco application is alive and ready to serve requests.
---

# Health Probes

.NET includes a built-in [health checks](https://learn.microsoft.com/en-us/dotnet/architecture/microservices/implement-resilient-applications/monitor-app-health) middleware that exposes HTTP endpoints reporting whether an application is alive and functioning. Orchestrators, load balancers, and monitoring tools poll these endpoints to decide if an instance should receive traffic.

{% hint style="info" %}
These endpoints are infrastructure-level HTTP probes used by orchestrators and load balancers. They are different from the [Health Check dashboard](../../../extending/health-check/) in the backoffice, which validates Umbraco and website-specific best practices.
{% endhint %}

## Overview

Umbraco builds on this middleware and exposes two health probe endpoints that reflect the current runtime state. These endpoints are available in Umbraco 17.3 and later.

## Endpoints

| Endpoint | Behavior |
|---|---|
| `GET /umbraco/api/health/live` | Returns HTTP 200 if the process is responding. No checks run. |
| `GET /umbraco/api/health/ready` | Returns HTTP 200 when the site is running normally. Returns HTTP 503 when the site is not ready, for example, during startup or an unattended upgrade. |

Both endpoints are anonymous and bypass the maintenance-page re-route active during upgrades.

## Configuring health probes

Use the endpoints above to configure liveness and readiness probes on your hosting platform.

Examples for some common hosting environments are shown below.

### Azure App Service

In the Azure Portal, navigate to your App Service and open **Monitoring > Health check**. Set the path to:

```
/umbraco/api/health/ready
```

Azure uses this path to determine whether the instance is healthy and should receive traffic.

### Kubernetes

```yaml
livenessProbe:
  httpGet:
    path: /umbraco/api/health/live
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10
readinessProbe:
  httpGet:
    path: /umbraco/api/health/ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10
```

### Docker Compose

```yaml
services:
  umbraco:
    image: my-umbraco-app
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/umbraco/api/health/ready"]
      interval: 10s
      timeout: 5s
      retries: 3
      start_period: 30s
```

### Load balancers

Use the readiness probe path (`/umbraco/api/health/ready`) as the health check URL for your load balancer. The endpoint returns HTTP 503 while the site is upgrading. This causes the load balancer to stop routing traffic to that node until the upgrade completes. For more details on load-balanced setups, see [Umbraco in Load Balanced Environments](load-balancing/).

## Related

* [Upgrade Unattended](../upgrading/upgrade-unattended.md)
* [Umbraco in Load Balanced Environments](load-balancing/README.md)
* [Running Umbraco in Docker](running-umbraco-in-docker.md)
