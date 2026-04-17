# In your zsh-functions file
function kubectx_prompt() {
  local KUBECTX=$(kubectl config current-context 2>/dev/null)
  if [[ -n "$KUBECTX" ]]; then
    if [[ "$KUBECTX" == *"prod"* || "$KUBECTX" == *"production"* ]]; then
      echo "%{%F{red}%}(${KUBECTX})🚨%{%f%}"
    else
      echo "%{%F{yellow}%}(${KUBECTX})%{%f%}" # Example: yellow for non-prod
    fi
  fi
}

