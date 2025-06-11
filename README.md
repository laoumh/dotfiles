# Dotfiles

Repositório de arquivos de configuração.

## Instalação e Uso

```sh
stow .
```

### Repositório

```sh
git clone git@github.com:laoumh/dotfiles.git "$HOME/dotfiles"
```

### Scripts

A pasta `scripts` contém scripts de instalação e configuração que não são adicionados
via `stow`.

Executar scripts nessa pasta conforme necessidade.

### `stow`

```sh
sudo nala install stow
```

`stow` "instala" os pacotes do repositório no diretório alvo,
criando symlinks do alvo para os arquivos do repositório.
`stow` é um comando seguro, no sentido de que não sobrescreve arquivos no alvo.

#### Conceitos relevantes

- "Pacote" é a estrutura de arquivos que são pensados como uma unidade
- "Diretório stow" é a raiz da árvore de diretório contendo os arquivos de interesse.
  - Padrão: se omitido, é o diretório atual
- "Diretório alvo" é a raiz do diretório onde os arquivos serão instalados
  - Padrão: se omitido, é o pai do diretório atual
- "Imagem" é a estrutura de diretórios

#### Comandos úteis

- `stow . [--target=<dir-alvo>]` instala o pacote do diretório atual no diretório alvo.
Se omitido, instala no diretório pai do atual.
- `stow . --ignore=<sub-dir (regex)>` não instala o subdiretório que casa com regex.
Útil quando se quer omitir um pacote, por exemplo `guake` em uma VM.
- `stow [pacote] -D` deleta (remove symlinks) o pacote especificado do alvo.
Útil para remover links de arquivos que foram excluídos do repositório.

#### Convenção `dot-`

A flag `--dotfiles` mapeia arquivos prefixados com `dot-` para `.` no alvo.
Ex: `dot-bashrc` &rarr; `.bashrc`.

Isso evita criar repositório de arquivos ocultos.

Obs: há bug antes da versão 2.4 que não processa corretamente diretórios iniciados
em `dot-`. Essa versão ainda não está disponível no repositório Debian, portanto
no momento salvar diretórios ocultos iniciando com `.<dir>` mesmo.

#### Docs

Ver  `info stow`. Em particular as seções:

- "Ignore Lists", sobre o arquivo `.stow-local-ignore`,
que permite ignorar certos arquivos (PERL regex)
- "Resource Files", sobre o arquivo `.stowrc`, que permite configurar opções-padrão

### Guake

Para salvar as preferências atuais em um arquivo:

```sh
guake --save-preferences=guake.cfg
```

Para carregar as preferências salvas (foi adicionado automaticamente ao `.bashrc`):

```sh
guake --restore-preferences=guake.cfg
```

## Referências

[Github Dotfiles guide](http://dotfiles.github.io/)

[Stow has forever changed the way I manage my dotfiles](https://www.youtube.com/watch?v=y6XCebnB9gs)

