# buildpack-mimalloc

[mimalloc](https://microsoft.github.io/mimalloc/) is a general purpose malloc
implementation. This buildpack makes it easy to install and use mimalloc on
Heroku and compatible platforms.

## Install

```console
heroku buildpacks:add --index 1 https://github.com/gaffneyc/buildpack-mimalloc.git
git push heroku master
```

## Made possible by Dead Man's Snitch

Continued development and support of the mimalloc buildpack is sponsored by
[Dead Man's Snitch](https://deadmanssnitch.com).

Ever been surprised that a critical recurring job was silently failing to run?
Whether it's backups, cache clearing, sending invoices, or whatever your
application depends on, Dead Man's Snitch makes it easy to
[monitor heroku scheduler](https://deadmanssnitch.com/docs/heroku) tasks or to add
[cron job monitoring](https://deadmanssnitch.com/docs/cron-job-monitoring) to
your other services.

Get started for free today with [Dead Man's Snitch on Heroku](https://elements.heroku.com/addons/deadmanssnitch)

## Usage

### Recommended

Set the MIMALLOC_ENABLED config option to true and mimalloc will be used for
all commands run inside of your dynos.

```console
heroku config:set MIMALLOC_ENABLED=true
```

### Per dyno

To control when mimalloc is configured on a per dyno basis use
`mimalloc.sh <cmd>` and ensure that MIMALLOC_ENABLED is unset.

Example Procfile:
```yaml
web: mimalloc.sh bundle exec puma -C config/puma.rb
```

## Configuration

### MIMALLOC_ENABLED

Set this to true to automatically enable mimalloc.

```console
heroku config:set MIMALLOC_ENABLED=true
```

To disable mimalloc set the option to false. This will cause the application to
restart disabling mimalloc.

```console
heroku config:set MIMALLOC_ENABLED=false
```

### MIMALLOC_VERSION

Set this to select or pin to a specific version of mimalloc. The default is to
use the latest stable version if this is not set. You will receive an error
mentioning tar if the version does not exist.

**Default**: `2.2.4`

**note:** This setting is only used during slug compilation. Changing it will
require a code change to be deployed in order to take affect.

```console
heroku config:set MIMALLOC_VERSION=2.2.4
```

## Development

Run `make console` to start up a shell in a test build environment that mimic's
Heroku's build phase.
