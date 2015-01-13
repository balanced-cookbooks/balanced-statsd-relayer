# DESCRIPTION

Chef cookbook to install a local statsd relayer that accepts TCP packets locally (via 127.0.0.1) and repeats the packets via TCP.

## WHAT

The [Balanced Bakery](https://github.com/balanced-ops/bakery) produces an package artifact that's required for this cookbook.

Here's the recipe: https://github.com/balanced-ops/bakery/blob/master/ansible/statsd.yml

## HOW TO OVERRIDE

By default, the package auto relays to 'internal-metrics.vandelay.io'. If it is
required to change this, just update the appropriate attribute to overwrite the
configuration.