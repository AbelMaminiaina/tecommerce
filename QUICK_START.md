# Quick Start - Démarrage Rapide eCommerce

## 🚀 Démarrage en 5 minutes

### Étape 1: Accéder à Odoo
```
URL: http://localhost:8069
Email: admin
Password: admin (ou votre mot de passe configuré)
```

### Étape 2: Installer les modules essentiels

1. Allez dans **Apps**
2. Installez dans cet ordre :
   - **Sales** (Ventes)
   - **Website** (Site Web)
   - **eCommerce** (Commerce électronique)

⏱️ Temps d'installation total : ~3-5 minutes

### Étape 3: Activer le mode développeur

1. **Settings** → Descendez en bas
2. Cliquez sur **Activate the developer mode**

### Étape 4: Créer vos premiers produits

1. **Sales** → **Products** → **Create**
2. Remplissez :
   - Nom du produit
   - Prix de vente
   - Cochez "Published" dans l'onglet Sales
   - Ajoutez une image

### Étape 5: Visiter votre boutique

```
http://localhost:8069/shop
```

---

## 📦 Configuration avec données de démonstration

Si vous voulez tester rapidement avec des données d'exemple :

### Option 1: Installation avec démo

Lors de la création de la base de données :
- ✅ Cochez "Load demonstration data"
- Odoo créera automatiquement des produits, clients, commandes d'exemple

### Option 2: Base vierge (recommandé pour production)

- ⬜ Ne cochez PAS "Load demonstration data"
- Créez vos propres données

---

## 🎯 URLs importantes

| Description | URL |
|-------------|-----|
| Backend admin | http://localhost:8069 |
| Boutique | http://localhost:8069/shop |
| Page d'accueil | http://localhost:8069 |
| Mon compte | http://localhost:8069/my |
| Panier | http://localhost:8069/shop/cart |
| Contact | http://localhost:8069/contactus |

---

## 🔑 Identifiants par défaut

**Admin**
- Email: `admin`
- Password: Voir votre fichier `.env` → `ODOO_ADMIN_PASSWORD_DEV`

**Portal User (pour tester côté client)**
- Créez un utilisateur portal dans **Settings → Users & Companies → Users**

---

## ⚡ Commandes Docker utiles

```bash
# Démarrer l'environnement
cd docker
docker compose --profile dev up -d

# Arrêter l'environnement
docker compose --profile dev down

# Voir les logs
docker compose --profile dev logs -f odoo-dev

# Redémarrer Odoo
docker compose --profile dev restart odoo-dev

# Accéder au shell du conteneur
docker exec -it odoo-dev bash

# Voir les modules installés
docker exec odoo-dev ls /opt/odoo/odoo/addons | wc -l
```

---

## 📚 Documentation complète

Pour une configuration détaillée étape par étape, consultez :
- **GUIDE_ECOMMERCE_SETUP.md** - Guide complet de configuration
- **BUILD_ENTERPRISE.md** - Installation Odoo Enterprise
- **ENTERPRISE_LICENSE.md** - Activation de la licence Enterprise

---

## 🆘 Problèmes courants

### Odoo ne démarre pas
```bash
# Vérifier les logs
docker compose --profile dev logs odoo-dev

# Vérifier que PostgreSQL est démarré
docker compose --profile dev ps
```

### Impossible de se connecter
- Vérifiez votre mot de passe dans `.env`
- Password par défaut: `admin`

### Page blanche
- Videz le cache : Ctrl+F5
- Vérifiez les logs Docker

### Modules manquants
- Vérifiez que vous êtes dans **Apps** et non **Main Dashboard**
- Retirez les filtres de recherche dans Apps

---

## 🎓 Ressources d'apprentissage

- Documentation Odoo 18: https://www.odoo.com/documentation/18.0/
- Forum Odoo: https://www.odoo.com/forum/help-1
- GitHub Odoo: https://github.com/odoo/odoo
- Tutoriels YouTube: Recherchez "Odoo 18 tutorial"

---

## ✅ Checklist de démarrage rapide

- [ ] Odoo accessible sur http://localhost:8069
- [ ] Modules Sales, Website, eCommerce installés
- [ ] Mode développeur activé
- [ ] Au moins 1 produit créé
- [ ] Produit publié et visible sur /shop
- [ ] Test d'ajout au panier réussi

**Temps estimé: 10-15 minutes** ⏱️

---

Bon développement ! 🚀
