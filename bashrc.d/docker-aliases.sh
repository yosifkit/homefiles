alias drr='docker run -it --rm'
alias drd='docker run -it --rm debian:bullseye'
alias drmi='docker rmi'
alias dps='docker ps'
alias dpa='docker ps -a'

drmirepo() {
	dicker-images | grep -E "$1" | xargs --max-args=1 --no-run-if-empty docker rmi
}
dclean() {
	# remove stopped containers
	docker ps -aq | xargs --no-run-if-empty docker rm
}
dcleanvol() {
	# remove unused volumes
	docker volume ls | awk '/^local/ { print $2 }' | xargs --no-run-if-empty docker volume rm
	# TODO: use prune?
	#docker volume prune -f
}
ddangling() {
	# delete dangling images
	dicker-images --filter dangling=true | sort -u | xargs --no-run-if-empty docker rmi
	# TODO: use prune?
	#docker image prune -f
}
dnuke() {
	dicker-images | xargs --no-run-if-empty --verbose docker rmi
}

export BASHBREW_ARCH_NAMESPACES='
	amd64 = amd64,
	arm32v5 = arm32v5,
	arm32v6 = arm32v6,
	arm32v7 = arm32v7,
	arm64v8 = arm64v8,
	i386 = i386,
	ppc64le = ppc64le,
	s390x = s390x,
	windows-amd64 = winamd64
'

oi-list() {
	[ "$#" -gt 0 ] || set -- '--all'
	bashbrew list --repos "$@" | xargs --max-args=1 --max-procs="$(nproc)" bashbrew cat --format '
		{{- $ns := archNamespace arch -}}
		{{- range .Entries -}}
			{{- if not ($.SkipConstraints .) -}}
				{{- range $.Tags "" false . -}}
					{{- . -}}{{- "\n" -}}
					{{- if $ns -}}
						{{- $ns -}}/{{- . -}}{{- "\n" -}}
					{{- end -}}
				{{- end -}}
				{{- $.DockerFroms . | join "\n" -}}{{- "\n" -}}
				{{- $.DockerCacheName . -}}{{- "\n" -}}
			{{- end -}}
		{{- end -}}
	' 2> >(grep -vE '^skipping ') | sed -r 's!:[^@]+@!@!' # handle ELK oddities
}

dicker-images() {
	docker images --digests --no-trunc --format '
		{{- if (eq .Repository "<none>") -}}
			{{- .ID -}}
		{{- else -}}
			{{- .Repository -}}
			{{- if (eq .Tag "<none>") -}}
				{{- "@" -}}{{- .Digest -}}
			{{- else -}}
				{{- ":" -}}{{- .Tag -}}
			{{- end -}}
		{{- end -}}
	' "$@"
}

# list useless images (official-images that are no longer supported and other random images that are not mine)
dlist() {
	comm -13 <(oi-list | sort -u) <(dicker-images | grep -vE '^tianon|^yosifkit|^oisupport/bashbrew[:@]' | sort -u)
}

# remove unsupported/useless images
dtacticalnuke() {
	dlist | xargs -tn1 --no-run-if-empty docker rmi
}
