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
- Ruby, Node e Yarn em suas versões estáveis mais recentes, além de mprocs 0.9.2 como padrões globais;
- tmux, ripgrep, fd, fzf, jq, bat, eza, zoxide, Atuin, lazygit, lazydocker, Yazi, Starship, fnox, GitHub CLI, Neovim, Git LFS, dua, btop, fastfetch, tldr, Mole, usage e gum;
- servidores de linguagem para TypeScript, JavaScript, React e Ruby, com TypeScript Language Server, oxlint, ruby-lsp e RuboCop LSP;
- 1Password, OrbStack, Google Chrome, Orca, Ghostty, AeroSpace, Ice e Maccy;
- Homebrew com atualização automática diária, upgrade, limpeza e notificação em caso de erro;
- OrbStack iniciado no login e como contexto padrão do Docker;
- configurações de Zsh, Git, SSH, Ghostty, AeroSpace, Atuin e Starship;
- defaults de Dock, Finder, teclado e trackpad.

PostgreSQL e Redis não fazem parte deste setup. Worktrunk e configurações de Codex ou Claude também não são gerenciados aqui.

O setup instala `font-jetbrains-mono-nerd-font` pelo Homebrew. O Ghostty usa a família monoespaçada `JetBrainsMono Nerd Font Mono`, necessária para os ícones do terminal.

## Mise global e projetos

O bootstrap copia `mise.toml` para `~/.config/mise/config.toml`. Ruby, Node e Yarn usam `latest` como fallback em qualquer diretório e worktree. Um `mise.toml` pertencente a um projeto substitui somente as versões daquele projeto.

Para atualizar o mise, resolver as globais `latest` e remover versões sem uso:

```sh
dotfiles update --dry-run
dotfiles update
dotfiles update --yes
```

O comando atualiza sem remover imediatamente as versões anteriores. Em seguida, o prune limitado aos runtimes globais e LSPs gerenciados remove apenas versões que não são a mais recente pedida por nenhuma configuração rastreada ou tool stub. Assim, uma versão declarada por um projeto continua instalada, e ferramentas avulsas como Claude, Bun ou agent-browser ficam fora da limpeza. Use o dry-run antes quando quiser revisar a lista.

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

Valores secretos ficam no 1Password. O fnox resolve as referências somente ao executar um processo, sem colocar os segredos no shell global. O repositório e os perfis locais guardam apenas referências.

Para credenciais AWS pessoais, crie um item `AWS` do tipo `API Credential` no cofre privado da empresa, com os campos `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY`. Escolha a região explicitamente para cada perfil; ela pode variar por empresa, conta ou projeto e não precisa ser armazenada como segredo.

```sh
company add empresa \
  --account empresa.1password.com \
  --vault Employee \
  --default AWS_DEFAULT_REGION=us-east-2 \
  AWS_ACCESS_KEY_ID=AWS/AWS_ACCESS_KEY_ID \
  AWS_SECRET_ACCESS_KEY=AWS/AWS_SECRET_ACCESS_KEY

company check empresa
company run empresa -- aws sts get-caller-identity
company run empresa -- rails server
company shell empresa
company list
```

Executar `company add` sem argumentos abre um assistente com gum para escolher conta, cofre e tipo de credencial. O formato com flags continua disponível para automações e CI.

O formato também aceita referências completas como `KEY=op://Vault/Item/field`. Ao entrar em outra empresa, crie os itens no cofre correto do 1Password e adicione um novo perfil. Os mesmos nomes de variáveis podem apontar para itens diferentes porque cada execução escolhe explicitamente o perfil.

Os perfis fnox são salvos em `~/.config/company` com permissão privada e nunca entram no Git. A configuração segue o mesmo modelo do Nate, mas conta e cofre não ficam fixados no dotfiles. O Shell Plugin da AWS do 1Password é opcional e atende comandos AWS diretamente; o fnox continua sendo usado para Rails, testes, agentes e outros processos.

## SSH

As chaves privadas não são copiadas pelo dotfiles. No aplicativo 1Password, ative `Settings > Developer > Use the SSH agent` e a integração da CLI. O arquivo SSH gerenciado aponta para o socket do 1Password e preserva a integração do OrbStack.

Para criar uma chave Ed25519 diretamente no 1Password:

```sh
op item create \
  --account empresa.1password.com \
  --vault NomeDoCofre \
  --category ssh \
  --title GitHub
```

Se a importação de uma chave OpenSSH antiga for rejeitada pelo 1Password, gere uma nova diretamente com o comando acima e mantenha a antiga como fallback até concluir os testes. Copie somente a chave pública:

```sh
op item get GitHub \
  --account empresa.1password.com \
  --vault NomeDoCofre \
  --format json \
  | jq -r '.fields[] | select(.id == "public_key") | .value' \
  | pbcopy
```

Cadastre-a no GitHub em `Settings > SSH and GPG keys` como `Authentication Key`. Confirme que a autenticação usa o agente:

```sh
ssh-add -l
ssh -T git@github.com
```

Para assinar commits e tags com a mesma chave:

```sh
setup-git-signing

setup-git-signing \
  --account empresa.1password.com \
  --vault NomeDoCofre \
  --item GitHub \
  --github \
  --github-title "Mac - 1Password Signing"
```

Sem argumentos, o comando abre um assistente com gum e pergunta se a chave também deve ser registrada como `Signing Key` no GitHub. O formato com flags permanece disponível para automação.

O comando lê somente a chave pública, configura o executável de assinatura do 1Password e registra a chave como `Signing Key` no GitHub. O GitHub exige que a mesma chave seja cadastrada separadamente para autenticação e assinatura. A primeira execução pode pedir autorização para acrescentar o escopo `admin:ssh_signing_key` ao GitHub CLI.

A configuração específica da máquina fica em `~/.config/git/signing.conf` e a lista usada para verificação local em `~/.config/git/allowed_signers`, ambas com permissão privada e fora deste repositório. Um commit ou tag solicitará autorização pelo 1Password e Touch ID. Para conferir:

```sh
git log --show-signature -1
git verify-commit HEAD
```

Depois que a autenticação e a assinatura passarem nesses testes e a nova `Signing Key` estiver cadastrada no GitHub, remova qualquer `IdentityFile` da chave antiga em `~/.ssh/config` e teste o agente novamente antes de arquivar ou excluir o par antigo. O bootstrap nunca apaga chaves privadas automaticamente.

## Manutenção

```sh
dotfiles doctor
dotfiles update --dry-run
mise run check
mise bootstrap status
mise bootstrap --dry-run
mise bootstrap --yes
mise upgrade
```

`dotfiles doctor` faz uma verificação somente de leitura das ferramentas, atualização automática, FileVault, firewall, agente SSH e assinatura pelo 1Password, OrbStack, perfis de empresa, espaço em disco, Time Machine e estado do repositório. Ele nunca executa limpezas do Mole.

Quando há um terminal interativo, gum fornece entradas, escolhas, confirmações, indicadores de progresso e resumos estilizados. Em automações ou redirecionamentos, os scripts mantêm saída de texto e exigem flags explícitas.

O Homebrew atualiza diariamente por meio de `domt4/autoupdate`. As versões fixadas pelo mise só mudam quando `mise.toml` for atualizado; as entradas `latest` avançam ao executar `dotfiles update`.
