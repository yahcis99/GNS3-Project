![Ansible](https://img.shields.io/badge/Automation-Ansible-blue?logo=ansible)
![Status](https://img.shields.io/badge/Build-Passing-brightgreen)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)
![Platform](https://img.shields.io/badge/Platform-Linux-lightgrey?logo=linux)
![Team](https://img.shields.io/badge/Team-YPF-orange)

# Projet Ansible - Infrastructure Lab

##  Description
Playbooks Ansible pour déployer et gérer une infrastructure complète (Web, BDD, DNS, DHCP) dans un environnement de laboratoire.

##  Déploiement Rapide

### Prérequis
- Ansible
- Accès SSH aux hôtes cibles
- Privilèges sudo

### 1. Cloner et configurer

git clone [URL-DU-DEPOT]
cd ansible-lab

### 2. Éditer l'inventaire

nano innventories/host

### 3. Exécuter les playbooks

#### Déploiement complet
ansible-playbook playbooks/site.yml

#### Nettoyer la configuration
ansible-playbook  playbooks/cleanup.yml

##  Services Déployés

```
Élément    Adresse     IP	Rôle
dns01      10.0.0.2	   DNS Master
dns02      10.0.0.3	   DNS Slave
web01	    10.0.0.4	   Serveur Web
dhcp01	    10.0.0.5   	Serveur DHCP
db01	     10.0.0.6	   Serveur de Base de Données
```
Nom de domaine utilisé : ypf.lab

##  Structure du dépôt Ansible

```
ansible-ypf/
 ├─ ansible.cfg
 ├─ inventories/
 │   ├─ hosts
 │   └─ group_vars/
 │       ├─ dhcp.yml
 │       ├─ dns.yml
 │       └─ web.yml
 │
 ├─ playbooks/
 │   ├─ backup-mysql.yml
 │   ├─ cleanup.yml
 │   ├─ dhcp.yml
 │   ├─ dns.yml
 │   ├─ install_backup_cron.yml
 │   ├─ mysql.yml
 │   ├─ site.yml
 │   └─ web.yml
 │
 ├─ roles/
     ├─ backup/
     ├─ bdd/
     ├─ common/
     ├─ dhcp/
     ├─ dns/
     └─ web/
 
 
```

Chaque rôle est entièrement automatisé via tasks, templates, handlers, et fichiers statiques.

## Détails des Rôles Ansible
 
### Rôle common

Configuration de base pour tous les serveurs :

Mise à jour

Paquets essentiels

### Rôle dhcp

Déploie un serveur DHCP fonctionnel :

Installation d’ISC-DHCP

Configuration du dhcpd.conf

Broadcast et plage DHCP pour les clients Ubuntu

Redémarrage automatique via handler

### Rôle dns

Déploie deux serveur DNS :

Installation de Bind9

Zone directe : ypf.lab

Zone inverse : 10.0.0.in-addr.arpa

Enregistrements A + PTR 

Transmission (slave) pour dns02

Forwarding vers DNS du CÉGEP

### Rôle web

Déploiement du serveur web :

Installation Apache2

Configuration VirtualHost

Déploiement d’une page web personnalisée

### Rôle bdd

Serveur MySQL :

Installation

Template my.cnf personnalisé

### Rôle backup

Sauvegarde MySQL automatisée :

Script de dump

Cron job via playbook install_backup_cron.yml

Rotation simple

### Playbook principal

Le playbook principal site.yml déploie l’ensemble de l’infrastructure :

ansible-playbook playbooks/site.yml

### Tests & Validation
Service	Vérification
DHCP	ip a sur client – confirmation attribution dynamique
DNS	dig, nslookup, résolution locale et externe
Web	curl http://10.0.0.4
BDD	Connexion MySQL + requêtes
Sauvegardes	Validation du dump + restauration


### Équipe
Nom	Rôle
Yahya	Ansible / DNS
Faycal	DHCP / Client
Faycal	Web / Documentation
Patrice	Backup / Base de Données

