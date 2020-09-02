This is a dummy TypeScript repo with 3 packages.

- `a` depends on `c`.
- `b` depends on `c`.
- `a` and `b` are small.
- `c` is huge.

In theory, tsserver should be able to load `b` quickly after it's spent the
time to load `a` and resolve `c`. Unfortunately it takes several seconds as of
now.

## Usage

`test.sh` loads `a` and then `b`. tsserver output is dumped to `tsserver-*.log`
and timings are parsed if `ripgrep` is installed.

```sh
$ ./test.sh /Volumes/git/TypeScript/built/local/tsserver.js
```
