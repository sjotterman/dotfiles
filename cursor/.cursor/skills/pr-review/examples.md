# Comment tone

Read this only if unsure how to write an item. The GitHub comment should be
easy to follow for the PR author and the reviewer. Do not paste these samples
into a review.

## Good — repeated issue, once

### 1. Throw `TokenInvalidError` from the HTTP client, then delete the per-hook logout effects

In [`app/hooks/useEmployees.ts`](https://example.com/blob/useEmployees.ts) the
query throws on `'Token is not valid'` and a `useEffect` on `query.error` calls
`logout()`. Same in `useDevices.ts`, `useRequests.ts`, and more (~25 hooks).

A cached error can snackbar or log out again on remount, and a prefetch that
never mounts these hooks never logs out. One owner on the client (throw a
typed error, handle it in the cache `onError`) is enough to fix the class of
issue; the rest of the hooks can follow that template.

Caveat: a failed **login** using the same client must not trigger logout. Gate
the handler on "already authenticated", and/or skip it on the login route.

Why this works: one place to change, a few extra paths to grep, "and more"
instead of 25 near-identical bullets. A reader who did not sit in the review
can still act.

## Bad — every file, or insider shorthand

- `useEmployees.ts:76` TOKEN_INVALID effect
- `useDevices.ts:81` TOKEN_INVALID effect
- `useRequests.ts:54` TOKEN_INVALID effect
- *(…twenty more files…)*

Or: "P1 the RQ onError vs saga carve-out; see the cutover notes."

Why this fails: a full inventory is noise, and jargon only the reviewer
already understands does not tell the author what to change or why.
