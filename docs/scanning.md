# Scanning

The Vulcan API does not currently allow users to trigger scans on demand. However, you can use the API to add new assets to be scanned as part of periodic scans for your team.

## Scanning new assets

Periodic scans will currently only scan assets that are in the `Default` or `Sensitive` asset groups. This allows you to specify if an asset should be scanned normally, by placing it in the `Default` group, or if special care should be taken, by placing it in the `Sensitive` group. **Every new asset you create is added to the `Default` group by default**.

You can see how to add an asset to a group in the [examples](examples/#how-do-i-add-an-asset-to-a-group) section.

### Default group

This is the current default behavior for all assets in Vulcan. Assets in the `Default` group are scanned following a recommended policy defined by the Security Team, which tries to be as safe as possible while maximizing vulnerability detection.

### Sensitive group

Assets in the `Sensitive` group are scanned with special care, avoiding checks that may in rare cases temporarily affect the performance of scanned assets. We do not recommend to add assets to this group unless special circumstances require it.

## What checks are executed against my assets?

The periodic scans policy ensures that for every scanned asset only the appropriate checks are run depending on its `type`. Every [check](https://github.com/adevinta/vulcan-checks/tree/master/cmd) in Vulcan has a manifest file where it specifies the supported asset types.

For example, to determine which checks are run against a `Hostname`:

```
$ grep -r Hostname */manifest.toml
vulcan-certinfo/manifest.toml:AssetTypes = ["Hostname"]
vulcan-drupal/manifest.toml:AssetTypes = ["Hostname"]
vulcan-exposed-amt/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-exposed-bgp/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-exposed-db/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-exposed-files/manifest.toml:AssetTypes = ["Hostname"]
vulcan-exposed-ftp/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-exposed-hdfs/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-exposed-http/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-exposed-memcached/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-exposed-rdp/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-exposed-router-ports/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-exposed-services/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-exposed-ssh/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-exposed-varnish/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-gozuul/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-heartbleed/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-http-headers/manifest.toml:AssetTypes = ["Hostname"]
vulcan-ipv6/manifest.toml:AssetTypes = ["Hostname"]
vulcan-lucky/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-masscan/manifest.toml:AssetTypes = ["Hostname", "IP", "IPRange"]
vulcan-nessus/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-retirejs/manifest.toml:AssetTypes = ["Hostname"]
vulcan-s3-takeover/manifest.toml:AssetTypes = ["Hostname"]
vulcan-smtp-open-relay/manifest.toml:AssetTypes = ["Hostname", "IP"]
vulcan-tls/manifest.toml:AssetTypes = ["Hostname"]
vulcan-wpscan/manifest.toml:AssetTypes = ["Hostname"]
```

But consider that there are some checks that are not included in the periodic scans policy (e.g. `vulcan-masscan`). You can check exceptions in the definition of the API global programs in [GitHub](https://github.com/adevinta/vulcan-api/blob/master/pkg/api/store/global/policies.go#L43).

Be aware that currently `IPRange` assets are not scanned in periodic scans.
