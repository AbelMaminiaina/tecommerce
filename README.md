# Odoo 18 Community - Multi-Environment Setup

Application Odoo 18 Community avec architecture Docker supportant 4 environnements isolés (dev, test, preprod, prod).

## Environnements

| Environnement | Port Odoo | Port Longpolling | URL d'accès |
|---------------|-----------|------------------|-------------|
| Development   | 8069      | 8072             | http://localhost:8069 |
| Test          | 8070      | 8073             | http://localhost:8070 |
| Pre-production| 8071      | 8074             | http://localhost:8071 |
| Production    | 8072      | 8075             | http://localhost:8072 |

## Prérequis

- Docker Desktop pour Windows
- Git Bash
- Au moins 8 GB RAM disponible pour Docker
- Au moins 20 GB d'espace disque

## Installation Rapide

### 1. Cloner le projet

```bash
cd C:/Users/amami/GitHub
git clone <your-repo-url> odoo-app
cd odoo-app
```

### 2. Configurer les variables d'environnement

Le fichier `.env` est déjà créé avec des mots de passe par défaut. Pour la production, modifiez les mots de passe:

```bash
# Éditez le fichier .env et changez les mots de passe
vim .env
```

### 3. Build les images Docker

```bash
cd docker
docker-compose build
```

### 4. Démarrer l'environnement de développement

```bash
cd ..
./scripts/start.sh dev
```

### 5. Accéder à Odoo

Ouvrez votre navigateur à http://localhost:8069 et créez votre première base de données.

## Utilisation

### Démarrer un environnement

```bash
# Développement
./scripts/start.sh dev

# Test
./scripts/start.sh test

# Pré-production
./scripts/start.sh preprod

# Production
./scripts/start.sh prod
```

### Arrêter un environnement

```bash
# Arrêter dev
./scripts/stop.sh dev

# Arrêter tous les environnements
./scripts/stop.sh all
```

### Voir les logs

```bash
cd docker
docker-compose --profile dev logs -f odoo-dev
```

### Créer un module personnalisé

```bash
./scripts/create-module.sh mon_module "Mon Module"
```

Ensuite, redémarrez Odoo et mettez à jour la liste des apps.

### Sauvegarder une base de données

```bash
./scripts/backup.sh dev
```

Les backups sont stockés dans `data/backups/{env}/`.

### Restaurer une base de données

```bash
./scripts/restore.sh dev data/backups/dev/odoo_dev_20260109_120000.sql.gz
```

## Développement

### Accéder au shell Odoo

```bash
cd docker
docker-compose --profile dev exec odoo-dev odoo shell -c /etc/odoo/odoo.conf -d odoo_dev
```

### Accéder à PostgreSQL

```bash
cd docker
docker-compose --profile dev exec db-dev psql -U odoo -d odoo_dev
```

### Mode Debug

L'environnement de développement a le mode debug activé par défaut:
- Hot reload automatique
- Port debugger: 5678 (pour VS Code ou PyCharm)

### Tests

```bash
cd docker
docker-compose --profile test exec odoo-test odoo -c /etc/odoo/odoo.conf --test-enable --stop-after-init -u mon_module
```

## Structure du Projet

```
odoo-app/
├── docker/                 # Configuration Docker
│   ├── Dockerfile         # Image Odoo 18 Community
│   ├── docker-compose.yml # Orchestration
│   └── *.sh               # Scripts utilitaires
├── config/                # Configurations Odoo par environnement
├── addons/                # Vos modules personnalisés
├── extra-addons/          # Modules tiers (OCA, etc.)
├── scripts/               # Scripts de gestion
├── data/                  # Données persistantes (git-ignored)
└── logs/                  # Logs applicatifs (git-ignored)
```

## Addons Communautaires (OCA)

Pour installer des modules OCA:

```bash
cd extra-addons
git clone https://github.com/OCA/web.git
cd ..
./scripts/stop.sh dev
./scripts/start.sh dev
```

Modules OCA populaires:
- [web](https://github.com/OCA/web) - Améliorations interface web
- [server-tools](https://github.com/OCA/server-tools) - Outils serveur
- [account-financial-reporting](https://github.com/OCA/account-financial-reporting) - Rapports financiers
- [reporting-engine](https://github.com/OCA/reporting-engine) - Moteur de rapports

## Sécurité

- Ne jamais commiter le fichier `.env`
- Utiliser des mots de passe forts (20+ caractères) pour la production
- Différents mots de passe par environnement
- En production:
  - Activer HTTPS (reverse proxy Nginx)
  - Désactiver `list_db`
  - Activer `proxy_mode`

## Troubleshooting

### PostgreSQL ne démarre pas

```bash
# Vérifier les logs
docker-compose --profile dev logs db-dev

# Supprimer les données et recommencer
rm -rf data/postgresql/dev/*
./scripts/start.sh dev
```

### Port déjà utilisé

```bash
# Trouver le processus
netstat -ano | findstr :8069

# Tuer le processus (PowerShell Admin)
Stop-Process -Id <PID> -Force
```

### Odoo ne démarre pas

```bash
# Vérifier la configuration
docker-compose --profile dev exec odoo-dev cat /etc/odoo/odoo.conf

# Rebuild l'image
cd docker
docker-compose build --no-cache
./scripts/start.sh dev
```

## Commandes Utiles

### Reconstruire les images

```bash
cd docker
docker-compose build --no-cache
```

### Nettoyer les volumes Docker

```bash
docker-compose down -v
```

### Accéder au conteneur

```bash
docker-compose --profile dev exec odoo-dev bash
```

### Mettre à jour un module

```bash
docker-compose --profile dev exec odoo-dev odoo -c /etc/odoo/odoo.conf -u mon_module --stop-after-init
docker-compose --profile dev restart odoo-dev
```

## Performance

Pour optimiser les performances:

1. Allouer suffisamment de RAM à Docker (8GB minimum, 16GB recommandé)
2. Placer le projet sur un SSD
3. Exclure les répertoires Docker de l'antivirus
4. Utiliser WSL 2 backend dans Docker Desktop

## Licence

Odoo Community Edition est sous licence LGPL-3.

## Support

Pour tout problème:
1. Vérifier les logs: `docker-compose --profile dev logs`
2. Consulter la documentation Odoo: https://www.odoo.com/documentation/18.0/
3. Communauté Odoo: https://www.odoo.com/forum

## Auteur

Votre Nom / Votre Entreprise
