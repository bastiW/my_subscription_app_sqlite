defmodule MySubscriptionApp.Posts do
  use Ash.Domain, otp_app: :my_subscription_app_sqlite, extensions: [AshGraphql.Domain]

  resources do
    resource MySubscriptionApp.Posts.Post
  end
end
