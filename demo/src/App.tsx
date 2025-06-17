import { useQuery, useMutation, useSubscription, gql } from '@apollo/client'
import { useState, useEffect } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'

const GET_POSTS = gql`
  query GetPosts {
    posts {
      count
      results {
        id
        title
        text
      }
    }
  }
`

const CREATE_POST = gql`
  mutation CreatePost($input: CreatePostInput!) {
    createPost(input: $input) {
      result {
        id
        text
        title
      }
    }
  }
`

const POST_CHANGED_SUBSCRIPTION = gql`
  subscription PostChanged {
    postChanged {
      created {
        id
        text
        title
      }
    }
  }
`

function App() {
  const { loading, error, data, refetch, updateQuery } = useQuery(GET_POSTS)
  const [createPost, { loading: creating }] = useMutation(CREATE_POST)
  const { data: subscriptionData } = useSubscription(POST_CHANGED_SUBSCRIPTION)
  const [title, setTitle] = useState('')
  const [text, setText] = useState('')

  useEffect(() => {
    if (subscriptionData?.postChanged?.created) {
      const newPost = subscriptionData.postChanged.created
      updateQuery((prev) => ({
        posts: {
          ...prev.posts,
          count: prev.posts.count + 1,
          results: [newPost, ...prev.posts.results]
        }
      }))
    }
  }, [subscriptionData, updateQuery])

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!title.trim() || !text.trim()) return

    try {
      await createPost({
        variables: {
          input: {
            title: title.trim(),
            text: text.trim()
          }
        }
      })
      setTitle('')
      setText('')
    } catch (err) {
      console.error('Error creating post:', err)
    }
  }

  if (loading) return <p>Loading posts...</p>
  if (error) return <p>Error: {error.message}</p>

  return (
    <>
      <div>
        <a href="https://vite.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite + React + GraphQL</h1>
      
      <div className="card">
        <h2>Create New Post</h2>
        <form onSubmit={handleSubmit} style={{ marginBottom: '20px' }}>
          <div style={{ marginBottom: '10px' }}>
            <input
              type="text"
              placeholder="Post title"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              style={{ width: '100%', padding: '8px', marginBottom: '8px' }}
            />
          </div>
          <div style={{ marginBottom: '10px' }}>
            <textarea
              placeholder="Post text"
              value={text}
              onChange={(e) => setText(e.target.value)}
              rows={4}
              style={{ width: '100%', padding: '8px' }}
            />
          </div>
          <button 
            type="submit" 
            disabled={creating || !title.trim() || !text.trim()}
            style={{ padding: '10px 20px' }}
          >
            {creating ? 'Creating...' : 'Create Post'}
          </button>
        </form>
      </div>

      <div className="card">
        <h2>Posts ({data?.posts?.count || 0})</h2>
        {data?.posts?.results?.map((post: any) => (
          <div key={post.id} style={{ border: '1px solid #ccc', margin: '10px', padding: '10px' }}>
            <h3>{post.title}</h3>
            <p>{post.text}</p>
            <small>ID: {post.id}</small>
          </div>
        ))}
      </div>
      <p className="read-the-docs">
        Click on the Vite and React logos to learn more
      </p>
    </>
  )
}

export default App
