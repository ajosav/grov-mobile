# Offline

The app must be useful without a network. Drift is the copy of record for catalogue, plan and household; the server is authoritative for totals and states.

## Pattern: cache-then-refresh

1. Repository emits what Drift has now (a `watch` stream).
2. If online (or stale), fetch, then write to Drift in one transaction and stamp `CacheDao.put(key, payload, now)`. The stream re-emits.
3. On failure, keep showing cached data and surface `last synced`; do not blank the screen.

Offline is neutral: sunken `AppBanner`, "Offline · last synced 7:40am". Never red, never an error dialog. The banner says what still works and what needs a connection.

Network-only actions (checkout, Add money, sign-on) are disabled with a stated reason ("Checkout needs a connection"), never hidden.

## Drift rules

- Tables in `core/database/tables`, DAOs in `core/database/daos` (`@DriftAccessor`). Only `data` layers and `core/database` import Drift.
- Money columns are `integer` kobo. No `real` for money or quantity.
- Schema change: bump `schemaVersion`, add `onUpgrade` with `stepByStep`/explicit migrations, add a migration test that opens the old schema. Never edit a shipped migration.
- Generated drift schema dumps: `dart run drift_dev schema dump` before the first release and on every bump.
- The DB opens lazily on a background isolate (WAL). Do not call it before the first frame. Do not open a second instance.
- Large writes use `batch`. Reads that feed lists select only the columns drawn.

## Device settings vs account preferences

Different stores. Device settings (appearance, low-end mode, remembered email) live in `device_settings`, survive logout, and are never sent to the server. Account preferences (household, exclusions, notifications) are server-owned, Drift-cached, and cleared on logout.

## Drafts (resume)

`DraftsDao` keeps route, step and non-secret fields for sign-on, plan set-up, basket/checkout, cook order, address. Never passwords, OTPs, identity tokens, card data. Delete on success, on discard, and on logout for account flows.

## Secrets

Access and refresh tokens: `flutter_secure_storage` only. Not Drift, not SharedPreferences, not logs.
