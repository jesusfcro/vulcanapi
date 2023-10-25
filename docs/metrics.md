# Metrics

This page describes how to retrieve security metrics for your teams from the Vulcan API.

If you have trouble executing the sample queries, you can check out the [examples](examples.md) for more details. If you need any additional help retrieving metrics, don't hesitate to contact us via Slack at [#vulcan](https://sch-chat.slack.com/messages/C90P83LAY) or via email at [vulcan@adevinta.com](mailto:vulcan@adevinta.com).

## Preparation

Obtain a Vulcan API [authentication](authentication.md) token. The token will be referenced as `$token`.

Find out your `$user_id`:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/profile"
```

Find out which teams your user belongs to in Vulcan:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/users/$user_id/teams"
```

From now on your team identifier will be referenced as `$team_id`.

## Metrics

### MTTR

The MTTR (or mean time to remediate) is a metric that describes the mean number of hours that pass between a vulnerability is identified and fixed. The Vulcan API reports this metric by severity, since the expectation is that higher severity vulnerabilities are resolved faster. The total MTTR is also returned, and represents the MTTR of all the vulnerabilities regardless of severity.

The MTTR for a particular team can be retrieved with the following query:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/stats/mttr"
```

### Open Issues

Open issues represent the number of vulnerabilities that have been identified and are not yet fixed. The numbers are returned organized by severity.

The open issues for a particular team can be retrieved with the following query:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/stats/open"
```

This metric can be filtered to identify the number of issues that were open at a previous date.

See this example to retrieve the issues that were already identified at the start of the year:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/stats/open?atDate=2019-01-01"
```

It is also possible to filter the metric according to when the issues were identified.

See this example to retrieve the issues that were identified during the first quarter of the year:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/stats/open?minDate=2019-01-01&maxDate=2019-03-31"
```

### Fixed Issues

Fixed issues represent the number of vulnerabilities that have been identified and are already fixed. The numbers are returned organized by severity.

The fixed issues for a particular team can be retrieved with the following query:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/stats/fixed"
```

This metric can be filtered to identify the number of issues that were fixed at a previous date.

See this example to retrieve the issues that were already fixed at the start of the year:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/stats/fixed?atDate=2019-01-01"
```

It is also possible to filter the metric according to when the issues were fixed.

See this example to retrieve the issues that were fixed during the first quarter of the year:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/stats/fixed?minDate=2019-01-01&maxDate=2019-03-31"
```
