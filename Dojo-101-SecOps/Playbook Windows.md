# **Playbook de correction de vulnérabilités**

## **Correction sous windows**


### **Liste des actions réalisé par le playbook** : 

| N°  | Action                                                      |
|-----|-------------------------------------------------------------|
| 1   | S'assurer que WinRM est configuré                           |
| 2   | Définir la politique de mot de passe                        |
| 3   | Désactiver le compte invité                                 |
| 4   | Désactiver NTLMv1                                           |
| 5   | Activer la pré-authentification Kerberos pour tous les comptes utilisateurs |
| 6   | S'assurer que tous les comptes administrateurs ont la pré-authentification Kerberos activée |
| 7   | Détecter les utilisateurs avec des droits administratifs indirects |
| 8   | Mesures de sécurité de base - Désactiver le compte administrateur par défaut |
| 9   | Mesures de sécurité de base - Activer le pare-feu            |
| 10  | Mesures de sécurité de base - Activer Windows Defender       |


### **Le playbook**

````

---
- name: Secure Windows Server 2022 with Active Directory
  hosts: windows
  gather_facts: no
  tasks:

     - name: Ensure WinRM is configured
       win_service:
          name: WinRM
          start_mode: auto
          state: started

     - name: Set password policy
       win_shell: |
         Import-Module ActiveDirectory
         Set-ADDefaultDomainPasswordPolicy -Identity "AIS.FR" -MinPasswordLength 12
       register: set_password_policy

     - name: Disable guest account
       win_user:
         name: guest
         state: absent

     - name: Disable NTLMv1
       win_shell: |
         Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name LmCompatibilityLevel -Value 5
       register: disable_ntlmv1

     - name: Enable Kerberos preauthentication for all user accounts
       win_shell: |
         Import-Module ActiveDirectory
         Get-ADUser -Filter * -Properties KerberosEncryptionType | Set-ADUser -KerberosEncryptionType AES128,AES256
       register: kerberos_pre_auth

     - name: Ensure all administrator accounts have Kerberos preauthentication enabled
       win_shell: |
         Import-Module ActiveDirectory
         Get-ADUser -Filter {memberof -recursiveMatch "CN=Administrateurs,CN=Builtin,DC=AIS,DC=FR"} -Properties   KerberosEncryptionType | Set-ADUser -KerberosEncryptionType AES128,AES256
       register: admin_kerberos_pre_auth

     - name: Detect users with indirect admin rights
       win_shell: |
         Import-Module ActiveDirectory
         Get-ADUser -Filter {memberof -recursiveMatch "CN=Administrateurs,CN=Builtin,DC=AIS,DC=FR"} -Properties MemberOf | Select-Object -Property SamAccountName, MemberOf
       register: indirect_admin_users

     - name: Basic security measures - Disable default administrator account
       win_user:
         name: Administrator
         state: absent

     - name: Basic security measures - Enable firewall
       win_feature:
         name: Windows-Defender
         state: present

     - name: Basic security measures - Enable Windows Defender
       win_shell: |
         Set-MpPreference -DisableRealtimeMonitoring $false

````

### **Preuve de fonctionnement** : 

![alt tag](https://github.com/Jrb62/Formation-AIS-et-DevOps/blob/main/screenshot/Capture%20d'%C3%A9cran%202024-06-07%20101838.png)