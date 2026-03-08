#!/usr/bin/env nu

def main [
    --repo-root: string 
    --alejandra-bin: string
] {
    let nix_fmt = (^$alejandra_bin --check $repo_root | complete)

    if $nix_fmt.exit_code != 0 {
        error make {
            msg: "Alejandra formatting check failed"
        }
    }
}
