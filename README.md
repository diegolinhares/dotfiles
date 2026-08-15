# dotfiles

Setup reproduzível para macOS em Apple Silicon, orquestrado pelo mise.

## Nova máquina

O único pré-requisito é o Git fornecido pelas Command Line Tools do macOS.

```sh
git clone https://github.com/diegolinhares/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bin/bootstrap --dry-run --agents codex,cursor
./bin/bootstrap --yes --agents codex,cursor
```

O bootstrap instala ou configura:

- mise 2026.8.6 ou superior;
- Ruby 4.0.1, Node 22.20.0, Yarn 1.22.22 e mprocs 0.9.2 como versões globais;
- tmux, ripgrep, fd, fzf, jq, bat, eza, zoxide, Atuin, lazygit, lazydocker, Yazi, Starship, GitHub CLI, Neovim e Git LFS;
- 1Password, OrbStack, Google Chrome, Orca, Ghostty, AeroSpace, Ice e Maccy;
- Homebrew com atualização automática diária, upgrade, limpeza e notificação em caso de erro;
- OrbStack iniciado no login e como contexto padrão do Docker;
- configurações de Zsh, Git, SSH, Ghostty, AeroSpace, Atuin e Starship;
- defaults de Dock, Finder, teclado e trackpad.

PostgreSQL e Redis não fazem parte deste setup. Worktrunk e configurações de Codex ou Claude também não são gerenciados aqui.

## Mise global e projetos

O bootstrap copia `mise.toml` para `~/.config/mise/config.toml`. Essas versões valem em qualquer diretório e worktree. Um `mise.toml` pertencente a um projeto pode substituir somente as versões daquele projeto.

## Skills

As skills ficam declaradas em `config/skills.tsv`. O agente é escolhido na execução:

```sh
./bin/setup-skills --agents codex,cursor
./bin/setup-skills --agents claude-code,opencode
./bin/setup-skills --agents codex,cursor --dry-run
```

Para adicionar outra skill depois, inclua a fonte e os nomes no manifesto e execute novamente o instalador.

O conjunto inclui React, Motion, Remotion, Playwright, Vitest, TLC Spec Driven, Impeccable, Firecrawl, shadcn, Context7, Humanizer, Exa e práticas modernas de frontend.

## Segredos e empresas

Valores secretos ficam no 1Password. O repositório e os perfis locais guardam apenas referências `op://`.

```sh
company add empresa \
  AWS_ACCESS_KEY_ID=op://Empresa/AWS/access-key-id \
  AWS_SECRET_ACCESS_KEY=op://Empresa/AWS/secret-access-key \
  GOOGLE_API_KEY=op://Empresa/Google/api-key

company run empresa -- rails server
company shell empresa
company list
```

Ao entrar em outra empresa, crie os itens no cofre correto do 1Password e adicione um novo perfil. Os mesmos nomes de variáveis podem apontar para itens diferentes porque cada execução escolhe explicitamente o perfil.

Os perfis são salvos em `~/.config/company` com permissão privada e nunca entram no Git.

## SSH

As chaves privadas não são copiadas pelo dotfiles. Ative o SSH Agent nas configurações do aplicativo 1Password e adicione as chaves ao cofre. O arquivo SSH gerenciado aponta para o socket do 1Password e preserva a integração do OrbStack.

## Manutenção

```sh
mise run check
mise bootstrap status
mise bootstrap --dry-run
mise bootstrap --yes
mise upgrade
```

O Homebrew atualiza diariamente por meio de `domt4/autoupdate`. As versões fixadas pelo mise só mudam quando `mise.toml` for atualizado.
