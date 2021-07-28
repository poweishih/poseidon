{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "mysql.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mysql.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Generate chart secret name
*/}}
{{- define "mysql.secretName" -}}
{{ default (include "mysql.fullname" .) .Values.existingSecret }}
{{- end -}}

{{/*
==== Image path config ====
*/}}

{{/*
Return the proper MySQL image name
*/}}
{{- define "mysql.image" -}}
{{- $repositoryName := .Values.image -}}
{{- $tag := .Values.imageTag | toString -}}
{{- if .Values.global.imageRegistry }}
    {{- printf "%s/%s:%s" .Values.global.imageRegistry $repositoryName $tag -}}
{{- else -}}
    {{- printf "%s:%s" $repositoryName $tag -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper Busybox image name
*/}}
{{- define "mysql.busybox.image" -}}
{{- $repositoryName := .Values.busybox.image -}}
{{- $tag := .Values.busybox.tag | toString -}}
{{- if .Values.global.imageRegistry }}
    {{- printf "%s/%s:%s" .Values.global.imageRegistry $repositoryName $tag -}}
{{- else -}}
    {{- printf "%s:%s" $repositoryName $tag -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper Metric image name
*/}}
{{- define "mysql.metrics.image" -}}
{{- $repositoryName := .Values.metrics.image -}}
{{- $tag := .Values.metrics.imageTag | toString -}}
{{- if .Values.global.imageRegistry }}
    {{- printf "%s/%s:%s" .Values.global.imageRegistry $repositoryName $tag -}}
{{- else -}}
    {{- printf "%s:%s" $repositoryName $tag -}}
{{- end -}}
{{- end -}}

{{/*
===========================
*/}}
