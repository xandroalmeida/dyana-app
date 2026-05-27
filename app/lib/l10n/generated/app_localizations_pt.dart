// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Dyana';

  @override
  String get back => 'Voltar';

  @override
  String versionLabel(Object version) {
    return 'Versao $version';
  }

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Configuracoes';

  @override
  String get signOut => 'Sair';

  @override
  String get homeSubtitle =>
      'Respire. Comece uma sessao quando estiver pronto.';

  @override
  String get start => 'Iniciar';

  @override
  String get freeTime => 'Tempo livre';

  @override
  String get history => 'Historico';

  @override
  String get metrics => 'Metricas';

  @override
  String get email => 'Email';

  @override
  String get password => 'Senha';

  @override
  String get name => 'Nome';

  @override
  String get signIn => 'Entrar';

  @override
  String get signingIn => 'Entrando...';

  @override
  String get signInWithGoogle => 'Entrar com Google';

  @override
  String get createAccount => 'Criar conta';

  @override
  String get forgotPassword => 'Esqueci minha senha';

  @override
  String get creating => 'Criando...';

  @override
  String get resetPassword => 'Recuperar senha';

  @override
  String get sendReset => 'Enviar recuperacao';

  @override
  String get sending => 'Enviando...';

  @override
  String get passwordResetSent => 'E-mail de recuperacao enviado.';

  @override
  String get requiredEmail => 'Informe seu e-mail.';

  @override
  String get invalidEmail => 'Informe um e-mail valido.';

  @override
  String get requiredPassword => 'Informe sua senha.';

  @override
  String get requiredNewPassword => 'Informe uma senha.';

  @override
  String get weakSignupPassword => 'Use pelo menos 6 caracteres.';

  @override
  String get authGenericError => 'Nao foi possivel concluir. Tente novamente.';

  @override
  String get authCancelled => 'Login cancelado.';

  @override
  String get authInvalidEmail => 'E-mail invalido.';

  @override
  String get authUserDisabled => 'Conta desativada.';

  @override
  String get authInvalidCredentials => 'E-mail ou senha invalidos.';

  @override
  String get authEmailAlreadyInUse => 'Este e-mail ja esta em uso.';

  @override
  String get authWeakPassword => 'Use uma senha com pelo menos 6 caracteres.';

  @override
  String get authNetworkFailed => 'Verifique sua conexao e tente novamente.';

  @override
  String get authTooManyRequests =>
      'Muitas tentativas. Tente novamente mais tarde.';

  @override
  String get meditation => 'Meditacao';

  @override
  String get breathe => 'Respire';

  @override
  String get timePracticed => 'tempo praticado';

  @override
  String get timeRemaining => 'tempo restante';

  @override
  String get pause => 'Pausar';

  @override
  String get resume => 'Retomar';

  @override
  String get finish => 'Encerrar';

  @override
  String get saving => 'Salvando...';

  @override
  String get sessionSaveError => 'Nao foi possivel salvar a sessao.';

  @override
  String get sessionCompleted => 'Sessao concluida';

  @override
  String get sessionRecorded => 'Sessao registrada.';

  @override
  String get share => 'Compartilhar';

  @override
  String get backToHome => 'Voltar ao inicio';

  @override
  String shareSessionText(Object minutes) {
    return 'Meditei por $minutes minutos hoje.';
  }

  @override
  String get shareShortSessionText => 'Conclui uma sessao de meditacao hoje.';

  @override
  String shareMetricsText(Object totalMinutes, Object sessionsThisWeek) {
    return 'Ja pratiquei $totalMinutes minutos de meditacao. Nesta semana, completei $sessionsThisWeek sessoes.';
  }

  @override
  String get shared => 'Compartilhado.';

  @override
  String get textCopied => 'Texto copiado.';

  @override
  String get signInToEditProfile => 'Entre para editar seu perfil.';

  @override
  String get profileLoadError => 'Nao foi possivel carregar seu perfil.';

  @override
  String get gender => 'Genero';

  @override
  String get birthDate => 'Data de nascimento';

  @override
  String get birthDateFormatError => 'Use a data no formato yyyy-MM-dd.';

  @override
  String get profileSaved => 'Perfil salvo.';

  @override
  String get saveError => 'Nao foi possivel salvar.';

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get signInToEditSettings => 'Entre para editar suas configuracoes.';

  @override
  String get settingsLoadError =>
      'Nao foi possivel carregar suas configuracoes.';

  @override
  String get startSound => 'Som ao iniciar';

  @override
  String get endSound => 'Som ao terminar';

  @override
  String get appearance => 'Aparencia';

  @override
  String get language => 'Idioma';

  @override
  String get defaultDuration => 'Duracao padrao';

  @override
  String get save => 'Salvar';

  @override
  String get settingsSaved => 'Configuracoes salvas.';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Escuro';

  @override
  String get english => 'Ingles';

  @override
  String get portuguese => 'Portugues';

  @override
  String get spanish => 'Espanhol';

  @override
  String get signInToViewHistory => 'Entre para ver seu historico.';

  @override
  String get historyLoadError => 'Nao foi possivel carregar o historico.';

  @override
  String get historyEmpty => 'Suas sessoes aparecerao aqui.';

  @override
  String get periodSevenDays => '7 dias';

  @override
  String get periodThirtyDays => '30 dias';

  @override
  String get periodAll => 'Tudo';

  @override
  String get definedTime => 'Tempo definido';

  @override
  String get completed => 'Concluida';

  @override
  String get ended => 'Encerrada';

  @override
  String get signInToViewMetrics => 'Entre para ver suas metricas.';

  @override
  String get metricsLoadError => 'Nao foi possivel carregar suas metricas.';

  @override
  String get last7Days => 'Ultimos 7 dias';

  @override
  String get last30Days => 'Ultimos 30 dias';

  @override
  String get sessions => 'Sessoes';

  @override
  String get total => 'Total';

  @override
  String get currentStreak => 'Sequencia atual';

  @override
  String get longestStreak => 'Maior sequencia';

  @override
  String get average => 'Media';

  @override
  String get daysThisWeek => 'Dias na semana';

  @override
  String get daysUnit => 'dias';

  @override
  String get firstSessionMilestone => 'Primeira sessao registrada.';

  @override
  String get sevenDaysMilestone => '7 dias com pratica acumulada.';

  @override
  String get thirtyMinutesMilestone => '30 minutos acumulados.';

  @override
  String get tenSessionsMilestone => '10 sessoes concluidas.';

  @override
  String get hundredMinutesMilestone => '100 minutos acumulados.';
}
