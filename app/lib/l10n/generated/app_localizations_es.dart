// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Dyana';

  @override
  String get back => 'Volver';

  @override
  String versionLabel(Object version) {
    return 'Version $version';
  }

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Configuracion';

  @override
  String get signOut => 'Salir';

  @override
  String get homeSubtitle => 'Respira. Inicia una sesion cuando estes listo.';

  @override
  String get start => 'Iniciar';

  @override
  String get freeTime => 'Tiempo libre';

  @override
  String get history => 'Historial';

  @override
  String get metrics => 'Metricas';

  @override
  String get email => 'Email';

  @override
  String get password => 'Contrasena';

  @override
  String get name => 'Nombre';

  @override
  String get signIn => 'Entrar';

  @override
  String get signingIn => 'Entrando...';

  @override
  String get signInWithGoogle => 'Entrar con Google';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get forgotPassword => 'Olvide mi contrasena';

  @override
  String get creating => 'Creando...';

  @override
  String get resetPassword => 'Recuperar contrasena';

  @override
  String get sendReset => 'Enviar recuperacion';

  @override
  String get sending => 'Enviando...';

  @override
  String get passwordResetSent => 'Email de recuperacion enviado.';

  @override
  String get requiredEmail => 'Ingresa tu email.';

  @override
  String get invalidEmail => 'Ingresa un email valido.';

  @override
  String get requiredPassword => 'Ingresa tu contrasena.';

  @override
  String get requiredNewPassword => 'Ingresa una contrasena.';

  @override
  String get weakSignupPassword => 'Usa al menos 6 caracteres.';

  @override
  String get authGenericError =>
      'No pudimos completar esto. Intentalo de nuevo.';

  @override
  String get authCancelled => 'Inicio de sesion cancelado.';

  @override
  String get authInvalidEmail => 'Email invalido.';

  @override
  String get authUserDisabled => 'Cuenta desactivada.';

  @override
  String get authInvalidCredentials => 'Email o contrasena invalidos.';

  @override
  String get authEmailAlreadyInUse => 'Este email ya esta en uso.';

  @override
  String get authWeakPassword => 'Usa una contrasena de al menos 6 caracteres.';

  @override
  String get authNetworkFailed => 'Revisa tu conexion e intentalo de nuevo.';

  @override
  String get authTooManyRequests => 'Demasiados intentos. Intentalo mas tarde.';

  @override
  String get meditation => 'Meditacion';

  @override
  String get breathe => 'Respira';

  @override
  String get timePracticed => 'tiempo practicado';

  @override
  String get timeRemaining => 'tiempo restante';

  @override
  String get pause => 'Pausar';

  @override
  String get resume => 'Continuar';

  @override
  String get finish => 'Finalizar';

  @override
  String get saving => 'Guardando...';

  @override
  String get sessionSaveError => 'No pudimos guardar la sesion.';

  @override
  String get sessionCompleted => 'Sesion completada';

  @override
  String get sessionRecorded => 'Sesion registrada.';

  @override
  String get share => 'Compartir';

  @override
  String get backToHome => 'Volver al inicio';

  @override
  String shareSessionText(Object minutes) {
    return 'Medite durante $minutes minutos hoy.';
  }

  @override
  String get shareShortSessionText => 'Complete una sesion de meditacion hoy.';

  @override
  String shareMetricsText(Object totalMinutes, Object sessionsThisWeek) {
    return 'Ya practique $totalMinutes minutos de meditacion. Esta semana complete $sessionsThisWeek sesiones.';
  }

  @override
  String get shared => 'Compartido.';

  @override
  String get textCopied => 'Texto copiado.';

  @override
  String get signInToEditProfile => 'Entra para editar tu perfil.';

  @override
  String get profileLoadError => 'No pudimos cargar tu perfil.';

  @override
  String get gender => 'Genero';

  @override
  String get birthDate => 'Fecha de nacimiento';

  @override
  String get birthDateFormatError => 'Usa la fecha en formato yyyy-MM-dd.';

  @override
  String get profileSaved => 'Perfil guardado.';

  @override
  String get saveError => 'No pudimos guardar.';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get signInToEditSettings => 'Entra para editar tu configuracion.';

  @override
  String get settingsLoadError => 'No pudimos cargar tu configuracion.';

  @override
  String get startSound => 'Sonido al iniciar';

  @override
  String get endSound => 'Sonido al terminar';

  @override
  String get appearance => 'Apariencia';

  @override
  String get language => 'Idioma';

  @override
  String get defaultDuration => 'Duracion predeterminada';

  @override
  String get save => 'Guardar';

  @override
  String get settingsSaved => 'Configuracion guardada.';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get english => 'Ingles';

  @override
  String get portuguese => 'Portugues';

  @override
  String get spanish => 'Espanol';

  @override
  String get signInToViewHistory => 'Entra para ver tu historial.';

  @override
  String get historyLoadError => 'No pudimos cargar el historial.';

  @override
  String get historyEmpty => 'Tus sesiones apareceran aqui.';

  @override
  String get periodSevenDays => '7 dias';

  @override
  String get periodThirtyDays => '30 dias';

  @override
  String get periodAll => 'Todo';

  @override
  String get definedTime => 'Tiempo definido';

  @override
  String get completed => 'Completada';

  @override
  String get ended => 'Finalizada';

  @override
  String get signInToViewMetrics => 'Entra para ver tus metricas.';

  @override
  String get metricsLoadError => 'No pudimos cargar tus metricas.';

  @override
  String get last7Days => 'Ultimos 7 dias';

  @override
  String get last30Days => 'Ultimos 30 dias';

  @override
  String get sessions => 'Sesiones';

  @override
  String get total => 'Total';

  @override
  String get currentStreak => 'Racha actual';

  @override
  String get longestStreak => 'Mayor racha';

  @override
  String get average => 'Promedio';

  @override
  String get daysThisWeek => 'Dias esta semana';

  @override
  String get daysUnit => 'dias';

  @override
  String get firstSessionMilestone => 'Primera sesion registrada.';

  @override
  String get sevenDaysMilestone => '7 dias con practica acumulada.';

  @override
  String get thirtyMinutesMilestone => '30 minutos acumulados.';

  @override
  String get tenSessionsMilestone => '10 sesiones completadas.';

  @override
  String get hundredMinutesMilestone => '100 minutos acumulados.';
}
