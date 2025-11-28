# Infrastructure Deployment

A training terraform and ansible project as part of the Yandex course. This project creates a VM in Yandex Cloud using Terraform
and deploys the application (backend + frontend) using Ansible.

---

## Setting up secrets and access

### SSH-keys

If there are no keys, create:

```bash
ssh-keygen -t rsa -b 4096 -C "you@example.com"
```

You must have keys for admin and ansible users.

```hcl
public_key_path = "~/.ssh/id_rsa.pub"
```

### Yandex Cloud Token

Create file `terraform.tfvars`:

```hcl
cloud_id    = "YOUR_CLOUD_ID"
folder_id   = "YOUR_FOLDER_ID"
image_id    = "YOUR_IMAGE_ID"
zone        = "YOUR_ZONE"
```

You also need to create the Token and other environment variables. For more information, see the [Yndex Cloud documentation](https://yandex.cloud/ru/docs).

---

## Step 1 — Raise the infrastructure

From `terraform/`:

```bash
terraform init
terraform apply -auto-approve
```

After execution, Terraform outputs the **IP address of the created VM**
— it will automatically be included in the Ansible inventory.

---

## Step 2 — Install the app via Ansible

From `ansible/`:

### Check that the host is available:

```bash
ansible all -i inventory -m ping
```

### Launch a full deployment:

You need to create an ansible-vault for the login and password of the nexus server.
```bash 
nexus_repo_user: ...
nexus_repo_pass: ...
```

```bash
ansible-playbook playbook.yaml -i inventory --ask-vault-pass
```

> You will be asked to enter the password from `ansible-vault`,
> because the login/password of the Nexus is stored in `group_vars/all/vault.yml`

---

## Checking the result

After successful deployment: `http://<VM_IP>/#`

---

## Removing infrastructure

When everything is checked, you can delete the VM.:

```bash
terraform destroy -auto-approve
```



