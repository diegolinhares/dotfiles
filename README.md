# dotfiles

These are the files and scripts I use to set up an Apple Silicon Mac. Everything starts with `./bin/bootstrap`.

## Install

The only prerequisite is Git from the macOS Command Line Tools. If Git is missing, run `xcode-select --install` first.

```sh
git clone https://github.com/diegolinhares/dotfiles.git ~/dotfiles
cd ~/dotfiles

./bin/bootstrap --dry-run --agents codex,cursor
./bin/bootstrap --yes --agents codex,cursor
```

`--agents` accepts `codex`, `cursor`, `claude-code`, and `opencode`. Omit it if you do not want to install skills during bootstrap.

The setup includes:

- current global Ruby, Node, and Yarn versions, plus the command-line tools and language servers declared in [`mise.toml`](mise.toml)
- 1Password, OrbStack, Chrome, Orca, Ghostty, AeroSpace, Ice, and Maccy
- the JetBrains Mono Nerd Font used by Ghostty
- Zsh, Git, SSH, Ghostty, AeroSpace, Atuin, Starship, and fnox configuration
- daily Homebrew updates with upgrades, cleanup, and failure notifications
- OrbStack at login and the `orbstack` Docker context by default
- Dock, Finder, keyboard, and trackpad defaults

The bootstrap supports Apple Silicon Macs only.

## Tool versions

The bootstrap copies the root `mise.toml` to `~/.config/mise/config.toml`. Its `latest` Ruby, Node, and Yarn entries act as global fallbacks in every directory and worktree. A project's own `mise.toml` still takes precedence.

Use the wrapper to update mise, resolve the global `latest` versions, and remove old managed versions that no tracked project needs:

```sh
dotfiles update --dry-run
dotfiles update
```

The cleanup only removes managed versions. Project versions and unmanaged tools are left alone.

## Agent skills

Skills live in [`config/skills.tsv`](config/skills.tsv), separate from any one agent. Install them for the tools you use:

```sh
./bin/setup-skills --agents codex,cursor
./bin/setup-skills --agents claude-code,opencode
./bin/setup-skills --agents codex,cursor --dry-run
```

Running `./bin/setup-skills` in a terminal opens an interactive picker. To add a skill, update the manifest and run the installer again.

## Company secrets

Secret values stay in 1Password. The `company` command creates local fnox profiles containing references, then loads the selected profile only for the process that needs it. Profiles are stored under `~/.config/company` with private permissions and are not committed.

Running `company add` opens an interactive setup. The flag-based form is useful when the profile is already known:

```sh
company add acme \
  --account acme.1password.com \
  --vault Employee \
  --default AWS_DEFAULT_REGION=us-east-2 \
  AWS_ACCESS_KEY_ID=AWS/AWS_ACCESS_KEY_ID \
  AWS_SECRET_ACCESS_KEY=AWS/AWS_SECRET_ACCESS_KEY

company check acme
company run acme -- aws sts get-caller-identity
company run acme -- rails server
company shell acme
```

When I start work with another company, I create another profile. The environment variable names can stay the same because each command chooses which account, vault, and item to use.

## SSH and signed commits

Private SSH keys also stay in 1Password. Enable the SSH agent and CLI integration in `1Password > Settings > Developer`, then create or import an SSH Key item. Add its public key to GitHub as an authentication key and check the connection:

```sh
ssh-add -l
ssh -T git@github.com
```

`setup-git-signing` uses the same public key for commit and tag signing. Without flags, it opens an interactive setup and can register the key as a GitHub signing key.

```sh
setup-git-signing
git verify-commit HEAD
```

GitHub treats authentication and signing as separate uses, so the public key must appear once under each type. Machine-specific signing files remain under `~/.config/git`, outside this repository.

## Maintenance

```sh
dotfiles doctor
dotfiles update --dry-run
dotfiles update
mise bootstrap status
mise bootstrap --dry-run
mise run check
```

`dotfiles doctor` is read-only. It checks the local tools, Homebrew updates, FileVault, the firewall, 1Password SSH and signing, OrbStack, company profiles, disk space, Time Machine, and the repository state.

## Repository layout

- [`mise.toml`](mise.toml) is the machine manifest.
- [`files/home`](files/home) contains the managed config files.
- [`bin`](bin) contains bootstrap and maintenance commands.
- [`config/skills.tsv`](config/skills.tsv) lists the agent skills to install.
