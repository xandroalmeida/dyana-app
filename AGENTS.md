# AGENTS.md

## Contexto do Projeto

Dyana e uma PWA mobile-first em Flutter Web para meditacao simples. O escopo atual e intencionalmente enxuto:

- timer de sessao de meditacao;
- duracoes pre-definidas e tempo livre;
- sons de inicio/fim;
- historico de sessoes no Firestore;
- metricas simples;
- autenticacao Firebase Auth;
- perfil/configuracoes basicas;
- instalacao como app pela tela inicial no iOS/Android;
- compartilhamento com card social bonito.

Nao ha backend proprio. Firebase e o backend operacional.

## Identidade Visual

Use `docs/design.md` como fonte de verdade visual.

Resumo da direcao:

- minimalista, calmante, premium, com bastante espaco em branco;
- inspiracao Apple: `#F5F5F7`, `#FFFFFF`, `#1D1D1F`, `#6E6E73`;
- azul `#0071E3` como unico acento de interacao;
- evitar gradientes, paletas alternativas e decoracao visual pesada;
- interface mobile-first.

Assets principais da PWA:

- `app/web/icons/Icon-180.png`
- `app/web/icons/Icon-192.png`
- `app/web/icons/Icon-512.png`
- `app/web/icons/Icon-maskable-192.png`
- `app/web/icons/Icon-maskable-512.png`
- `app/web/favicon.png`
- `app/web/social-card.png`

O gerador reprodutivel dos assets fica em:

```bash
swift scripts/generate_web_assets.swift
```

## Estrutura Importante

- App Flutter: `app/`
- Firebase config: `firebase.json`
- Firestore rules/indexes: `firebase/firestore.rules`, `firebase/firestore.indexes.json`
- CI/CD: `.github/workflows/deploy.yml`
- Identidade visual: `docs/design.md`
- Specs/planos historicos: `docs/superpowers/`

Arquivos sensiveis para PWA/cache/mobile:

- `app/web/index.html`
- `app/web/manifest.json`
- `firebase.json`
- `.github/workflows/deploy.yml`

## Firebase

Projeto Firebase:

```text
dayana-716b3
```

URL publicada:

```text
https://dayana-716b3.web.app
```

Web app Firebase ja existe no projeto:

```text
appId: 1:1008167047710:web:d7266c28c6eddf0ad5940f
```

O deploy automatico usa o secret do GitHub:

```text
FIREBASE_SERVICE_ACCOUNT_DAYANA_716B3
```

Service account usada:

```text
github-hosting-deploy@dayana-716b3.iam.gserviceaccount.com
```

## Comandos de Validacao

Antes de concluir mudancas de app/web/CI, rode o que fizer sentido para o escopo:

```bash
python3 -m json.tool firebase.json >/dev/null
python3 -m json.tool app/web/manifest.json >/dev/null
cd app && flutter test
cd app && flutter analyze
cd app && flutter build web --release --dart-define=APP_VERSION=v0.0.0
```

Para simular uma release especifica localmente:

```bash
cd app
flutter build web --release --dart-define=APP_VERSION=vA.B.C
```

## PWA, Cache e Atualizacao Automatica

Esta parte e critica. O usuario nao quer pessoas presas em versoes antigas.

O app mostra a versao via:

```text
APP_VERSION
```

O CI passa a tag como versao:

```bash
flutter build web --release --dart-define=APP_VERSION=${GITHUB_REF_NAME}
```

O workflow tambem precisa carimbar o service worker a cada release. Nao remova isso:

- `flutter_bootstrap.js` deve receber `serviceWorkerVersion: "vA.B.C"`;
- `flutter_service_worker.js` deve ter conteudo diferente a cada release, hoje via comentario `/* Dyana release vA.B.C */`.

Motivo: installations antigas podem chamar `registration.update()` usando uma URL antiga do service worker. Se o conteudo de `flutter_service_worker.js` nao mudar byte a byte, o browser pode concluir que nao ha update e manter cache antigo, deixando o usuario preso em versoes como `v0.0.0`.

Headers importantes no `firebase.json`:

- `/index.html`: `no-cache, no-store, must-revalidate`
- `/flutter_bootstrap.js`: `no-cache, no-store, must-revalidate`
- `/flutter_service_worker.js`: `no-cache, no-store, must-revalidate`
- `/main.dart.js`: `no-cache, no-store, must-revalidate`
- `/manifest.json`: `no-cache`
- `/social-card.png`: `no-cache`

Depois de deploy, validar em producao:

```bash
curl -s https://dayana-716b3.web.app/flutter_service_worker.js | rg 'Dyana release vA.B.C'
curl -s https://dayana-716b3.web.app/flutter_bootstrap.js | rg 'serviceWorkerVersion: "vA.B.C"'
curl -s https://dayana-716b3.web.app/main.dart.js | rg 'Versao vA.B.C'
curl -sI https://dayana-716b3.web.app/main.dart.js | rg -i 'cache-control|last-modified'
```

## Politica de Git/GitHub

Sempre use `gh` para interagir com o GitHub e com o estado remoto do repositorio. Evite `git push`, `git fetch` e outras operacoes remotas via transporte HTTPS direto, pois esse ambiente pode travar nesse caminho.

Para publicar commits, atualizar referencias, consultar runs, criar tags ou inspecionar o remoto, prefira `gh` ou a API do GitHub via `gh api`. Comandos locais de git continuam permitidos para estado local, diff, add, commit, log, status e tags locais quando necessario.

O branch remoto `main` pode estar mais avancado que o tracking local porque algumas publicacoes foram feitas via `gh api`. Antes de publicar no remoto, consulte o head real com:

```bash
gh api repos/xandroalmeida/dyana-app/git/ref/heads/main
```

## Politica de Versionamento

Release/tag/deploy automatico so devem ser disparados quando o usuario pedir explicitamente uma nova release ou pedir explicitamente para gerar uma versao. Nao crie tag, nao publique release e nao dispare o workflow de deploy apenas por ter feito commit, fix, melhoria ou ajuste de infraestrutura.

Quando o usuario pedir uma nova release, use tags no formato:

```text
vA.B.C
```

Use o esquema major, minor e patch:

- `A` - major: so deve mudar quando o usuario pedir explicitamente.
- `B` - minor: deve mudar quando houver uma nova funcionalidade do ponto de vista do usuario.
- `C` - patch: deve mudar em toda release de manutencao, fix ou infraestrutura. Deve zerar quando `B` incrementar.

Exemplos:

- Fix ou ajuste de infraestrutura depois de `v1.2.3`: proxima tag `v1.2.4`.
- Nova funcionalidade depois de `v1.2.3`: proxima tag `v1.3.0`.
- Mudanca major somente quando solicitada explicitamente: `v2.0.0`.

Releases ja publicadas:

- `v0.1.0`: primeira release funcional.
- `v0.1.1`: exibicao discreta da versao no app.
- `v0.2.0`: icones PWA, card social e metadados mobile/social.
- `v0.2.1`: fix para carimbar o proprio service worker e evitar app preso em versao antiga.

## Como Criar Release Quando Pedido

Quando, e somente quando, o usuario pedir explicitamente uma release:

1. Descobrir a proxima tag conforme a politica.
2. Garantir que o remoto `main` aponta para o commit correto.
3. Criar tag anotada via `gh api`, nao via `git push`.
4. Acompanhar o workflow `Deploy Web`.
5. Validar producao com `curl`.

Fluxo via API, adaptando `version`:

```bash
node <<'NODE'
const { execFileSync } = require('child_process');
const repo = 'xandroalmeida/dyana-app';
const version = 'vA.B.C';
function gh(args, input) {
  return execFileSync('gh', ['api', ...args], {
    input,
    encoding: 'utf8',
    maxBuffer: 20 * 1024 * 1024,
  });
}
function json(args, input) {
  return JSON.parse(gh(args, input));
}
const head = json([`repos/${repo}/git/ref/heads/main`]);
const commitSha = head.object.sha;
const tag = json([`repos/${repo}/git/tags`, '--method', 'POST', '--input', '-'], JSON.stringify({
  tag: version,
  message: `Release ${version}`,
  object: commitSha,
  type: 'commit',
}));
json([`repos/${repo}/git/refs`, '--method', 'POST', '--input', '-'], JSON.stringify({
  ref: `refs/tags/${version}`,
  sha: tag.sha,
}));
console.log(JSON.stringify({ version, commitSha, tagSha: tag.sha }, null, 2));
NODE
```

Depois acompanhe:

```bash
gh run list --repo xandroalmeida/dyana-app --workflow "Deploy Web" --limit 5
gh run watch <run-id> --repo xandroalmeida/dyana-app --exit-status
```
