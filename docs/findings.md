# Findings

This page describes how to query security findings for your teams from the Vulcan API.

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

## Findings

### Total Findings

The total findings are all findings that Vulcan has detected for your team, which may or may not have already been fixed. You may want to retrieve the total findings to identify which assets have been affected by a particular issue.

The total findings for a particular team can be retrieved with the following query:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/findings"
```

This query (as well as the ones below) can be filtered by the severity score of the findings.

See this example to retrieve only the findings that fall in the high and critical severity categories:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/findings?minScore=7.0"
```

See this example to retrieve only the findings that fall in the medium severity category:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/findings?minScore=4.0&maxScore=6.9"
```

### Open Findings

Open findings are those findings that Vulcan has detected for your team and have not yet been fixed. Those findings will be marked as fixed once Vulcan scans the affected assets again and does not detect the findings in question.

The open findings for a particular team can be retrieved with the following query:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/findings?status=OPEN"
```

This query can be filtered to identify the findings that were already open at a previous date.

See this example to retrieve the findings that were already identified at the start of the year:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/findings?status=OPEN&atDate=2019-01-01"
```

It is also possible to filter the query according to when the findings were identified.

See this example to retrieve the findings that were identified during the first quarter of the year:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/findings?status=OPEN&minDate=2019-01-01&maxDate=2019-03-31"
```

### Fixed Findings

Fixed findings are those findings that Vulcan has detected for your team and have already been fixed. Those findings have been marked as fixed because they were once detected by Vulcan but were not found on subsequent scans.

The fixed findings for a particular team can be retrieved with the following query:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/findings?status=FIXED"
```

This query can be filtered to identify the findings that were already fixed at a previous date.

See this example to retrieve the findings that were already fixed at the start of the year:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/findings?status=FIXED&atDate=2019-01-01"
```

It is also possible to filter the query according to when the findings were fixed.

See this example to retrieve the findings that were fixed during the first quarter of the year:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/findings?status=FIXED&minDate=2019-01-01&maxDate=2019-03-31"
```

## Pagination

All of the queries explained above will return paginated results in chronological order. You can use the following parameters to navigate them:

- **size**: Indicates the number of findings in each page.
- **page**: Indicates the page number to query. Starts at 1.

In response, the API response will contain the following pagination information:

- **limit**: Indicates the number of findings in that page.
- **offset**: Indicates the number of findings on previous pages.
- **total**: Indicates the total number of findings.
- **more**: Indicates if there are more pages.

See this example to retrieve the first 50 findings:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/findings?size=50"
```

See this example to retrieve the findings from positions 200 to 300:

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" \
"https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/findings?size=100&page=3"
```
