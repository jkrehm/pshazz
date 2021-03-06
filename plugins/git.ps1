try { gcm git -ea stop > $null } catch { return }

function pshazz:git:init {
	$git = $global:pshazz.theme.git

	$dirty = $git.prompt_dirty

	if(!$dirty) { $dirty = "*" } # default

	$global:pshazz.git = @{
		prompt_dirty = $dirty
	}

	$global:pshazz.completions.git = resolve-path "$psscriptroot\..\libexec\git-complete.ps1"
}

function global:pshazz:git:prompt {
	$vars = $global:pshazz.prompt_vars

	try { $ref = git symbolic-ref HEAD } catch { }
	if($ref) {
		$vars.git_branch = $ref -replace '^refs/heads/', '' # branch name
		try { $status = git status --porcelain } catch { }
		if($status) {

			$vars.git_dirty = $global:pshazz.git.prompt_dirty
		}
	}
}