#  Limiteur de Consommation Internet (PowerShell)

##  Description
Ce projet est un script PowerShell permettant de surveiller la **consommation réseau locale** et de **désactiver automatiquement la connexion Internet** lorsque la limite définie est atteinte (50 Go par défaut).

---

##  Fonctionnalités

-  Surveillance en temps réel du trafic réseau
-  Calcul de la consommation (en Go)
-  Vérification toutes les 5 secondes
-  Coupure automatique de la connexion réseau
-  Détection automatique de l’interface active

---

##  Fonctionnement

1. Définition de la limite :
   ```powershell
   $limitGB = 50
   ```

2. Détection de l’interface réseau active :
   ```powershell
   Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
   ```

3. Calcul de la consommation :
   - Somme des données envoyées et reçues
   - Conversion en Go

4. Surveillance continue :
   ```powershell
   while ($true)
   ```

5. Si la limite est atteinte :
   - Désactivation de la carte réseau
   ```powershell
   Disable-NetAdapter
   ```

---

##  Utilisation

1. Ouvrir **PowerShell en mode administrateur**
2. Copier et exécuter le script :
   ```powershell
   .\script.ps1
   ```

3. Le script affiche en temps réel :
   ```
   Consommation : X GB
   ```

4. Une fois la limite atteinte :
   ```
   Limite atteinte (50 GB). Déconnexion...
   ```

---

##  Structure du code

- `$limitGB` → Limite de consommation
- `$interface` → Interface réseau utilisée
- `Get-NetAdapterStatistics` → Récupération des données réseau
- `while` → Boucle de surveillance
- `Disable-NetAdapter` → Coupure réseau

---

##  Prérequis

- Windows
- PowerShell 5.1 ou supérieur
- Droits administrateur

---

##  Limites

-  Mesure uniquement la consommation **locale du PC**
-  Le compteur se réinitialise à chaque lancement
-  Ne correspond pas toujours aux données de ton fournisseur Internet
-  Fonctionne sur une seule interface réseau

---

##  Améliorations possibles

-  Sauvegarde de la consommation dans un fichier
-  Notification avant coupure (ex : 45 Go)
-  Réactivation automatique du réseau
-  Limitation mensuelle persistante
-  Sélection manuelle de l’interface réseau

---

##  Licence

Projet libre — modifiable et utilisable selon tes besoins.
