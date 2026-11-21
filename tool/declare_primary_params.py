#!/usr/bin/env python3
"""Second step of the primary-constructor migration.

`dart fix --apply --code=use_primary_constructors` moves the constructor into the
class header but keeps `this.x` plus a separate `final T x;`. This merges them
into one declaring parameter: `final T x` (Dart 3.13+).

Skips a field when it has a doc comment or annotation above it (the comment
would be orphaned), is not a plain `final T name;`, or is not initialised by a
`this.name` parameter. Safe to re-run. Usage: tool/declare_primary_params.py <files...>
"""
import re
import sys

HEADER = re.compile(r'^(?P<pre>[ \t]*(?:@\w+(?:\([^)]*\))?\s*)*(?:(?:abstract|sealed|base|final|interface|mixin)\s+)*class\s+(?:const\s+)?\w+(?:<[^>{]*>)?)\(', re.M)


def match_paren(s, i):
    """Index of the ')' matching the '(' at s[i]."""
    depth = 0
    for j in range(i, len(s)):
        c = s[j]
        if c == '(':
            depth += 1
        elif c == ')':
            depth -= 1
            if depth == 0:
                return j
    return -1


def class_body(s, start):
    """(open, close) of the `{ ... }` body after position start, or None if `;`."""
    j = start
    while j < len(s) and s[j] not in '{;':
        j += 1
    if j >= len(s) or s[j] == ';':
        return None
    depth = 0
    for k in range(j, len(s)):
        if s[k] == '{':
            depth += 1
        elif s[k] == '}':
            depth -= 1
            if depth == 0:
                return j, k
    return None


def migrate(src):
    out = src
    pos = 0
    changed = False
    while True:
        m = HEADER.search(out, pos)
        if not m:
            break
        open_i = m.end() - 1
        close_i = match_paren(out, open_i)
        if close_i < 0:
            pos = m.end()
            continue
        params = out[open_i + 1:close_i]
        body = class_body(out, close_i + 1)
        if not body:
            pos = close_i
            continue
        b0, b1 = body
        body_text = out[b0 + 1:b1]
        lines = body_text.split('\n')
        new_params = params
        keep = []
        removed = set()
        for pm in re.finditer(r'this\.(\w+)', params):
            name = pm.group(1)
            fpat = re.compile(r'^\s*final\s+([^;=\n]+?)\s+' + re.escape(name) + r'\s*;\s*$')
            for idx, line in enumerate(lines):
                fm = fpat.match(line)
                if not fm or idx in removed:
                    continue
                prev = lines[idx - 1].strip() if idx > 0 else ''
                if prev.startswith('///') or prev.startswith('@') or prev.startswith('//'):
                    break  # keep field + this.x: don't orphan a comment
                new_params = re.sub(r'this\.' + re.escape(name) + r'\b', 'final ' + fm.group(1) + ' ' + name, new_params, count=1)
                removed.add(idx)
                break
        if not removed:
            pos = close_i
            continue
        lines = [l for i, l in enumerate(lines) if i not in removed]
        new_body = '\n'.join(lines)
        # collapse an empty body to `;`
        if new_body.strip() == '':
            tail = out[close_i + 1:b0]
            out = out[:open_i + 1] + new_params + ')' + tail.rstrip() + ';' + out[b1 + 1:]
        else:
            out = out[:open_i + 1] + new_params + out[close_i:b0 + 1] + new_body + out[b1:]
        changed = True
        pos = open_i + 1
    return out, changed


for path in sys.argv[1:]:
    text = open(path).read()
    new, changed = migrate(text)
    if changed:
        open(path, 'w').write(new)
        print('migrated', path)
