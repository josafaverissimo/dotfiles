export def main [] {

}

export def logs [path: string = "."] {
  git log --pretty=%h»¦«%aN»¦«%s»¦«%aD $path
    | lines
    | split column "»¦«" sha1 committer desc merged_at
}

export def contributors [path: string = "."] {
  git log --pretty=%h»¦«%aN»¦«%s»¦«%aD $path
    | lines 
    | split column "»¦«" sha1 committer desc merged_at 
    | histogram committer merger 
    | sort-by merger 
    | reverse
}
