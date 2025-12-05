![Ansible](https://img.shields.io/badge/Automation-Ansible-blue?logo=ansible)
![Status](https://img.shields.io/badge/Build-Passing-brightgreen)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)
![Platform](https://img.shields.io/badge/Platform-Linux-lightgrey?logo=linux)
![Team](https://img.shields.io/badge/Team-YPF-orange)

#Déploiement Automatisé avec Ansible
Présentation du projet

Ce projet a été réalisé dans le cadre du cours d’Administration Linux.
L’objectif est de concevoir, automatiser et déployer une infrastructure complète à l’aide de Proxmox, GNS3, Linux, et Ansible.

Le déploiement inclut plusieurs services réseau obligatoires :

Serveur DHCP

Serveur DNS (zones directe + inverse)

Serveur Web

Serveur Base de données

Client Ubuntu Desktop en DHCP

Sauvegardes automatisées

Ainsi qu’un ou plusieurs services facultatifs selon l’équipe.

Architecture du Projet
Environnement de virtualisation

Le projet repose sur une machine physique exécutant :

Proxmox VE (hyperviseur type 1)

Une VM dédiée à GNS3 ESXi, utilisée pour simuler le réseau complet

RAM dynamique allouée : 2 Go → 30 Go

Tous les membres du groupe ont travaillé dans cet environnement partagé GNS3.

 Infrastructure réseau
Élément	Adresse IP	Rôle
dns01	10.0.0.2	DNS Master
dns02	10.0.0.3	DNS Slave
web01	10.0.0.4	Serveur Web
dhcp01	10.0.0.5	Serveur DHCP
db01	10.0.0.6	Serveur de Base de Données
clients	DHCP	Clients Ubuntu Desktop

Nom de domaine utilisé : ypf.lab

 Structure du dépôt Ansible
ansible-ypf/
## Structure du dépôt Ansible

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
 │   ├─ backup/
 │   ├─ bdd/
 │   ├─ common/
 │   ├─ dhcp/
 │   ├─ dns/
 │   └─ web/
 │
 └─ scripts/
```


Chaque rôle est entièrement automatisé via tasks, templates, handlers, et fichiers statiques.

 Détails des Rôles Ansible
- Rôle common

Configuration de base pour tous les serveurs :

Mise à jour

Paquets essentiels

Configuration réseau statique

Configuration DNS local

- Rôle dhcp

Déploie un serveur DHCP fonctionnel :

Installation d’ISC-DHCP

Configuration du dhcpd.conf

Broadcast et plage DHCP pour les clients Ubuntu

Redémarrage automatique via handler

- Rôle dns

Déploie un cluster DNS :

Installation de Bind9

Zone directe : ypf.lab

Zone inverse : 10.0.0.in-addr.arpa

Enregistrements A + PTR générés automatiquement

Transmission (slave) pour dns02

Forwarding vers DNS du CÉGEP

- Rôle web

Déploiement du serveur web :

Installation Apache/Nginx

Configuration VirtualHost

Déploiement d’une page web personnalisée

- Rôle bdd

Serveur MySQL / MariaDB :

Installation

Création base + utilisateur

Template my.cnf personnalisé

- Rôle backup

Sauvegarde MySQL automatisée :

Script de dump

Cron job via playbook install_backup_cron.yml

Rotation simple

- Playbook principal

Le playbook principal site.yml déploie l’ensemble de l’infrastructure :

ansible-playbook -i inventories/hosts playbooks/site.yml

- Tests & Validation
Service	Vérification
DHCP	ip a sur client – confirmation attribution dynamique
DNS	dig, nslookup, résolution locale et externe
Web	curl http://10.0.0.4
BDD	Connexion MySQL + requêtes
Sauvegardes	Validation du dump + restauration

Tous les tests ont été documentés dans le dossier tests de chaque rôle.

- Équipe
Nom	Rôle
Yahya	Ansible / DNS
Faycal	DHCP / Client
Faycal	Web / Documentation
Patrice	Backup / Base de Données


 Gestion du projet

Le suivi a été assuré via :

GitHub Project Board

Rencontre de suivi chaque lundi

Journal de bord ajouté dans ce README

 Journal de bord
- Semaine 1

Installation Proxmox

Mise en place de GNS3 ESXi

Création du dépôt GitHub

Planification initiale

- Semaine 2

Début des rôles Ansible (DNS, DHCP, Web)

Tests individuels sur VMs locales

- Semaine 3

Intégration complète sur GNS3

Mise en place du serveur de base de données

Tests croisés

- Semaine 4

Implémentation des sauvegardes

Nettoyage des rôles

Préparation de la présentation finale

- Présentation Finale

Lors de la présentation du 5 décembre, nous avons démontré :

Le fonctionnement du DHCP

La résolution DNS directe/inverse

L’accès web

Le fonctionnement de MySQL

Les sauvegardes automatisées

Le déploiement complet via Ansible

- Exécution complète

Pour tout déployer depuis zéro :

cd ansible-ypf
ansible-playbook -i inventories/hosts playbooks/site.yml
