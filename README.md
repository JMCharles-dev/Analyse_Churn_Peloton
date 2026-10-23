# Analyse_Churn_Peloton
Analyse du churn client et modèle prédictif (SQL, Python, Tableau) d'une application fitness


Ce projet analyse la perte d’abonnés des membres de l'application Peloton sur une période de 17 mois. L'objectif est d'identifier les facteurs clés du churn et de proposer un modèle prédictif couplé à une stratégie de rétention ciblée.

**🎯 Contexte & objectif**

Ma mission est de diagnostiquer les causes profondes de ce churn global, de segmenter les comportements des utilisateurs à risque, et de soumettre des recommandations stratégiques à la direction pour sécuriser le début de l'année 2026.

**📊 Données**

Le projet s'appuie sur deux sources de données interconnectées :

- `subscriptions` (**4 200 clients**) : Profils des utilisateurs (âge, type d'appareil, type et niveau d’offre, prix, canal d'acquisition, date d'inscription/résiliation, raison de résiliation).
- `usage` (**30 525 lignes**) : Historique des activités mensuelles de chaque client.
- *Clé de jointure :* `customer_id`

**🛠️ Outils**

- **SQL (BigQuery) :** Extraction, agrégation et préparation des bases d'usage et de souscription.
- **Python (Pandas, Scikit-Learn) :** Nettoyage, analyse exploratoire et modélisation prédictive.
- **Tableau :** Création du dashboard d'aide à la décision pour la direction.

**📁 Démarche**

1. **Nettoyage & Contrôle qualité :** Traitement des valeurs manquantes, alignement des dates et vérification de la cohérence des jointures.
2. **Analyse Exploratoire :** Profil des clients partis, analyse de l'activité et cartographie de la saisonnalité temporelle.
3. **Modèle Prédictif :** Entraînement d'une régression logistique pour scorer le risque de churn de chaque client dès son premier mois.

**🔑 Résultats clés**

<img width="1220" height="806" alt="Dashboard" src="https://github.com/user-attachments/assets/5b4665be-6cbd-4102-b56e-842396920d51" />

- **Un Churn Critique :** Le taux de churn global atteint **42%**. Le problème est structurel (homogène sur l’âge, le type d'appareil et le niveau d’offre).
- **La Fracture de l'Acquisition :** Les offres promotionnelles affichent 50% de churn, contre 34% pour le parrainage. Un écart qui suggère que les clients acquis par recommandation ont un engagement plus durable.
- **Le Signal Faible de l'Inactivité :** Les clients qui résilient sont **40% moins actifs** dès leur premier mois. De plus, **40% du churn total** se produit durant les 3 premiers mois d’abonnement.
- **Performance du Modèle :** La régression logistique prédit le risque de churn avec une exactitude de 69%, confirme les facteurs identifiés dans l’analyse de comportement et d'usage et apporte une précision : c’est la régularité des séances, plus que le temps passé, qui protège le mieux du risque de churn.
<img width="787" height="586" alt="image" src="https://github.com/user-attachments/assets/81fdc002-7abd-4570-b081-3bd1a2553c4e" />


**💡 Recommandations**

- **Pivot Budgétaire :** Réduire le budget des offres promotionnelles d'entrée et le réallouer vers le parrainage.
- Déclencher une campagne automatisée de réengagement (coaching, rappels) dès les premières semaines pour tout client sous le seuil moyen d'activité.
- **Parrainage Qualifié :** Restreindre l'accès au programme de parrainage aux membres ayant 3 à 6 mois d'ancienneté et ayant atteint leurs objectifs de séances initiaux.

**📂 Contenu du repo** 

- [Voir le notebook complet](notebook.ipynb) : nettoyage, analyse et modélisation
- [Voir requêtes SQL](requêtes.sql) : requetes sql :
- [Voir Dashboard interactif sur Tableau Public](https://public.tableau.com/views/AnalyseduchurndePeloton/Tableaudebord1?:language=fr-FR&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) : Lien vers le Dashboard Tableau Public
- [Voir Datasets](https://www.datacareerschool.com/datalabs/customer-churn-analysis)
