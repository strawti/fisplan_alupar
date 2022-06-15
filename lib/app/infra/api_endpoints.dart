const apiBase = 'http://ec2-54-80-244-185.compute-1.amazonaws.com:3333/api/v1';

/// Auth
const apiLogin = '$apiBase/auth/login';
const apiLoginRefresh = '$apiBase/auth/login/refresh';
const apiLogout = '$apiBase/auth/me/disconnect';
const apiRecoveryPassword = '$apiBase/auth/forgot-password/request';
