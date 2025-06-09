defmodule MySubscriptionAppSqlite.Repo do
  use AshSqlite.Repo,
    otp_app: :my_subscription_app_sqlite
end
