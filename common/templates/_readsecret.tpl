{{- define "common.read.secret" -}}
{{- $secret := (lookup "v1" "Secret" .Namespace .Name).data -}}
{{- if $secret -}}
  {{- if hasKey $secret .Key -}}
    {{- index $secret .Key | b64dec -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{- define "common.secret.exists" -}}
{{ $secret := (lookup "v1" "Secret" .Namespace .Name).data}}  
{{- if $secret -}}
  {{- if hasKey $secret .Key -}}
    {{- true -}}
  {{- else -}}
    {{- false -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{- define "common.secret.as.map" -}}
{{ $secret := (lookup "v1" "Secret" .Namespace .Name).data}}  
{{- if $secret -}}
  {{- $secret -}}
{{- else -}}
  {{- false -}}
{{- end -}}
{{- end -}}