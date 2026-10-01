# Convox Exec Action
This Action runs a [One-off Command](https://docs.convox.com/management/one-off-commands) in a running process. The command runs in the code of the release that is currently promoted, which makes this action a fit for post-deploy commands. To run a command such as a migration against a new release before promoting it, use [Run](https://github.com/convox/action-run) with its `release` input.

> **Note:** This action automatically allocates a pseudo-TTY for proper output streaming and color support in GitHub Actions runners.

## Inputs
### `rack`
**Required** The name of the [Convox Rack](https://docs.convox.com/introduction/rack) containing the app you wish to run the command against
### `app`
**Required** The name of the [app](https://docs.convox.com/deployment/creating-an-application) you wish to run the command against
### `service`
**Required** The name of the [service](https://docs.convox.com/application/services) to run the command against
### `command`
**Required** The command you wish to run

## Example usage
```
steps:
- name: login
  id: login
  uses: convox/action-login@v2
  with:
    password: ${{ secrets.CONVOX_DEPLOY_KEY }}

- name: deploy
  id: deploy
  uses: convox/action-deploy@v2
  with:
    rack: staging
    app: myapp

- name: clear cache
  id: clear-cache
  uses: convox/action-exec@v1
  with:
    rack: staging
    app: myapp
    service: web
    command: 'rails tmp:cache:clear'
```

## Convox CLI version
This action installs the latest Convox CLI release when its image is built, so the action's version tag does not pin the CLI. On GitHub-hosted runners that happens on every run. On a self-hosted runner with a persistent Docker daemon, the CLI stays at the version cached in that daemon until its build cache is pruned.
