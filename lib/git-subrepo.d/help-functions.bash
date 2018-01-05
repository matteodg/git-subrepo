#!/usr/bin/env bash

# DO NOT EDIT. This file generated by pkg/bin/generate-help-functions.pl.

set -e

help:all() {
    cat <<'...'
branch               branch <subdir>|--all [-c] [-f] [-F]
clean                clean <subdir>|--all|--ALL [-f]
clone                clone <repository> [<subdir>] [-b <branch>] [-f] [-m <msg>] [-e] [--method <merge|rebase>]
commit               commit <subdir> [<subrepo-ref>] [-m <msg>] [-e] [-f] [-F]
config               config <subdir> <option> [<value>] [-f]
fetch                fetch <subdir>|--all [-r <remote>] [-b <branch>]
help                 help [<command>|--all]
init                 init <subdir> [-r <remote>] [-b <branch>] [--method <merge|rebase>]
pull                 pull <subdir>|--all [-f] [-m <msg>] [-e] [-b <branch>] [-r <remote>] [-u] [-c]
push                 push <subdir>|--all [<branch>] [-r <remote>] [-b <branch>] [-u] [-f] [-s] [-N] [-c]
status               status [<subdir>|--all|--ALL] [-F] [-q|-v]
upgrade              upgrade
version              version [-q|-v]
...
}

help:branch() {
    cat <<'...'

  Usage: git subrepo branch <subdir>|--all [-c] [-f] [-F]


  Create a branch with local subrepo commits.

  Scan the history of the mainline for all the commits that affect the `subdir`
  and create a new branch from them called `subrepo/<subdir>`.

  This is useful for doing `pull` and `push` commands by hand.

  Use the `--clean` option to write over an existing `subrepo/<subdir>` branch.
  Use the `--force` option to ignore missing commits.

  The `branch` command accepts the `--all`, `--clean`, `--fetch` and `--force`
  options.
...
}

help:clean() {
    cat <<'...'

  Usage: git subrepo clean <subdir>|--all|--ALL [-f]


  Remove artifacts created by `fetch` and `branch` commands.

  The `fetch` and `branch` operations (and other commands that call them)
  create temporary things like refs, branches and remotes. This command
  removes all those things.

  Use `--force` to remove refs. Refs are not removed by default because they
  are sometimes needed between commands.

  Use `--all` to clean up after all the current subrepos. Sometimes you might
  change to a branch where a subrepo doesn't exist, and then `--all` won't find
  it. Use `--ALL` to remove any artifacts that were ever created by subrepo.

  To remove ALL subrepo artifacts:

    git subrepo clean --ALL --force

  The `clean` command accepts the `--all`, `--ALL`, and `--force` options.
...
}

help:clone() {
    cat <<'...'

  Usage: git subrepo clone <repository> [<subdir>] [-b <branch>] [-f] [-m <msg>] [-e] [--method <merge|rebase>]


  Add a repository as a subrepo in a subdir of your repository.

  This is similar in feel to `git clone`. You just specify the remote repo
  url, and optionally a sub-directory and/or branch name. The repo will be
  fetched and merged into the subdir.

  The subrepo history is /squashed/ into a single commit that contains the
  reference information. This information is also stored in a special file
  called `<subdir>/.gitrepo`. The presence of this file indicates that the
  directory is a subrepo.

  All subsequent commands refer to the subrepo by the name of the /subdir/.
  From the subdir, all the current information about the subrepo can be
  obtained.

  The `--force` option will "reclone" (completely replace) an existing subdir.

  The `--method` option will decide how the join process between branches are
   performed. The default option is merge.

  The `clone` command accepts the `--branch=` `--edit`, `--force` and
  `--message=` options.
...
}

help:commit() {
    cat <<'...'

  Usage: git subrepo commit <subdir> [<subrepo-ref>] [-m <msg>] [-e] [-f] [-F]


  Add subrepo branch to current history as a single commit.

  This command is generally used after a hand-merge. You have done a `subrepo
  branch` and merged (rebased) it with the upstream. This command takes the
  HEAD of that branch, puts its content into the subrepo subdir and adds a new
  commit for it to the top of your mainline history.

  This command requires that the upstream HEAD be in the `subrepo/<subdir>`
  branch history. That way the same branch can push upstream. Use the
  `--force` option to commit anyway.

  The `commit` command accepts the `--edit`, `--fetch`, `--force` and
  `--message=` options.
...
}

help:config() {
    cat <<'...'

  Usage: git subrepo config <subdir> <option> [<value>] [-f]


  Read or update configuration values in the subdir/.gitrepo file.

  Because most of the values stored in the .gitrepo file are generated you
  will need to use `--force` if you want to change anything else then the
  `method` option.

  Example to update the `method` option for a subrepo:

    git subrepo config foo method rebase
...
}

help:fetch() {
    cat <<'...'

  Usage: git subrepo fetch <subdir>|--all [-r <remote>] [-b <branch>]


  Fetch the remote/upstream content for a subrepo.

  It will create a Git reference called `subrepo/<subdir>/fetch` that points at
  the same commit as `FETCH_HEAD`. It will also create a remote called
  `subrepo/<subdir>`. These are temporary and you can easily remove them with
  the subrepo `clean` command.

  The `fetch` command accepts the `--all`, `--branch=` and `--remote=` options.
...
}

help:help() {
    cat <<'...'

  Usage: git subrepo help [<command>|--all]


  Same as `git help subrepo`. Will launch the manpage. For the shorter usage,
  use `git subrepo -h`.

  Use `git subrepo help <command> to get help for a specific command. Use
  `--all` to get a summary of all commands.

  The `help` command accepts the `--all` option.
...
}

help:init() {
    cat <<'...'

  Usage: git subrepo init <subdir> [-r <remote>] [-b <branch>] [--method <merge|rebase>]


  Turn an existing subdirectory into a subrepo.

  If you want to expose a subdirectory of your project as a published subrepo,
  this command will do that. It will split out the content of a normal
  subdirectory into a branch and start tracking it as a subrepo. Afterwards
  your original repo will look exactly the same except that there will be a
  `<subdir>/.gitrepo` file.

  If you specify the `--remote` (and optionally the `--branch`) option, the
  values will be added to the `<subdir>/.gitrepo` file. The `--remote` option
  is the upstream URL, and the `--branch` option is the upstream branch to push
  to. These values will be needed to do a `git subrepo push` command, but they
  can be provided later on the `push` command (and saved to `<subdir>/.gitrepo`
  if you also specify the `--update` option to push).

  Note: You will need to create the empty upstream repo and push to it on your
  own, using `git subrepo push <subdir>`.

  The `--method` option will decide how the join process between branches
  are performed. The default option is merge.

  The `init` command accepts the `--branch=` and `--remote=` options.
...
}

help:pull() {
    cat <<'...'

  Usage: git subrepo pull <subdir>|--all [-f] [-m <msg>] [-e] [-b <branch>] [-r <remote>] [-u] [-c]


  Update the subrepo subdir with the latest upstream changes. If -b or -r
  is used, it will merge these changes. If you want to switch tracking
  you need to add -u as well.

  The `pull` command fetches the latest content from the remote branch pointed
  to by the subrepo's `.gitrepo` file, and then tries to merge the changes into
  the corresponding subdir. It does this by making a branch of the local
  commits to the subdir and then merging or rebasing (see below) it with the
  fetched upstream content. After the merge, the content of the new branch
  replaces your subdir, the `.gitrepo` file is updated and a single 'pull'
  commit is added to your mainline history.

  The `pull` command will attempt to do the following commands in one go:

    git subrepo fetch <subdir>
    git subrepo branch <subdir>
    git merge/rebase subrepo/<subdir>/fetch subrepo/<subdir>
    git subrepo commit <subdir>
    # Only needed for a consequential push:
    git update-ref refs/subrepo/<subdir>/pull subrepo/<subdir>

  In other words, you could do all the above commands yourself, for the same
  effect. If any of the commands fail, subrepo will stop and tell you to finish
  this by hand. Generally a failure would be in the merge or rebase part, where
  conflicts can happen. Since Git has lots of ways to resolve conflicts to your
  personal tastes, the subrepo command defers to letting you do this by hand.

  When pulling new data, the method selected in clone/init is used. This has
  no effect on the final result of the pull, since it becomes a single commit.
  But it does affect the resulting `subrepo/<subdir>` branch, which is often
  used for a subrepo `push` command. See 'push' below for more information.
  If you want to change the method you can use the `config` command for this.

  When you pull you can assume a fast-forward strategy (default) or you can
  specify a `--rebase` or `--merge` strategy.

  If you want to pull in changes tat doesn't have the previous changes in
  history, you can use `--force`. It will ignore the requirement of having
  previous commits available.

  Like the `clone` command, `pull` will squash all the changes (since the last
  pull or clone) into one commit. This keeps your mainline history nice and
  clean. You can easily see the subrepo's history with the `git log` command:

    git log refs/subrepo/<subdir>/fetch

  The set of commands used above are described in detail below.

  The `pull` command accepts the `--all`, `--branch=`, `--clean`, --edit`,
  `--force`, `--message=`, `--remote=`, `--squash` and `--update` options.
...
}

help:push() {
    cat <<'...'

  Usage: git subrepo push <subdir>|--all [<branch>] [-r <remote>] [-b <branch>] [-u] [-f] [-s] [-N] [-c]


  Push a properly merged subrepo branch back upstream.

  This command takes the subrepo branch from a successful pull command and
  pushes the history back to its designated remote and branch. You can also use
  the `branch` command and merge things yourself before pushing if you want to
  (although that is probably a rare use case).

  The `push` command requires a branch that has been properly merged/rebased
  with the upstream HEAD (unless the upstream HEAD is empty, which is common
  when doing a first `push` after an `init`). That means the upstream HEAD is
  one of the commits in the branch.

  By default the branch ref `refs/subrepo/<subdir>/pull` will be pushed, but
  you can specify a (properly merged) branch to push.

  After that, the `push` command just checks that the branch contains the
  upstream HEAD and then pushes it upstream.

  The `--force` option will do a force push. Force pushes are typically
  discouraged. Only use this option if you fully understand it. (The `--force`
  option will NOT check for a proper merge. ANY branch will be force pushed!)

  The `push` command accepts the `--all`, `--branch=`, `--clean`, `--dry-run`,
  `--force`, `--remote=`, `--squash` and `--update` options.
...
}

help:status() {
    cat <<'...'

  Usage: git subrepo status [<subdir>|--all|--ALL] [-F] [-q|-v]


  Get the status of a subrepo. Uses the `--all` option by default. If the
  `--quiet` flag is used, just print the subrepo names, one per line.

  The `--verbose` option will show all the recent local and upstream commits.

  Use `--ALL` to show the subrepos of the subrepos (ie the "subsubrepos"), if
  any.

  The `status` command accepts the `--all`, `--ALL`, `--fetch`, `--quiet` and
  `--verbose` options.
...
}

help:upgrade() {
    cat <<'...'

  Usage: git subrepo upgrade


  Upgrade the `git-subrepo` software itself. This simply does a `git pull` on
  the git repository that the code is running from. It only works if you are on
  the `master` branch. It won't work if you installed `git-subrepo` using `make
  install`; in that case you'll need to `make install` from the latest code.
...
}

help:version() {
    cat <<'...'

  Usage: git subrepo version [-q|-v]


  This command will display version information about git-subrepo and its
  environment. For just the version number, use `git subrepo --version`. Use
  `--verbose` for more version info, and `--quiet` for less.

  The `version` command accepts the `--quiet` and `--verbose` options.
...
}

# vim: set sw=2 lisp:
