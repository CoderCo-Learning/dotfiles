# CoderCo Dotfiles

Productivity aliases and functions for DevOps engineers. Part of the [CoderCo](https://skool.io/coderco) learning platform.

## Quick Start

1. Install: `curl -fsSL https://raw.githubusercontent.com/Coderco-Learning/dotfiles/main/install.sh | bash`
2. Restart terminal or run: `source ~/.bashrc` (or `~/.zshrc`)
3. Type `aliases` to see available shortcuts
4. Run `~/.coderco-dotfiles/verify.sh` to check your setup

## Installation

### One-Line Install (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/Coderco-Learning/dotfiles/main/install.sh | bash
```

### Manual Install

```bash
git clone https://github.com/Coderco-Learning/dotfiles.git ~/.coderco-dotfiles
cd ~/.coderco-dotfiles
./install.sh
```

### Activate

After installation, restart your terminal or run:

```bash
source ~/.bashrc   # Linux
# or
source ~/.zshrc    # macOS
```

The dotfiles will automatically load in all new terminal windows.

## What's Included

Over 100+ aliases and functions organized by category:

- **Git** - Commit, push, branch management
- **Docker** - Container operations
- **Kubernetes** - Pod management, logs, exec
- **Helm** - Chart operations
- **Terraform** - Infrastructure as code
- **AWS CLI** - Cloud resource management
- **Utilities** - File operations, encoding, networking

## Quick Reference

### Git

| Alias | Command |
|-------|---------|
| `g` | `git` |
| `gs` | `git status` |
| `ga` | `git add` |
| `gaa` | `git add --all` |
| `gc` | `git commit` |
| `gcm` | `git commit -m` |
| `gp` | `git push` |
| `gpl` | `git pull` |
| `gco` | `git checkout` |
| `gcb` | `git checkout -b` |
| `gl` | `git log --oneline -n 20` |
| `gd` | `git diff` |
| `gcap "msg"` | add all, commit, push |

### Docker

| Alias | Command |
|-------|---------|
| `d` | `docker` |
| `dc` | `docker compose` |
| `dps` | `docker ps` |
| `dpsa` | `docker ps -a` |
| `di` | `docker images` |
| `dex` | `docker exec -it` |
| `dlogs` | `docker logs -f` |
| `dprune` | `docker system prune -af` |
| `dsh <container>` | shell into container |
| `dbash <container>` | bash into container |

### Kubernetes

| Alias | Command |
|-------|---------|
| `k` | `kubectl` |
| `kgp` | `kubectl get pods` |
| `kgpa` | `kubectl get pods -A` |
| `kgs` | `kubectl get svc` |
| `kgd` | `kubectl get deployments` |
| `kgn` | `kubectl get nodes` |
| `kl` | `kubectl logs` |
| `klf` | `kubectl logs -f` |
| `kex` | `kubectl exec -it` |
| `ka` | `kubectl apply -f` |
| `kdel` | `kubectl delete` |
| `kwp` | `watch kubectl get pods` |
| `kln <partial>` | logs by partial pod name |
| `kexn <partial>` | exec by partial pod name |

### Helm

| Alias | Command |
|-------|---------|
| `hls` | `helm list` |
| `hlsa` | `helm list -A` |
| `hi` | `helm install` |
| `hu` | `helm upgrade` |
| `hui` | `helm upgrade --install` |
| `hd` | `helm delete` |
| `hs` | `helm status` |
| `hrepou` | `helm repo update` |
| `hshow` | `helm show values` |

### Terraform

| Alias | Command |
|-------|---------|
| `tf` | `terraform` |
| `tfi` | `terraform init` |
| `tfp` | `terraform plan` |
| `tfa` | `terraform apply` |
| `tfaa` | `terraform apply -auto-approve` |
| `tfd` | `terraform destroy` |
| `tff` | `terraform fmt` |
| `tfv` | `terraform validate` |
| `tfs` | `terraform state` |
| `tfsl` | `terraform state list` |
| `tfo` | `terraform output` |
| `tfw` | `terraform workspace` |

### AWS CLI

| Alias | Command |
|-------|---------|
| `awswho` | `aws sts get-caller-identity` |
| `ec2ls` | list EC2 instances |
| `s3ls` | `aws s3 ls` |
| `eksls` | list EKS clusters |
| `awsp <profile>` | set AWS_PROFILE |

### Utilities

| Alias/Function | Description |
|----------------|-------------|
| `mkcd <dir>` | mkdir and cd into it |
| `myip` | get public IP |
| `serve [port]` | quick HTTP server |
| `b64e <string>` | base64 encode |
| `b64d <string>` | base64 decode |
| `genpass [len]` | generate random password |
| `killport <port>` | kill process on port |
| `ports` | show listening ports |
| `extract <file>` | extract any archive |
| `path` | show PATH entries |

## Show All Aliases

After installation, type:

```bash
aliases
```

For the full list:

```bash
alias
```

## Customization

Want to add your own aliases? Edit:

```bash
~/.coderco-dotfiles/coderco.sh
```

### Enable Custom Prompt

To show git branch, k8s context, and AWS profile in your prompt, uncomment the prompt section at the bottom of `coderco.sh`.

## Install Development Tools (macOS)

For macOS users, we provide a `Brewfile` to install all development tools and dependencies:

### Prerequisites

```bash
# Install Homebrew if you don't have it
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install All Tools

```bash
# Clone the repo (if you haven't already)
git clone https://github.com/Coderco-Learning/dotfiles.git ~/.coderco-dotfiles
cd ~/.coderco-dotfiles

# Install all tools from Brewfile
brew bundle --file=Brewfile
```

This will install:
- **Development Tools**: Git, Node, Python, Go, Ruby, Rust
- **Infrastructure Tools**: Terraform, Kubernetes, Helm, Docker tools
- **Shell Tools**: Zsh, Oh My Zsh, Powerlevel10k, tmux
- **Desktop Apps**: VS Code, iTerm2, Chrome, Slack, etc.
- **VS Code Extensions**: All recommended extensions for DevOps

### Install Specific Categories

You can also install tools selectively by editing the `Brewfile` and removing sections you don't need.

### Verify Installation

After installation, run:

```bash
~/.coderco-dotfiles/verify.sh
```

## Verify Installation

Check that everything is working:

```bash
~/.coderco-dotfiles/verify.sh
```

This will show which tools are installed and ready to use.

## Uninstall

Remove the source line from your shell config:

```bash
# Remove this line from ~/.bashrc or ~/.zshrc:
[ -f ~/.coderco-dotfiles/coderco.sh ] && source ~/.coderco-dotfiles/coderco.sh
```

Then delete the directory:

```bash
rm -rf ~/.coderco-dotfiles
```

## Files

| File | Purpose |
|------|---------|
| `coderco.sh` | Main aliases and functions |
| `install.sh` | Installation script |
| `verify.sh` | Verify tool installation |
| `Brewfile` | Homebrew bundle file (macOS tools) |
| `CHEATSHEET.md` | Printable quick reference |

## Troubleshooting

**Aliases not working?**
- Make sure you restarted your terminal or ran `source ~/.bashrc` (or `~/.zshrc`)
- Check that the source line was added: `grep coderco ~/.bashrc` (or `~/.zshrc`)

**Installation issues?**
- Ensure you have bash installed
- Check that `~/.coderco-dotfiles/coderco.sh` exists
- Run the verify script to check your setup

## Contributing

Found a useful alias? Submit a PR.

## License

MIT

---

Made by [Mo Abukar](github.com/moabukar)
