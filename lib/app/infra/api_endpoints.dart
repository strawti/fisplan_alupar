// PRODUCTION
//const apiBase = 'https://fisplan.alupar.com.br/api/';

// DEVELOPMENT
const apiBase = '';


/// Endpoints
const apiLogin = '$apiBase/auth/login';
const apiLoginRefresh = '$apiBase/auth/login/refresh';
const apiLogout = '$apiBase/auth/me/disconnect';
const apiRecoveryPassword = '$apiBase/auth/forgot-password/request';
