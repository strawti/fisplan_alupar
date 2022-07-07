// PRODUCTION
const apiBase = 'https://fisplan.alupar.com.br/api';

/// Endpoints
const apiLogin = '$apiBase/auth/login';
const apiMe = '$apiBase/auth/me';
const apiLogout = '$apiBase/auth/logout';
const apiLoginRefresh = '$apiBase/auth/login/refresh';
const apiForgotPassword = '$apiBase/auth/password/email';

const apiActivities = '$apiBase/activities';

const apiEquipmentCategories = '$apiBase/equipment-categories';
const apiEquipments = '$apiBase/equipments';
const apiInspections = '$apiBase/inspections';

const apiInspectionsSyncSingle = '$apiBase/inspections/sync-single';

const apiInstallationTypes = '$apiBase/installation-types';
const apiInstallations = '$apiBase/installations';

const apiCompanies = '$apiBase/companies';

const apiTowers = '$apiBase/towers';
