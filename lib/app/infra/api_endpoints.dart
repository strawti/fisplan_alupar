// PRODUCTION
//const apiBase = 'https://fisplan.alupar.com.br/api/';

// DEVELOPMENT
const apiBase = '';

/// Endpoints
const apiLogin = '$apiBase/auth/login';
const apiLogout = '$apiBase/auth/logout';
const apiLoginRefresh = '$apiBase/auth/login/refresh';
const apiForgotPassword = '$apiBase/auth/password/email';

const apiActivities = '$apiBase/activities';

const apiEquipmentCategories = '$apiBase/equipment-categories';
const apiEquipments = '$apiBase/equipments';
const apiInspections = '$apiBase/inspections';
// for pictures
// inspections/${upload.server_inspection_id}/photo

const apiInspectionsSyncSingle = '$apiBase/inspections/sync-single';

const apiInstallationTypes = '$apiBase/installation-types';
const apiInstallations = '$apiBase/installations';

const apiCompanies = '$apiBase/companies';
// for projects
// companies/${user.get('company_id')}/projects
// companies/${user.get('company_id')}/by-projects/questionnaires
// companies/${user.get('company_id')}/by-projects/steps
// companies/${user.get('company_id')}/tension-levels

const apiTowers = '$apiBase/towers';