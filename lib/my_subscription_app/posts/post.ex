defmodule MySubscriptionApp.Posts.Post do
  use Ash.Resource,
    otp_app: :my_subscription_app_sqlite,
    domain: MySubscriptionApp.Posts,
    data_layer: AshSqlite.DataLayer,
    extensions: [AshGraphql.Resource]

  sqlite do
    table "posts"
    repo MySubscriptionAppSqlite.Repo
  end

  graphql do
    type :post

    queries do
      get :post, :read
      list :posts, :read
    end

    mutations do
      create :create_post, :create
      update :update_post, :update
    end

    subscriptions do
      pubsub MySubscriptionAppSqliteWeb.Endpoint

      subscribe :post_changed do
        action_types [:create, :update]
      end

    end

  end

  actions do
    default_accept :*
    defaults [:create, :read, :update]
  end

  attributes do
    uuid_v7_primary_key :id

    attribute :title, :string do
      allow_nil? false
      public? true
    end

    attribute :text, :string do
      allow_nil? false
      public? true
    end
  end
end
