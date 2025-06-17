import { useQuery, gql } from '@apollo/client'
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

function App() {
  const { loading, error, data } = useQuery(GET_POSTS)

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
