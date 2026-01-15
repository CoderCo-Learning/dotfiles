# ============================================================================
# CoderCo Dotfiles - DevOps Aliases & Functions
# https://github.com/coderco-learning/dotfiles
# ============================================================================
# Source this file in your .bashrc or .zshrc:
#   source ~/.coderco-dotfiles/coderco.sh
# ============================================================================

# ----------------------------------------------------------------------------
# General Aliases
# ----------------------------------------------------------------------------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias h='history'
alias grep='grep --color=auto'
alias watch='watch -n 1'

# ----------------------------------------------------------------------------
# Git Aliases
# ----------------------------------------------------------------------------
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline -n 20'
alias glog='git log --graph --oneline --decorate'
alias grh='git reset --hard'
alias grs='git reset --soft'
alias gst='git stash'
alias gstp='git stash pop'
alias gcp='git cherry-pick'
alias gm='git merge'
alias gr='git rebase'

# Git - quick commit and push
alias gacp='git add --all && git commit -m'
gcap() {
    git add --all && git commit -m "$1" && git push
}

# ----------------------------------------------------------------------------
# Docker Aliases
# ----------------------------------------------------------------------------
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dex='docker exec -it'
alias dlogs='docker logs -f'
alias dprune='docker system prune -af'
alias dvprune='docker volume prune -f'
alias dstop='docker stop $(docker ps -q) 2>/dev/null'
alias dkill='docker kill $(docker ps -q) 2>/dev/null'
alias drmall='docker rm $(docker ps -aq) 2>/dev/null'
alias drmiall='docker rmi $(docker images -q) 2>/dev/null'

# Docker - run interactive container
drun() {
    docker run -it --rm "$@"
}

# Docker - shell into running container
dsh() {
    docker exec -it "$1" /bin/sh
}

# Docker - bash into running container
dbash() {
    docker exec -it "$1" /bin/bash
}

# Docker - show container resource usage
alias dstats='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"'

# Docker - build with tag
dbuild() {
    docker build -t "$1" .
}

# ----------------------------------------------------------------------------
# Kubernetes Aliases
# ----------------------------------------------------------------------------
alias k='kubectl'
alias kx='kubectx'
alias kn='kubens'

# Get resources
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods -A'
alias kgpw='kubectl get pods -o wide'
alias kgs='kubectl get svc'
alias kgsa='kubectl get svc -A'
alias kgd='kubectl get deployments'
alias kgda='kubectl get deployments -A'
alias kgn='kubectl get nodes'
alias kgnw='kubectl get nodes -o wide'
alias kgns='kubectl get namespaces'
alias kgi='kubectl get ingress'
alias kgia='kubectl get ingress -A'
alias kgcm='kubectl get configmap'
alias kgsec='kubectl get secrets'
alias kgpv='kubectl get pv'
alias kgpvc='kubectl get pvc'
alias kgall='kubectl get all'
alias kgalla='kubectl get all -A'
alias kgev='kubectl get events --sort-by=.lastTimestamp'

# Describe resources
alias kd='kubectl describe'
alias kdp='kubectl describe pod'
alias kds='kubectl describe svc'
alias kdd='kubectl describe deployment'
alias kdn='kubectl describe node'
alias kdi='kubectl describe ingress'

# Delete resources
alias kdel='kubectl delete'
alias kdelp='kubectl delete pod'
alias kdels='kubectl delete svc'
alias kdeld='kubectl delete deployment'
alias kdelf='kubectl delete -f'

# Logs
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias klt='kubectl logs --tail=100'
alias klft='kubectl logs -f --tail=100'
alias klp='kubectl logs -p'

# Exec into pods
alias kex='kubectl exec -it'
ksh() {
    kubectl exec -it "$1" -- /bin/sh
}
kbash() {
    kubectl exec -it "$1" -- /bin/bash
}

# Apply/Delete manifests
alias ka='kubectl apply -f'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kak='kubectl apply -k'

# Context and namespace
alias kcgc='kubectl config get-contexts'
alias kcuc='kubectl config use-context'
alias kccc='kubectl config current-context'
alias kcns='kubectl config set-context --current --namespace'

# Port forwarding
kpf() {
    kubectl port-forward "$1" "$2"
}

# Scale deployments
kscale() {
    kubectl scale deployment "$1" --replicas="$2"
}

# Restart deployment (rollout restart)
krestart() {
    kubectl rollout restart deployment "$1"
}

# Rollout status
krs() {
    kubectl rollout status deployment "$1"
}

# Watch pods
alias kwp='watch kubectl get pods'
alias kwpa='watch kubectl get pods -A'
alias kwn='watch kubectl get nodes'

# Get pod by partial name
kgpn() {
    kubectl get pods | grep "$1"
}

# Logs by partial pod name
kln() {
    kubectl logs -f "$(kubectl get pods | grep "$1" | head -1 | awk '{print $1}')"
}

# Exec into pod by partial name
kexn() {
    kubectl exec -it "$(kubectl get pods | grep "$1" | head -1 | awk '{print $1}')" -- /bin/sh
}

# Decode secret
ksecdec() {
    kubectl get secret "$1" -o jsonpath="{.data.$2}" | base64 -d
}

# Get all secrets decoded
ksecshow() {
    kubectl get secret "$1" -o json | jq -r '.data | to_entries[] | "\(.key): \(.value | @base64d)"'
}

# Run temporary debug pod
kdebug() {
    kubectl run debug-pod --rm -it --image=alpine -- /bin/sh
}

# ----------------------------------------------------------------------------
# Helm Aliases
# ----------------------------------------------------------------------------
alias hls='helm list'
alias hlsa='helm list -A'
alias hi='helm install'
alias hu='helm upgrade'
alias hui='helm upgrade --install'
alias hd='helm delete'
alias hun='helm uninstall'
alias hs='helm status'
alias hh='helm history'
alias hr='helm rollback'
alias hrepo='helm repo'
alias hrepou='helm repo update'
alias hrepoa='helm repo add'
alias hrepol='helm repo list'
alias hsearch='helm search repo'
alias hshow='helm show values'
alias hget='helm get values'
alias hgeta='helm get all'
alias hdry='helm install --dry-run --debug'

# Helm template
ht() {
    helm template "$@"
}

# ----------------------------------------------------------------------------
# Terraform Aliases
# ----------------------------------------------------------------------------
alias tf='terraform'
alias tfi='terraform init'
alias tfiu='terraform init -upgrade'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfaa='terraform apply -auto-approve'
alias tfd='terraform destroy'
alias tfda='terraform destroy -auto-approve'
alias tff='terraform fmt'
alias tffr='terraform fmt -recursive'
alias tfv='terraform validate'
alias tfs='terraform state'
alias tfsl='terraform state list'
alias tfss='terraform state show'
alias tfsm='terraform state mv'
alias tfsr='terraform state rm'
alias tfo='terraform output'
alias tfoj='terraform output -json'
alias tfw='terraform workspace'
alias tfwl='terraform workspace list'
alias tfws='terraform workspace select'
alias tfwn='terraform workspace new'
alias tfwd='terraform workspace delete'
alias tfr='terraform refresh'
alias tfim='terraform import'
alias tfc='terraform console'
alias tfg='terraform graph'

# Terraform plan with output file
tfpo() {
    terraform plan -out="${1:-tfplan}"
}

# Terraform apply from plan file
tfap() {
    terraform apply "${1:-tfplan}"
}

# Terraform targeted plan
tfpt() {
    terraform plan -target="$1"
}

# Terraform targeted apply
tfat() {
    terraform apply -target="$1"
}

# ----------------------------------------------------------------------------
# AWS CLI Aliases
# ----------------------------------------------------------------------------
alias awsid='aws sts get-caller-identity'
alias awswho='aws sts get-caller-identity'
alias awsregion='aws configure get region'
alias awsprofile='echo $AWS_PROFILE'
alias awsregions='aws ec2 describe-regions --query "Regions[].RegionName" --output table'

# EC2
alias ec2ls='aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PrivateIpAddress,PublicIpAddress,Tags[?Key==\`Name\`].Value|[0]]" --output table'
alias ec2running='aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].[InstanceId,Tags[?Key==\`Name\`].Value|[0],PrivateIpAddress]" --output table'
alias ec2stop='aws ec2 stop-instances --instance-ids'
alias ec2start='aws ec2 start-instances --instance-ids'
alias ec2terminate='aws ec2 terminate-instances --instance-ids'

# S3
alias s3ls='aws s3 ls'
alias s3mb='aws s3 mb'
alias s3rb='aws s3 rb'
alias s3cp='aws s3 cp'
alias s3mv='aws s3 mv'
alias s3rm='aws s3 rm'
alias s3sync='aws s3 sync'

# EKS
alias eksls='aws eks list-clusters --query "clusters" --output table'
alias eksupdate='aws eks update-kubeconfig --name'
alias eksdesc='aws eks describe-cluster --name'

# ECR
alias ecrlogin='aws ecr get-login-password | docker login --username AWS --password-stdin $(aws sts get-caller-identity --query Account --output text).dkr.ecr.$(aws configure get region).amazonaws.com'
alias ecrls='aws ecr describe-repositories --query "repositories[].repositoryName" --output table'

# Lambda
alias lambdals='aws lambda list-functions --query "Functions[*].[FunctionName,Runtime,MemorySize]" --output table'
alias lambdainvoke='aws lambda invoke --function-name'

# CloudFormation
alias cfnls='aws cloudformation list-stacks --query "StackSummaries[?StackStatus!=\`DELETE_COMPLETE\`].[StackName,StackStatus]" --output table'
alias cfndesc='aws cloudformation describe-stacks --stack-name'
alias cfnevents='aws cloudformation describe-stack-events --stack-name'

# IAM
alias iamuser='aws iam get-user'
alias iamusers='aws iam list-users --query "Users[].UserName" --output table'
alias iamroles='aws iam list-roles --query "Roles[].RoleName" --output table'

# Logs
alias cwlogs='aws logs describe-log-groups --query "logGroups[].logGroupName" --output table'
alias cwtail='aws logs tail'

# Set AWS profile
awsp() {
    export AWS_PROFILE="$1"
    echo "AWS_PROFILE set to: $AWS_PROFILE"
}

# Set AWS region
awsr() {
    export AWS_DEFAULT_REGION="$1"
    echo "AWS_DEFAULT_REGION set to: $AWS_DEFAULT_REGION"
}

# ----------------------------------------------------------------------------
# Utility Functions
# ----------------------------------------------------------------------------

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Find file by name
ff() {
    find . -type f -name "*$1*"
}

# Find directory by name
fd() {
    find . -type d -name "*$1*"
}

# Find and grep
fg() {
    find . -type f -name "$1" -exec grep -l "$2" {} \;
}

# Grep recursively
gr() {
    grep -rn "$1" .
}

# Extract various archive formats
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Show PATH entries, one per line
alias path='echo $PATH | tr ":" "\n"'

# Get public IP
alias myip='curl -s ifconfig.me'
alias myipv='curl -s ifconfig.me && echo ""'

# Get local IP
alias localip="hostname -I | awk '{print \$1}'"

# Quick HTTP server in current directory
serve() {
    python3 -m http.server "${1:-8000}"
}

# JSON pretty print
alias json='python3 -m json.tool'

# JSON pretty print from clipboard (macOS)
jsonclip() {
    pbpaste | python3 -m json.tool
}

# URL encode/decode
urlencode() {
    python3 -c "import urllib.parse; print(urllib.parse.quote('$1'))"
}

urldecode() {
    python3 -c "import urllib.parse; print(urllib.parse.unquote('$1'))"
}

# Base64 encode/decode
b64e() {
    echo -n "$1" | base64
}

b64d() {
    echo "$1" | base64 -d && echo ""
}

# Generate random password
genpass() {
    openssl rand -base64 "${1:-32}" | tr -d '=' | head -c "${1:-32}" && echo ""
}

# Generate UUID
genuuid() {
    cat /proc/sys/kernel/random/uuid 2>/dev/null || uuidgen
}

# Quick timestamp
alias timestamp='date +%Y%m%d%H%M%S'
alias datestamp='date +%Y-%m-%d'
alias now='date "+%Y-%m-%d %H:%M:%S"'

# Size of current directory
alias dirsize='du -sh'
alias dirsizes='du -sh */ | sort -h'

# Find large files
largef() {
    find . -type f -size +"${1:-100M}" -exec ls -lh {} \; 2>/dev/null
}

# Kill process by port
killport() {
    lsof -ti:"$1" | xargs kill -9 2>/dev/null
}

# Show listening ports
alias ports='netstat -tulanp 2>/dev/null || ss -tulanp 2>/dev/null || lsof -i -P -n | grep LISTEN'

# Disk usage
alias df='df -h'
alias du='du -h'

# Memory usage
alias free='free -h'

# Process list
alias psg='ps aux | grep -v grep | grep'

# Weather
weather() {
    curl -s "wttr.in/${1:-}"
}

# Cheat sheet
cheat() {
    curl -s "cheat.sh/$1"
}

# Man pages with colours
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    command man "$@"
}

# ----------------------------------------------------------------------------
# Prompt Customisation (optional - uncomment to enable)
# ----------------------------------------------------------------------------
# Shows: directory, git branch, k8s context, aws profile

# coderco_prompt() {
#     local git_branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
#     local k8s_context=$(kubectl config current-context 2>/dev/null)
#     local aws_profile=${AWS_PROFILE:-default}
#     
#     PS1="\[\033[36m\]\w\[\033[0m\]"
#     [ -n "$git_branch" ] && PS1+=" \[\033[33m\]($git_branch)\[\033[0m\]"
#     [ -n "$k8s_context" ] && PS1+=" \[\033[35m\][k8s:$k8s_context]\[\033[0m\]"
#     [ "$aws_profile" != "default" ] && PS1+=" \[\033[32m\][aws:$aws_profile]\[\033[0m\]"
#     PS1+="\n$ "
# }
# PROMPT_COMMAND=coderco_prompt

# ----------------------------------------------------------------------------
# Completion (if available)
# ----------------------------------------------------------------------------

# kubectl completion
if command -v kubectl &> /dev/null; then
    if [ -n "$BASH_VERSION" ]; then
        source <(kubectl completion bash 2>/dev/null)
        complete -o default -F __start_kubectl k
    elif [ -n "$ZSH_VERSION" ]; then
        source <(kubectl completion zsh 2>/dev/null)
    fi
fi

# helm completion
if command -v helm &> /dev/null; then
    if [ -n "$BASH_VERSION" ]; then
        source <(helm completion bash 2>/dev/null)
    elif [ -n "$ZSH_VERSION" ]; then
        source <(helm completion zsh 2>/dev/null)
    fi
fi

# terraform completion
if command -v terraform &> /dev/null; then
    complete -C terraform terraform 2>/dev/null
    complete -C terraform tf 2>/dev/null
fi

# aws completion
if command -v aws_completer &> /dev/null; then
    complete -C aws_completer aws 2>/dev/null
fi

# ----------------------------------------------------------------------------
# Welcome message (only on first load, not in every new shell)
# ----------------------------------------------------------------------------
if [ -z "${CODERCO_DOTFILES_LOADED:-}" ]; then
    export CODERCO_DOTFILES_LOADED=1
    # Silent by default - users can type 'aliases' when needed
fi

# Show all aliases (quick reference)
aliases() {
    echo "=== CoderCo Aliases Quick Reference ==="
    echo ""
    echo "Git:        g gs ga gaa gc gcm gp gpl gco gcb gl gd gcap"
    echo "Docker:     d dc dps dpsa di dex dlogs dprune dsh dbash"
    echo "Kubernetes: k kg kgp kgpa kgs kgd kgn kl klf kex ka kdel kwp kln kexn"
    echo "Helm:       hls hlsa hi hu hui hd hs hrepou hshow"
    echo "Terraform:  tf tfi tfp tfa tfaa tfd tfs tfsl tfo tfw"
    echo "AWS:        awswho awsp ec2ls s3ls eksls ecrlogin"
    echo "Utils:      mkcd myip serve b64e b64d genpass killport ports"
    echo ""
    echo "Full list:  alias | grep <term>"
    echo "Details:    ~/.coderco-dotfiles/coderco.sh"
    echo ""
    echo "Verify setup: ~/.coderco-dotfiles/verify.sh"
}
