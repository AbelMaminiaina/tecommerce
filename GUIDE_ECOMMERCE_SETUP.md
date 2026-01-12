# Guide de Configuration eCommerce - Odoo Community 18

Ce guide vous accompagne pas à pas pour créer une boutique en ligne fonctionnelle avec Odoo Community.

## 🎯 Ce que nous allons configurer

- ✅ Module Sales (Ventes)
- ✅ Module Website (Site Web)
- ✅ Module eCommerce (Boutique)
- ✅ Produits avec photos et variantes
- ✅ Modes de paiement
- ✅ Méthodes de livraison
- ✅ Thème et personnalisation

---

## 📋 Étape 1: Accès initial

### 1.1 Vérifier que Odoo fonctionne

Ouvrez votre navigateur : **http://localhost:8069**

Si c'est votre première connexion :
- **Email** : admin
- **Mot de passe** : admin (ou celui configuré dans votre `.env`)

### 1.2 Activer le mode développeur

1. Cliquez sur **Settings** (Paramètres) dans le menu principal
2. Descendez tout en bas de la page
3. Cliquez sur **Activate the developer mode** (Activer le mode développeur)

✅ Le mode développeur est actif quand vous voyez un 🐞 dans le coin supérieur droit

---

## 📦 Étape 2: Installation des modules

### 2.1 Installer Sales (Ventes)

1. Allez dans **Apps** (menu principal)
2. Recherchez "**Sales**" ou "**Ventes**"
3. Cliquez sur **Install** / **Activer**
4. Attendez l'installation (peut prendre 1-2 minutes)

✅ Vous verrez maintenant **Sales** dans le menu principal

### 2.2 Installer Website (Site Web)

1. Dans **Apps**, recherchez "**Website**"
2. Cliquez sur **Install** / **Activer**
3. Attendez l'installation

✅ Vous verrez maintenant **Website** dans le menu principal

### 2.3 Installer eCommerce

1. Dans **Apps**, recherchez "**eCommerce**" ou "**Commerce électronique**"
2. Cliquez sur **Install** / **Activer**
3. L'installation peut prendre 2-3 minutes (installe aussi les dépendances)

✅ Installation terminée quand vous voyez **Shop** dans le menu Website

---

## 🏢 Étape 3: Configuration de base de votre entreprise

### 3.1 Informations de l'entreprise

1. Allez dans **Settings** → **General Settings**
2. Section **Companies** :
   - **Company Name** : Nom de votre entreprise
   - **Address** : Adresse complète
   - **Phone** : Téléphone
   - **Email** : Email de contact
   - **Website** : URL de votre site
   - **Tax ID** / **VAT** : Numéro de TVA si applicable

3. Cliquez sur **Save** (Enregistrer)

### 3.2 Devise et langue

1. Toujours dans **Settings** → **General Settings**
2. Section **Localization** :
   - **Languages** : Installez les langues nécessaires (français, anglais, etc.)
   - **Currency** : EUR (Euro), USD (Dollar), etc.
   - **Date Format** : Choisissez votre format de date

3. Cliquez sur **Save**

---

## 🛒 Étape 4: Configuration des Produits

### 4.1 Créer des catégories de produits

1. Allez dans **Website** → **eCommerce** → **Products**
2. Cliquez sur **Product Categories** (ou via Configuration)
3. Créez vos catégories, par exemple :
   - Électronique
   - Vêtements
   - Accessoires
   - Alimentation

### 4.2 Créer vos premiers produits

1. Allez dans **Sales** → **Products** → **Products**
2. Cliquez sur **Create** / **Nouveau**

**Pour chaque produit, configurez :**

#### Informations générales
- **Product Name** : Nom du produit
- **Can be Sold** : ✅ Coché
- **Can be Purchased** : ✅ Coché si vous achetez ce produit
- **Product Type** :
  - Storable Product (produit stocké)
  - Consumable (consommable)
  - Service (service)

#### Prix
- **Sales Price** : Prix de vente TTC
- **Cost** : Prix de revient
- **Customer Taxes** : TVA applicable (ex: 20%)

#### eCommerce
Onglet **Sales** :
- ✅ **Published** : Cocher pour publier sur le site
- **Website** : Choisir votre site web
- **eCommerce Category** : Sélectionner la catégorie

#### Images
1. Cliquez sur l'icône caméra en haut à gauche
2. Téléchargez une image principale
3. Onglet **Sales** → **Extra Product Media** : Ajoutez plus d'images

#### Description eCommerce
Onglet **Sales** → **Description for the website** :
- Écrivez une description détaillée en HTML
- Ajoutez des bullet points pour les caractéristiques

#### Stock (si produit stocké)
Onglet **Inventory** :
- **On Hand Quantity** : Quantité en stock
- **Reordering Rules** : Règles de réapprovisionnement

### 4.3 Produits avec variantes (optionnel)

Pour créer des variantes (tailles, couleurs, etc.) :

1. Onglet **Attributes & Variants**
2. Cliquez sur **Add a line**
3. Créez un attribut (ex: "Taille")
4. Ajoutez des valeurs (S, M, L, XL)
5. Odoo créera automatiquement toutes les variantes
6. Définissez les prix et stocks pour chaque variante

---

## 💳 Étape 5: Configuration des paiements

### 5.1 Activer les moyens de paiement

1. Allez dans **Website** → **Configuration** → **Payment Providers**
2. Vous verrez les providers disponibles :
   - **Wire Transfer** (Virement bancaire) - Gratuit
   - **Paypal** - Nécessite un compte
   - **Stripe** - Nécessite un compte
   - **Authorize.net** - USA
   - Etc.

### 5.2 Configurer le virement bancaire (pour commencer)

1. Cliquez sur **Wire Transfer**
2. **State** : Published (Publié)
3. **Payment Journal** : Bank
4. Ajoutez vos coordonnées bancaires dans **Messages**
5. Cliquez sur **Save**

### 5.3 Configurer Stripe (recommandé pour production)

1. Créez un compte sur https://stripe.com
2. Récupérez vos clés API (Publishable key & Secret key)
3. Dans Odoo, cliquez sur **Stripe**
4. **State** : Enabled
5. **Stripe Publishable Key** : Votre clé publique
6. **Stripe Secret Key** : Votre clé secrète
7. **Webhook Secret** : Configurez le webhook
8. Cliquez sur **Save**

---

## 🚚 Étape 6: Configuration des livraisons

### 6.1 Créer des méthodes de livraison

1. Allez dans **Website** → **Configuration** → **Shipping Methods**
2. Cliquez sur **Create** / **Nouveau**

**Exemple 1 : Livraison standard**
- **Shipping Method Name** : Livraison Standard
- **Provider** : Fixed Price
- **Website** : Votre site
- **Fixed Price** : 5.00 EUR
- **Free if order amount is above** : 50.00 EUR (livraison gratuite au-dessus de 50€)

**Exemple 2 : Livraison express**
- **Shipping Method Name** : Livraison Express
- **Provider** : Fixed Price
- **Fixed Price** : 10.00 EUR

**Exemple 3 : Retrait en magasin**
- **Shipping Method Name** : Retrait en magasin
- **Provider** : Fixed Price
- **Fixed Price** : 0.00 EUR

3. Cliquez sur **Save** pour chaque méthode

### 6.2 Configurer les zones de livraison

Dans chaque méthode de livraison :
- Onglet **Destination** : Définissez les pays desservis
- Vous pouvez créer des règles différentes par pays

---

## 🎨 Étape 7: Personnalisation du site web

### 7.1 Accéder à votre site

1. Allez dans **Website** → **Go to Website**
2. Ou ouvrez directement : **http://localhost:8069**

### 7.2 Éditer le site

1. En étant connecté, cliquez sur **Edit** (Éditer) en haut à droite
2. L'éditeur de site s'ouvre

**Vous pouvez :**
- Ajouter/modifier des blocs de contenu (drag & drop)
- Modifier les textes directement
- Ajouter des images
- Créer de nouvelles pages

### 7.3 Personnaliser le thème

1. En mode édition, cliquez sur **Customize** (Personnaliser)
2. Vous pouvez modifier :
   - **Colors** : Couleurs principales
   - **Fonts** : Polices
   - **Header** : En-tête
   - **Footer** : Pied de page
   - **Effects** : Animations

### 7.4 Configurer le menu

1. En mode édition, cliquez sur **Edit Menu**
2. Ajoutez/supprimez des entrées de menu
3. Créez des sous-menus
4. Liez vers vos pages ou catégories de produits

### 7.5 Configurer la page d'accueil

1. Allez sur la page d'accueil
2. Cliquez sur **Edit**
3. Suggestions de blocs à ajouter :
   - **Banner** : Grande image d'accueil avec CTA
   - **Features** : Présentation de vos services
   - **Featured Products** : Produits mis en avant
   - **Categories** : Présentation des catégories
   - **Testimonials** : Témoignages clients
   - **Call to Action** : Bouton vers la boutique

---

## 🛍️ Étape 8: Configuration de la boutique

### 8.1 Accéder à la boutique

Allez sur : **http://localhost:8069/shop**

### 8.2 Personnaliser la page boutique

1. En mode édition sur /shop
2. Vous pouvez configurer :
   - **Layout** : Grille, liste
   - **Products per page** : Nombre de produits par page
   - **Sorting** : Options de tri
   - **Filters** : Filtres par catégorie, attributs, prix

### 8.3 Configuration du panier

1. **Website** → **Configuration** → **Settings**
2. Section **Shop - Checkout Process** :
   - **Cart** : Comportement du panier
   - **Checkout** : Options du processus de commande
   - **Abandoned Cart** : Email de relance (optionnel)

---

## 📧 Étape 9: Configuration des emails

### 9.1 Configuration SMTP (pour envoi d'emails)

1. Allez dans **Settings** → **Technical** → **Outgoing Mail Servers**
2. Créez un nouveau serveur SMTP :
   - **Description** : Gmail, Outlook, etc.
   - **SMTP Server** : smtp.gmail.com (pour Gmail)
   - **SMTP Port** : 587
   - **Connection Security** : TLS
   - **Username** : votre email
   - **Password** : mot de passe ou app password

3. Cliquez sur **Test Connection**

### 9.2 Templates d'emails

1. **Settings** → **Technical** → **Email Templates**
2. Personnalisez les templates :
   - Confirmation de commande
   - Confirmation d'expédition
   - Facture
   - Panier abandonné

---

## ✅ Étape 10: Test complet

### 10.1 Tester le parcours client

1. **Déconnectez-vous** d'Odoo
2. Allez sur **http://localhost:8069**
3. Parcourez votre site comme un client :
   - Naviguez dans les catégories
   - Consultez les pages produits
   - Ajoutez des produits au panier
   - Allez dans le panier
   - Procédez au checkout
   - Remplissez les informations de livraison
   - Choisissez le mode de livraison
   - Choisissez le mode de paiement
   - Confirmez la commande

### 10.2 Vérifier la commande dans le backend

1. **Reconnectez-vous** en admin
2. Allez dans **Sales** → **Orders**
3. Vous devriez voir la commande de test
4. Cliquez dessus pour voir les détails
5. **Confirm** la commande
6. Créez une **Delivery Order** (bon de livraison)
7. Validez la livraison
8. Créez une **Invoice** (facture)

---

## 🚀 Étape 11: Optimisations et modules additionnels

### 11.1 Modules recommandés

Dans **Apps**, installez ces modules utiles :

- **Website Blog** : Blog pour le SEO et contenu
- **Website Livechat** : Chat en direct
- **Website Google Map** : Intégration Google Maps
- **Sales Loyalty** : Programme de fidélité
- **Website Sale Comparison** : Comparaison de produits
- **Website Sale Wishlist** : Liste de souhaits
- **Inventory** : Gestion avancée des stocks

### 11.2 SEO (Référencement)

Pour chaque page et produit :
1. En mode édition, cliquez sur **Promote** → **Optimize SEO**
2. Configurez :
   - **Page Title** : Titre SEO
   - **Meta Description** : Description pour les moteurs de recherche
   - **Keywords** : Mots-clés
   - **URL Slug** : URL personnalisée

### 11.3 Analytics

1. **Website** → **Configuration** → **Settings**
2. Section **SEO** :
   - **Google Analytics Key** : Votre tracking ID
   - **Google Tag Manager Key** : Si vous utilisez GTM

---

## 📊 Étape 12: Tableau de bord et rapports

### 12.1 Dashboard Sales

- Allez dans **Sales** → **Reporting**
- Consultez les rapports :
  - **Sales Analysis** : Analyse des ventes
  - **Products** : Produits les plus vendus
  - **Customers** : Analyse clients
  - **Sales Teams** : Performance des équipes

### 12.2 Dashboard Website

- **Website** → **Reporting** → **Analytics**
- Consultez les statistiques :
  - Visiteurs
  - Pages vues
  - Taux de conversion
  - Paniers abandonnés

---

## 🔒 Étape 13: Sécurité et mise en production

### 13.1 Avant la mise en production

- [ ] Changez le mot de passe admin
- [ ] Configurez SSL/HTTPS
- [ ] Testez tous les parcours utilisateurs
- [ ] Vérifiez les emails sortants
- [ ] Testez les paiements (mode test)
- [ ] Configurez les sauvegardes automatiques
- [ ] Vérifiez les mentions légales
- [ ] Ajoutez CGV et politique de confidentialité
- [ ] Configurez Google Analytics
- [ ] Testez sur mobile

### 13.2 Configuration SSL (pour production)

Vous aurez besoin de :
- Un nom de domaine
- Un certificat SSL (Let's Encrypt gratuit)
- Un reverse proxy (Nginx ou Traefik)

---

## 🎓 Prochaines étapes d'apprentissage

### Développement de modules personnalisés

Créez vos propres fonctionnalités dans `addons/` :
- Nouveaux champs sur les produits
- Workflows personnalisés
- Intégrations avec services externes
- Thèmes personnalisés

### Documentation officielle

- https://www.odoo.com/documentation/18.0/
- https://www.odoo.com/forum/help-1

---

## 🆘 Problèmes courants

### Le site ne s'affiche pas
- Vérifiez que le module Website est installé
- Vérifiez que le site est publié : **Website → Configuration → Websites**

### Les produits n'apparaissent pas
- Vérifiez que "Published" est coché sur le produit
- Vérifiez que le produit a un prix
- Videz le cache : Ctrl+F5

### Les paiements ne fonctionnent pas
- Vérifiez que le payment provider est "Published"
- Vérifiez les clés API (Stripe, Paypal)
- Consultez les logs : **Settings → Technical → Logs**

### Les emails ne sont pas envoyés
- Vérifiez la configuration SMTP
- Testez la connexion SMTP
- Vérifiez les logs d'emails : **Settings → Technical → Emails**

---

## ✅ Checklist finale

- [ ] Modules installés : Sales, Website, eCommerce
- [ ] Informations entreprise configurées
- [ ] Au moins 5 produits créés avec images
- [ ] Catégories de produits créées
- [ ] Au moins 1 moyen de paiement activé
- [ ] Au moins 2 méthodes de livraison configurées
- [ ] Site web personnalisé (couleurs, logo, menu)
- [ ] Page d'accueil créée
- [ ] Emails SMTP configurés
- [ ] Test de commande complète réalisé
- [ ] SEO configuré sur les pages principales

---

**Félicitations ! Votre boutique eCommerce Odoo Community est prête ! 🎉**

Pour toute question ou problème, consultez la documentation Odoo ou la communauté.
