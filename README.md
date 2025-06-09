# MySubscriptionAppSqlite

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## GraphQL API

This application provides a GraphQL API for managing posts with real-time subscriptions.

### Create a Post

Use this mutation to create a new post:

```graphql
mutation CreatePost($input: CreatePostInput!) {
  createPost(input: $input) {
    result {
      id
      title
      text
    }
  }
}
```

With variables:
```json
{
  "input": {
    "title": "Big anouncement",
    "text": "My second post"
  }
}
```

### Subscribe to Post Changes

Use this subscription to receive real-time updates when posts are created or updated:

```graphql
subscription PostChanged {
  postChanged {
    created {
      id
      title
    }
    updated {
      id
      title
    }
  }
}
```

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
