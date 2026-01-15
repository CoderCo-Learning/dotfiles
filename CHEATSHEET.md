# CoderCo Aliases Cheat Sheet

Print this out and keep it handy.

## Git

| Alias | Command | Alias | Command |
|-------|---------|-------|---------|
| `g` | `git` | `gp` | `git push` |
| `gs` | `git status` | `gpl` | `git pull` |
| `ga` | `git add` | `gco` | `git checkout` |
| `gaa` | `git add --all` | `gcb` | `git checkout -b` |
| `gcm` | `git commit -m` | `gl` | `git log --oneline` |
| `gcap` | add, commit, push | `gd` | `git diff` |

## Docker

| Alias | Command | Alias | Command |
|-------|---------|-------|---------|
| `d` | `docker` | `dex` | `docker exec -it` |
| `dc` | `docker compose` | `dlogs` | `docker logs -f` |
| `dps` | `docker ps` | `dprune` | `docker system prune -af` |
| `dpsa` | `docker ps -a` | `dsh` | shell into container |
| `di` | `docker images` | `dbash` | bash into container |

## Kubernetes

| Alias | Command | Alias | Command |
|-------|---------|-------|---------|
| `k` | `kubectl` | `kl` | `kubectl logs` |
| `kgp` | `kubectl get pods` | `klf` | `kubectl logs -f` |
| `kgpa` | `kubectl get pods -A` | `kex` | `kubectl exec -it` |
| `kgs` | `kubectl get svc` | `ka` | `kubectl apply -f` |
| `kgd` | `kubectl get deploy` | `kdel` | `kubectl delete` |
| `kgn` | `kubectl get nodes` | `kwp` | `watch kubectl get pods` |
| `kdp` | `kubectl describe pod` | `kln` | logs by partial name |

## Helm

| Alias | Command | Alias | Command |
|-------|---------|-------|---------|
| `hls` | `helm list` | `hs` | `helm status` |
| `hlsa` | `helm list -A` | `hh` | `helm history` |
| `hi` | `helm install` | `hr` | `helm rollback` |
| `hu` | `helm upgrade` | `hrepou` | `helm repo update` |
| `hui` | `helm upgrade --install` | `hshow` | `helm show values` |

## Terraform

| Alias | Command | Alias | Command |
|-------|---------|-------|---------|
| `tf` | `terraform` | `tfa` | `terraform apply` |
| `tfi` | `terraform init` | `tfaa` | `terraform apply -auto-approve` |
| `tfp` | `terraform plan` | `tfd` | `terraform destroy` |
| `tfv` | `terraform validate` | `tfsl` | `terraform state list` |
| `tff` | `terraform fmt` | `tfo` | `terraform output` |

## AWS

| Alias | Command |
|-------|---------|
| `awswho` | `aws sts get-caller-identity` |
| `awsp` | set AWS_PROFILE |
| `ec2ls` | list EC2 instances |
| `s3ls` | `aws s3 ls` |
| `eksls` | list EKS clusters |
| `ecrlogin` | docker login to ECR |

## Utilities

| Alias | Command | Alias | Command |
|-------|---------|-------|---------|
| `mkcd` | mkdir and cd | `myip` | public IP |
| `serve` | HTTP server | `ports` | listening ports |
| `b64e` | base64 encode | `genpass` | random password |
| `b64d` | base64 decode | `extract` | any archive |

---

Quick reference: `aliases`  
Full list: `alias`

https://skool.io/coderco
