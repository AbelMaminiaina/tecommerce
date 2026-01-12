# Guide de construction Odoo Enterprise

## Étape 1: Obtenir votre token GitHub

1. Connectez-vous sur https://github.com/settings/tokens
2. Cliquez sur "Generate new token" → "Classic token"
3. Nom: `Odoo Enterprise Access`
4. Permissions: Cochez **repo** (Full control of private repositories)
5. Générez et copiez le token (format: `ghp_xxxxxxxxxxxxx`)

Note: Votre compte GitHub doit être lié à votre souscription Odoo Enterprise via odoo.com

## Étape 2: Arrêter le conteneur actuel

```bash
cd docker
docker compose --profile dev down
```

## Étape 3: Reconstruire avec Enterprise

```bash
docker compose --profile dev build --build-arg GITHUB_TOKEN=ghp_votre_token_ici --no-cache
```

**Remplacez `ghp_votre_token_ici` par votre vrai token**

## Étape 4: Redémarrer le conteneur

```bash
docker compose --profile dev up -d
```

## Étape 5: Vérifier que Enterprise est bien installé

```bash
docker exec odoo-dev ls -la /opt/odoo/enterprise | head -20
```

Vous devriez voir les modules Enterprise (account_accountant, hr_payroll, etc.)

## Étape 6: Activer votre licence Enterprise dans Odoo

1. Connectez-vous sur http://localhost:8069
2. Allez dans **Paramètres** → **General Settings**
3. Section **Odoo.com Account**
4. Cliquez sur **Register** ou **Link your subscription**
5. Entrez votre code de souscription Enterprise
6. Les modules Enterprise apparaîtront maintenant dans Apps

## Modules Enterprise disponibles

Une fois activé, vous aurez accès à :
- Accounting (Comptabilité avancée)
- Manufacturing (MRP)
- PLM (Product Lifecycle Management)
- Studio (Personnalisation d'apps sans code)
- Helpdesk
- Quality
- Maintenance
- HR Payroll
- Approvals
- Planning
- Et bien d'autres...
