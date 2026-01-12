# Configuration de la licence Odoo Enterprise

## 📋 Ce dont vous avez besoin

1. **Code de souscription Enterprise** (fourni par Odoo ou votre partenaire)
   - Format: `XXXXX-XXXXX-XXXXX`
   - Disponible sur https://www.odoo.com/my/databases

2. **Accès Internet** depuis le conteneur Docker
   - Nécessaire pour valider la licence auprès des serveurs Odoo

## 🔧 Méthode 1: Activation via l'interface Web (Recommandé)

### Après avoir reconstruit l'image avec Enterprise:

1. **Démarrez Odoo**
   ```bash
   cd docker
   docker compose --profile dev up -d
   ```

2. **Accédez à l'interface**
   - Ouvrez http://localhost:8069
   - Connectez-vous avec vos identifiants admin

3. **Activez la licence**
   - Allez dans **Paramètres** (Settings)
   - Cherchez la section **Odoo.com Account** ou **Subscription**
   - Cliquez sur **Register** ou **Link your subscription**
   - Entrez votre **code de souscription** (format: XXXXX-XXXXX-XXXXX)
   - Cliquez sur **Activate**

4. **Vérification**
   - La bannière "Community Edition" disparaît
   - Les modules Enterprise apparaissent dans **Apps**
   - Exemples: Accounting, Studio, Manufacturing, etc.

## 🔧 Méthode 2: Configuration manuelle (Alternative)

### Via le fichier de configuration

Ajoutez dans votre fichier de configuration Odoo:

```ini
[options]
# ... autres options ...

# Enterprise subscription
database_uuid = votre-database-uuid
server_wide_modules = base,web,web_enterprise
```

Note: Le `database_uuid` est généré automatiquement lors de la première activation via l'interface.

## 🔍 Vérifier que Enterprise est installé

### Vérifier les modules Enterprise dans le conteneur:

```bash
docker exec odoo-dev ls /opt/odoo/enterprise | head -20
```

Vous devriez voir:
```
account_accountant
account_asset
account_budget
approval
documents
helpdesk
hr_payroll
industry_fsm
mrp_plm
quality_control
...
```

### Vérifier dans l'interface Odoo:

1. Allez dans **Apps**
2. Activez le mode développeur: **Paramètres → Developer mode**
3. Dans Apps, retirez le filtre "Apps" et cherchez "Studio"
4. Si vous voyez **Odoo Studio**, Enterprise est bien installé

## 🚨 Problèmes courants

### "Repository not found" lors du build
- Votre compte GitHub n'est pas lié à votre souscription Odoo
- Résolution: Allez sur https://www.odoo.com/my → Developer → Link GitHub account

### "Invalid subscription code"
- Le code est expiré ou déjà utilisé
- Résolution: Vérifiez sur https://www.odoo.com/my/databases

### Les modules Enterprise n'apparaissent pas
- La licence n'est pas activée
- Le path /opt/odoo/enterprise n'est pas dans addons_path
- Résolution: Vérifiez la configuration et redémarrez Odoo

### "This database is not registered"
- La base de données n'est pas liée à votre souscription
- Résolution: Allez dans Paramètres → Register this database

## 📦 Modules Enterprise principaux

Une fois la licence activée, vous aurez accès à:

### Finance & Comptabilité
- `account_accountant` - Comptabilité complète
- `account_asset` - Gestion d'actifs
- `account_budget` - Budgets
- `account_consolidation` - Consolidation

### Manufacturing
- `mrp_plm` - Product Lifecycle Management
- `mrp_workorder` - Ordres de travail
- `quality_control` - Contrôle qualité
- `maintenance` - Maintenance préventive

### Productivité
- `studio` - Odoo Studio (personnalisation no-code)
- `documents` - Gestion documentaire
- `approvals` - Workflow d'approbations
- `sign` - Signature électronique

### Ventes & Marketing
- `sale_subscription` - Abonnements
- `helpdesk` - Service client
- `planning` - Planification ressources
- `social` - Réseaux sociaux

### RH
- `hr_payroll` - Paie
- `hr_appraisal` - Évaluations
- `hr_recruitment_survey` - Recrutement avancé

## 🎯 Prochaines étapes

1. Reconstruisez l'image avec votre token GitHub
2. Redémarrez le conteneur
3. Activez votre licence via l'interface web
4. Installez les modules Enterprise dont vous avez besoin
5. Configurez vos applications
