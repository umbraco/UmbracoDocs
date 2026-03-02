---
description: >-
  Learn how to authenticate and ingest content into Umbraco Compose using the
  Ingestion API, including prerequisites, endpoint format, and links to API
  docs.
---

# Ingestion

## Authenticating

To authenticate to the Ingestion API, you need an API key with the `ingestion` scope. You can read more about [generating and using API keys here](../../getting-started/access-control.md).

## Ingesting data

There are two ways to use the Ingestion API to store your content in Compose: Ingestion Function and RESTful Ingestion.

If your source application supports webhooks, then you can use a managed [Ingestion Function](functions.md) to transform their payload into a format that Compose understands.

If you are creating a custom integration to Compose, you can use the standard [RESTful Ingestion](restful-ingestion.md) endpoint.

## Prerequisites

In addition to an API key, to ingest data into your Compose project, you also need an [Environment](../../content-orchestration/environments.md) with a [Collection](../../content-orchestration/collections.md).

The path to the RESTful Ingestion API endpoint is as follows:

`https://ingest.{region}.umbracocompose.com/{project-alias}/{environment-alias}/{collection-alias}`

## API Documentation

Check out the [Ingestion API Documentation](https://apidocs.umbracocompose.com/?api=ingestion-api) for an overview and examples on how to make calls.
