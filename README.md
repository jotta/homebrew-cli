# Jottacloud CLI homebrew 

Requires macOS 10.12 (Sierra) or higher.

### Installing

- tap the repo:

```brew tap jotta/cli```

- install the binaries:

```brew install jotta-cli```

- (optional) start jottad as a service on login:

```brew services start jotta-cli```

### Updating

- run update and upgrade (could also be done without `jotta-cli`
  as homebrew will update all packages)

```brew update && brew upgrade jotta-cli```

_NB_: remember to restart jotta-cli service after upgrade:

```brew services restart jotta-cli```


### Unstable version

see https://github.com/jotta/jotta-cli-issues#using-unstable-with-brew

