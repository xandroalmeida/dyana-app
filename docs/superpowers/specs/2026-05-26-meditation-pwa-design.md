# Especificacao de Produto: App de Meditacao PWA

Data: 2026-05-26  
Status: especificacao inicial aprovada para planejamento tecnico  
Responsavel de produto: Product Owner

## 1. Visao

Criar uma aplicacao web em Flutter, mobile first, instalavel como PWA, para ajudar pessoas a praticarem meditacao de forma simples, calma e recorrente.

O produto deve funcionar principalmente no celular e permitir que o usuario o adicione a tela inicial, com comportamento proximo ao de um app nativo. A primeira versao sera apenas web, sem backend proprio. Autenticacao e banco de dados serao fornecidos pelo Firebase.

O posicionamento do app sera minimalista e calmante. A experiencia deve reduzir atrito para iniciar uma pratica, registrar sessoes automaticamente e apresentar historico e metricas de constancia sem criar pressao competitiva.

## 2. Objetivos

Objetivos do MVP:

- Permitir cadastro e login do usuario.
- Permitir que o usuario configure um perfil basico.
- Permitir iniciar uma sessao de meditacao com tempo determinado.
- Permitir iniciar uma sessao de meditacao em tempo livre.
- Tocar sons simples no inicio e no fim da sessao, conforme preferencia do usuario.
- Registrar sessoes concluidas no Firebase Firestore.
- Exibir historico de meditacoes do usuario.
- Exibir metricas simples de pratica.
- Permitir compartilhar a sessao recem-finalizada ou metricas atuais.
- Permitir instalacao como PWA no celular.
- Atualizar automaticamente quando uma nova versao estiver disponivel.

Fora do MVP:

- Meditacoes guiadas.
- Biblioteca de audios ou conteudos.
- Backend proprio.
- Comunidade, feed social ou ranking.
- Planos pagos.
- Integracoes com apps de saude.
- Offline avancado com sincronizacao posterior.
- Notificacoes e lembretes.

## 3. Publico-Alvo

Pessoas que querem criar ou manter o habito de meditar usando principalmente o celular.

O app deve atender:

- Iniciantes que precisam de uma forma simples de comecar.
- Pessoas que ja meditam e querem um timer tranquilo com historico.
- Usuarios que valorizam uma experiencia visual limpa, sem excesso de comandos, conteudo ou estimulos.

## 4. Plataformas E Tecnologia

Primeira fase:

- Flutter Web.
- PWA mobile first.
- Firebase Auth para autenticacao.
- Firebase Firestore para persistencia.
- Firebase Hosting como opcao recomendada para o MVP, por integrar bem com Firebase e PWA. Outro hosting web compativel com PWA pode ser escolhido no planejamento tecnico se houver uma restricao operacional especifica.

Nao havera backend proprio no MVP.

Futuro possivel:

- Builds nativas Android e iOS usando a mesma base Flutter.
- Notificacoes push.
- Funcionamento offline avancado.
- Firebase Storage para upload de foto, caso o MVP opte por nao incluir upload.

## 5. Autenticacao

O app deve permitir autenticacao por:

- E-mail e senha.
- Conta Google.

Fluxos obrigatorios:

- Criar conta com e-mail e senha.
- Entrar com e-mail e senha.
- Entrar com Google.
- Recuperar senha.
- Sair da conta.
- Manter sessao ativa entre acessos.

Regras:

- Todas as sessoes de meditacao devem estar associadas ao usuario autenticado.
- Usuario nao autenticado nao deve acessar home, timer, historico, metricas ou perfil.

## 6. Perfil Do Usuario

O usuario pode informar e editar:

- Nome.
- E-mail.
- Genero.
- Data de nascimento.
- Foto.

Decisao para o MVP:

- O e-mail sera obtido da autenticacao e exibido no perfil.
- A foto podera vir da conta Google quando disponivel.
- Upload manual de foto pode ser deixado para fase futura se aumentar escopo tecnico. Caso entre no MVP, deve usar Firebase Storage.

## 7. Sessao De Meditacao

O usuario podera iniciar uma sessao em dois modos.

### 7.1 Tempo Determinado

O usuario escolhe uma duracao antes de iniciar.

Duracoes pre-definidas do MVP:

- 3 minutos.
- 5 minutos.
- 10 minutos.
- 15 minutos.
- 20 minutos.
- 30 minutos.

O app pode sugerir 10 minutos como duracao padrao inicial.

### 7.2 Tempo Livre

O usuario inicia a meditacao sem duracao definida e encerra manualmente.

### 7.3 Durante A Sessao

A tela de sessao deve:

- Exibir timer de forma clara.
- Ter acao para pausar e retomar.
- Ter acao para encerrar.
- Evitar elementos visuais excessivos.
- Manter foco na pratica.

### 7.4 Sons

O app deve oferecer:

- Som no inicio da sessao.
- Som no fim da sessao.

Regras:

- O usuario pode ativar ou desativar cada som.
- A preferencia deve ser salva no perfil/configuracoes.
- O som deve ser simples e suave, como um sino curto.
- O MVP nao precisa oferecer biblioteca de sons.

### 7.5 Finalizacao

Ao finalizar uma sessao:

- Registrar a sessao no Firestore.
- Exibir tela de conclusao.
- Mostrar a duracao praticada.
- Oferecer opcao de compartilhar.

Sessoes encerradas manualmente tambem devem ser registradas, desde que tenham duracao maior que um minimo tecnico definido no planejamento, por exemplo 10 segundos, para evitar registros acidentais.

## 8. Historico

O app deve exibir as sessoes anteriores do usuario.

Cada item do historico deve mostrar:

- Data.
- Hora.
- Duracao.
- Tipo de sessao: tempo determinado ou tempo livre.
- Status: concluida ou encerrada manualmente.

Filtros ou agrupamentos do MVP:

- Ultimos 7 dias.
- Ultimos 30 dias.
- Todo o historico.

O historico deve ser simples, escaneavel e otimizado para celular.

## 9. Metricas E Gamificacao Leve

As metricas devem reforcar constancia e autocuidado, sem linguagem competitiva.

Metricas do MVP:

- Minutos meditados nos ultimos 7 dias.
- Minutos meditados nos ultimos 30 dias.
- Total de sessoes.
- Total de minutos meditados.
- Sequencia atual de dias com pratica.
- Maior sequencia de dias com pratica.
- Media de minutos por sessao.
- Dias praticados na semana atual.

Marcos simples:

- Primeira sessao.
- 7 dias com pratica acumulada.
- 30 minutos acumulados.
- 10 sessoes concluidas.
- 100 minutos acumulados.

Tom de produto:

- Usar linguagem calma e acolhedora.
- Evitar pontos, rankings, comparacao entre usuarios ou cobrancas.
- Tratar sequencias como incentivo, nao como penalidade.

## 10. Compartilhamento

O usuario podera compartilhar:

- Sessao recem-finalizada.
- Resumo de metricas atuais.

Exemplos de texto:

- "Meditei por 10 minutos hoje."
- "Completei 5 sessoes de meditacao esta semana."
- "Ja pratiquei 120 minutos de meditacao."

Requisitos:

- Usar Web Share API quando disponivel.
- Oferecer fallback para copiar texto quando o compartilhamento nativo nao estiver disponivel.
- Compartilhamento visual em imagem fica fora do MVP.

## 11. Modelo De Dados

### 11.1 Colecao `users`

Documento: `users/{uid}`

```json
{
  "uid": "firebase-auth-uid",
  "name": "string",
  "email": "string",
  "gender": "string",
  "birthDate": "timestamp",
  "photoUrl": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "preferences": {
    "startSoundEnabled": true,
    "endSoundEnabled": true,
    "defaultDurationMinutes": 10
  }
}
```

### 11.2 Subcolecao `sessions`

Documento: `users/{uid}/sessions/{sessionId}`

```json
{
  "startedAt": "timestamp",
  "endedAt": "timestamp",
  "durationSeconds": 600,
  "mode": "fixed",
  "plannedDurationSeconds": 600,
  "completed": true,
  "startSoundEnabled": true,
  "endSoundEnabled": true,
  "createdAt": "timestamp"
}
```

Valores aceitos:

- `mode`: `fixed` ou `free`.
- `completed`: `true` quando a sessao terminou conforme planejado ou foi finalizada validamente; `false` pode ser usado para sessoes abandonadas se o app decidir registrar esse caso no futuro.

Decisao do MVP:

- Metricas serao calculadas no app a partir das sessoes.
- Nao criar agregacoes no Firestore no MVP.

## 12. Telas Do MVP

Telas principais:

- Login.
- Cadastro.
- Recuperacao de senha.
- Onboarding simples.
- Home.
- Selecao de duracao.
- Timer de meditacao.
- Conclusao da sessao.
- Historico.
- Metricas.
- Perfil e configuracoes.

### 12.1 Home

A home deve priorizar inicio rapido da meditacao.

Elementos sugeridos:

- Saudacao simples.
- Duracao padrao selecionada.
- Botao principal para iniciar.
- Acesso a tempo livre.
- Resumo discreto com sequencia atual e minutos da semana.

### 12.2 Onboarding

O onboarding deve ser curto e opcional apos login.

Objetivo:

- Explicar que o app funciona como timer de meditacao.
- Permitir selecionar duracao padrao inicial.
- Permitir configurar sons de inicio e fim.

Evitar onboarding longo ou conteudo educacional extenso no MVP.

## 13. PWA E Atualizacoes

Requisitos PWA:

- Manifest configurado.
- Nome completo e nome curto do app.
- Icones nos tamanhos necessarios para instalacao.
- Cor de tema coerente com a identidade visual.
- Service worker ativo.
- App instalavel via "Adicionar a tela de inicio".
- Layout responsivo mobile first.

Atualizacoes:

- Detectar nova versao do service worker.
- Baixar nova versao em segundo plano.
- Aplicar atualizacao automaticamente quando seguro.
- Evitar que o usuario fique preso em versao antiga.
- Quando necessario, exibir aviso discreto como "Nova versao disponivel. Atualizando...".

Decisao do MVP:

- Nao implementar offline avancado com sincronizacao posterior.
- O app pode carregar recursos basicos via cache PWA, mas o registro confiavel de sessoes depende de conexao com Firebase.

## 14. Regras De Seguranca Firebase

Regras essenciais:

- Apenas usuarios autenticados podem acessar dados do app.
- Cada usuario so pode ler e escrever seu proprio documento em `users/{uid}`.
- Cada usuario so pode ler e escrever suas proprias sessoes em `users/{uid}/sessions`.
- Nenhum usuario pode acessar dados de outro usuario.

Validações recomendadas nas regras ou na camada de aplicacao:

- `durationSeconds` deve ser positivo.
- `mode` deve aceitar apenas `fixed` ou `free`.
- `startedAt` e `endedAt` devem ser timestamps validos.

## 15. Requisitos Nao Funcionais

- Mobile first.
- Interface limpa e calma.
- Carregamento rapido.
- Funcionamento adequado em conexoes moveis.
- Acessibilidade basica: contraste, fonte legivel e botoes grandes.
- Estado de carregamento claro para operacoes Firebase.
- Tratamento de erro amigavel para falha de login, falta de conexao e falha ao salvar sessao.
- Dados protegidos por regras do Firebase.

## 16. Tratamento De Erros

Cenarios obrigatorios:

- Falha ao autenticar.
- E-mail ja cadastrado.
- Senha invalida ou fraca.
- Falha ao recuperar senha.
- Falha ao carregar perfil.
- Falha ao salvar sessao.
- Falha ao carregar historico.
- Usuario sem conexao ao tentar salvar dados.

Principio de comunicacao:

- Mensagens curtas, humanas e sem tom alarmista.
- Sempre que possivel, oferecer uma acao clara, como tentar novamente.

## 17. Criterios De Aceite Do MVP

O MVP sera considerado pronto quando:

- Usuario consegue criar conta com e-mail e senha.
- Usuario consegue entrar com e-mail e senha.
- Usuario consegue entrar com Google.
- Usuario consegue recuperar senha.
- Usuario consegue sair.
- Usuario consegue editar perfil basico.
- Usuario consegue escolher uma duracao pre-definida.
- Usuario consegue iniciar sessao com tempo determinado.
- Usuario consegue iniciar sessao em tempo livre.
- Sons de inicio e fim respeitam as preferencias do usuario.
- Sessao finalizada e salva no Firestore.
- Historico mostra sessoes salvas do usuario autenticado.
- Metricas principais sao calculadas e exibidas corretamente.
- Usuario consegue compartilhar resumo da sessao.
- Usuario consegue compartilhar metricas atuais.
- App pode ser instalado como PWA em celular compativel.
- App detecta e aplica novas versoes automaticamente.
- Regras do Firebase impedem acesso entre usuarios.

## 18. Fases Sugeridas De Desenvolvimento

### Fase 1: Base Tecnica

- Criar projeto Flutter Web.
- Configurar Firebase.
- Configurar estrutura PWA.
- Definir tema visual inicial.
- Definir rotas e estrutura de estado.

### Fase 2: Autenticacao E Perfil

- Implementar login/cadastro.
- Implementar login Google.
- Implementar recuperacao de senha.
- Criar documento de usuario no Firestore.
- Implementar tela de perfil/configuracoes.

### Fase 3: Timer E Sessoes

- Implementar selecao de duracao.
- Implementar timer fixo.
- Implementar timer livre.
- Implementar pausa, retomada e encerramento.
- Implementar sons de inicio e fim.
- Persistir sessao finalizada.

### Fase 4: Historico E Metricas

- Listar sessoes.
- Implementar filtros de periodo.
- Calcular metricas.
- Exibir sequencia atual e maior sequencia.
- Exibir marcos simples.

### Fase 5: Compartilhamento E Acabamento PWA

- Implementar Web Share API.
- Implementar fallback de copiar texto.
- Configurar atualizacao automatica.
- Revisar instalacao PWA.
- Testar em viewport mobile.
- Revisar acessibilidade basica.

## 19. Decisoes Registradas

- O app sera minimalista e calmante.
- O MVP tera apenas timer de sessao, sons de inicio/fim e historico.
- Meditacoes guiadas ficam fora do MVP.
- Gamificacao sera leve e nao competitiva.
- Offline avancado fica fora do MVP.
- Notificacoes e lembretes ficam fora do MVP.
- Nao havera backend proprio.
- Firestore sera o banco de dados.
- Firebase Auth sera o mecanismo de autenticacao.

## 20. Perguntas Para Planejamento Tecnico

Estas perguntas nao bloqueiam a especificacao de produto, mas devem ser resolvidas antes ou durante o planejamento tecnico:

- Qual sera o nome definitivo do app?
- Qual identidade visual inicial sera adotada?
- O MVP tera upload manual de foto ou apenas foto vinda do Google?
- O projeto usara Firebase Hosting ou outro provedor para deploy?
- Qual biblioteca/abordagem de gerenciamento de estado sera usada no Flutter?
- Como sera validada a atualizacao automatica do PWA em ambiente de teste?
