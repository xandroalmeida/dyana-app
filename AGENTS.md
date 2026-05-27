# AGENTS.md

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
