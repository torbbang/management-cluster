# Proxmox Talos OS single node cluster

I manage most of my K8S clusters through the [Cluster API](). 
This terraform module contains the basic configuration of my single node management cluster on Proxmox.

You can supply the vars required for the proxmox provider with the following cli flag:
```
-var='pve={"url":"...","ssh_user":"...","ssh_key": "...","token_id":"...","token_value":"..."}'
```
