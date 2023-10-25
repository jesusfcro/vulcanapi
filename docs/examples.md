# Examples

All of these examples will require [authentication](authentication.md) to the Vulcan API. The authentication token will be referenced as `$token`, which is ment to be replaced by your actual Vulcan API token.

If you need any help with the API or miss any relevant examples or even features, don't hesitate to contact us via Slack at [#vulcan](https://sch-chat.slack.com/messages/C90P83LAY) or via email at [vulcan@adevinta.com](mailto:vulcan@adevinta.com).


## How do I get information about my user?

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" "https://www.vulcan.mpi-internal.com/api/v1/profile"
```

## How do I list which teams I belong to?

This requires that you know your `$user_id` and replace it on the request below.

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" "https://www.vulcan.mpi-internal.com/api/v1/users/$user_id/teams"
```

## How do I list the members of a team?

This requires that you know the team (with `$team_id`) that you want to list the members of.

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" "https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/members"
```

## How do I add a member to a team?

This requires that you are a owner of the team (with `$team_id`) and that you know the email (with `$email`) of the user (existing or not) that you want to add to the team.

The role (specified as `$role`) can be either "member" or "owner".

```
curl --data "{\"email\": \"$email\", \"role\": \"$role\"}" -H "Content-Type: application/json" -H "Authorization: Bearer $token" "https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/members"
```

## How do I list the assets of a team?

This requires that you are a member of the team (with `$team_id`).

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" "https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/assets"
```

## How do I add assets to a team?

This requires that you are a owner of the team (with `$team_id`).

The assets endpoint accepts a collection of assets. This means that you can create
multiple assets at once. When creating assets you are required to inform at least
the `identifier` field, but you can also specify the asset `type` field.

If you leave the asset `type` field empty, then Vulcan API will determine the asset
`type` in a smart way. Notice that this can result in the creation of more than one
asset for a single entry (e.g. `adevinta.com` will result in two assets: `DomainName`
and `Hostname`).

On the other hand if you specify the asset `type` field, then Vulcan will create a single asset using this information. Be careful because validity is not checked for assets created this way (e.g. you can create an asset with `identifier` `1.1.1.1` and `type` `Hostname`).

* `$identifier`: The actual domain name, hostname, IP address or AWS account number. (i.e: `adevinta.com`, `54.1.2.3`, `54.54.0.0/16`, `arn:aws:iam::999999999999:root`)
* `$type`: Can be `DomainName`, `Hostname`, `IP`, `IPRange`, `AWSAccount`, `WebAddress`, `GitRepository` and `DockerImage`.

Examples for endpoint `POST /<team_id>/assets`:

Create a single Hostname.
```
curl --data "{\"assets\":[{\"identifier\": \"$hostname\", \"type\": \"Hostname\"}]}" -H "Content-Type: application/json" -H "Authorization: Bearer $token" "https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/assets"
```

Create three IP addresses.
```
curl --data "{\"assets\":[{\"identifier\": \"$ip1\", \"type\": \"IP\"}, {\"identifier\": \"$ip2\", \"type\": \"IP\"}, {\"identifier\": \"$ip3\", \"type\": \"IP\"}]}" -H "Content-Type: application/json" -H "Authorization: Bearer $token" "https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/assets"
```

Create a docker image.
```
curl --data "{\"assets\":[{\"identifier\": \"containers.mpi-internal.com/one-team/centos:latest\", \"type\": \"DockerImage\"}]}" -H "Content-Type: application/json" -H "Authorization: Bearer $token" "https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/assets"
```

Create assets for two identifiers without specifying `type`.
In this case the API will determine the asset types.
```
curl --data "{\"assets\":[{\"identifier\": \"$identifier\"}, {\"identifier\": \"$identifier2\"}]}" -H "Content-Type: application/json" -H "Authorization: Bearer $token" "https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/assets"
```

## How do I list the asset groups of a team?

This requires that you are a member of the team (with `$team_id`).

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer $token" "https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/groups"
```

## How do I add an asset to a group?

This requires that you are a owner of the team (with `$team_id`).

This also requires you to know the following information:

* `$asset_id`: The ID of the asset that you want to add to the group.
* `$group_id`: The ID of the group that you want to add the asset to.

```
curl --data "{\"asset_id\": \"$asset_id\"}" -H "Content-Type: application/json" -H "Authorization: Bearer $token" "https://www.vulcan.mpi-internal.com/api/v1/teams/$team_id/groups/$group_id/assets"
```
